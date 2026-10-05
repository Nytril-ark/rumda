import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Widgets
import qs.dark.config

Scope {
  id: root

  readonly property PwNode sink: Pipewire.defaultAudioSink
  readonly property bool muted: sink?.audio?.muted ?? false
  readonly property real volume: sink?.audio?.volume ?? 0
  property bool shouldShowOsd: false
  property bool windowActive: false

  readonly property int osdWidth: 200
  readonly property int osdHeight: 36
  readonly property int osdRadius: 0
  readonly property int osdBorderWidth: 1
  readonly property int osdBottomMargin: 80
  readonly property int osdPad: 8

  readonly property real startScale: 0.7
  readonly property real overshoot: 0.0
  readonly property real wiggleScale: 1.0

  readonly property int hideDelay: 1000
  readonly property int showDuration: 400
  readonly property int hideDuration: 300
  readonly property int volumeAnimDuration: 150

  onShouldShowOsdChanged: {
    if (shouldShowOsd) {
      unloadTimer.stop();
      windowActive = true;
    } else {
      unloadTimer.restart();
    }
  }

  PwObjectTracker {
    objects: [Pipewire.defaultAudioSink]
  }

  Connections {
    target: Pipewire.defaultAudioSink?.audio

    function onVolumeChanged() {
      root.shouldShowOsd = true;
      hideTimer.restart();
    }

    function onMutedChanged() {
      root.shouldShowOsd = true;
      hideTimer.restart();
    }
  }

  Timer {
    id: hideTimer
    interval: root.hideDelay
    onTriggered: root.shouldShowOsd = false
  }

  Timer {
    id: unloadTimer
    interval: root.hideDuration + 50
    onTriggered: root.windowActive = false
  }

  LazyLoader {
    active: root.windowActive

    PanelWindow {
      id: win

      property bool shown: false

      readonly property int fullWidth: root.osdWidth + Config.popoutVolShadowOffsetX + root.osdPad * 2
      readonly property int fullHeight: root.osdHeight + Config.popoutVolShadowOffsetY + root.osdPad * 2

      exclusionMode: ExclusionMode.Ignore
      anchors.bottom: true
      margins.bottom: shown ? root.osdBottomMargin - root.osdPad : -fullHeight - 20

      Behavior on margins.bottom {
        PropertyAnimation {
          duration: win.shown ? root.showDuration : root.hideDuration
          easing.type: win.shown ? Easing.OutCubic : Easing.InCubic
        }
      }

      implicitWidth: fullWidth
      implicitHeight: fullHeight
      color: "transparent"

      Component.onCompleted: Qt.callLater(() => {
        win.shown = Qt.binding(() => root.shouldShowOsd);
      })

      onShownChanged: {
        if (shown)
          endWiggle.restart();
        else
          endWiggle.stop();
      }

      MouseArea {
        anchors.fill: osdContainer

        onClicked: {
          if (root.sink)
            root.sink.audio.muted = !root.muted;
        }

        onWheel: wheel => {
          if (root.sink && !root.muted) {
            const delta = wheel.angleDelta.y > 0 ? 0.1 : -0.1;
            root.sink.audio.volume = Math.max(0, Math.min(1, root.volume + delta));
          }
        }
      }

      Rectangle {
        id: osdContainer
        x: root.osdPad
        y: root.osdPad
        width: root.osdWidth
        height: root.osdHeight
        radius: root.osdRadius
        color: Colors.backgroundColor
        border.width: root.osdBorderWidth
        border.color: Colors.borderColor

        Rectangle {
          x: Config.popoutVolShadowOffsetX
          y: Config.popoutVolShadowOffsetY
          width: parent.width
          height: parent.height
          radius: root.osdRadius
          color: Colors.shadowColor
          z: -1
        }

        transform: Scale {
          id: scaleTransform
          origin.x: osdContainer.width / 2
          origin.y: osdContainer.height / 2
          xScale: win.shown ? 1.0 : root.startScale
          yScale: win.shown ? 1.0 : root.startScale

          Behavior on xScale {
            PropertyAnimation {
              duration: win.shown ? root.showDuration : root.hideDuration
              easing.type: win.shown ? Easing.OutBack : Easing.InBack
              easing.overshoot: root.overshoot
            }
          }

          Behavior on yScale {
            PropertyAnimation {
              duration: win.shown ? root.showDuration : root.hideDuration
              easing.type: win.shown ? Easing.OutBack : Easing.InBack
              easing.overshoot: root.overshoot
            }
          }
        }

        SequentialAnimation {
          id: endWiggle

          PauseAnimation {
            duration: 450
          }

          PropertyAnimation {
            target: scaleTransform
            properties: "xScale,yScale"
            to: root.wiggleScale
            duration: 120
            easing.type: Easing.InOutSine
          }

          PropertyAnimation {
            target: scaleTransform
            properties: "xScale,yScale"
            to: 1.0
            duration: 120
            easing.type: Easing.InOutSine
          }
        }

        RowLayout {
          anchors {
            fill: parent
            leftMargin: 10
            rightMargin: 15
          }

          IconImage {
            implicitSize: 20
            source: `file://${Config.configPath}/dark/icons/${root.muted ? 'speaker-dark' : 'speaker'}.svg`
            opacity: root.muted ? 0.6 : 1.0
          }

          Rectangle {
            id: volumeBarBg
            color: Colors.indicatorBGColor
            Layout.fillWidth: true
            implicitHeight: 10
            radius: root.osdRadius

            Rectangle {
              id: volumeBarFill
              radius: root.osdRadius
              anchors {
                left: parent.left
                top: parent.top
                bottom: parent.bottom
              }

              gradient: Gradient {
                orientation: Gradient.Horizontal
                GradientStop {
                  position: 0
                  color: Colors.accentColor
                }
                GradientStop {
                  position: 1
                  color: Colors.accent2Color
                }
              }

              width: {
                const volumeWidth = root.muted ? 1 : volumeBarBg.width * root.volume;
                return Math.min(volumeWidth, volumeBarBg.width);
              }

              Behavior on width {
                PropertyAnimation {
                  duration: root.volumeAnimDuration
                  easing.type: Easing.OutQuad
                }
              }
            }
          }
        }
      }
    }
  }
}
