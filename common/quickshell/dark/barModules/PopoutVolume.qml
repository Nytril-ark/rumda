import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Widgets
import Quickshell.Io
import qs.dark.config

Scope {
  id: root

  readonly property PwNode sink: Pipewire.defaultAudioSink
  readonly property bool muted: sink?.audio?.muted ?? false
  readonly property real volume: sink?.audio?.volume ?? 0
  property bool shouldShowOsd: false
  property real lastVolume: 0

  readonly property int osdWidth: 200
  readonly property int osdHeight: 36
  readonly property int osdRadius: 7
  readonly property int osdBorderWidth: 2

  readonly property int hideDelay: 1000
  readonly property int showDuration: 400
  readonly property int hideDuration: 300
  readonly property int volumeAnimDuration: 150

  PwObjectTracker {
    objects: [Pipewire.defaultAudioSink]
  }

  Connections {
    target: Pipewire.defaultAudioSink?.audio
    function onVolumeChanged() {
      root.shouldShowOsd = true;
      hideTimer.restart();
    }
  }

  Timer {
    id: hideTimer
    interval: root.hideDelay
    onTriggered: root.shouldShowOsd = false
  }

  onVolumeChanged: {
    if (Math.abs(volume - lastVolume) > 0.01) {
      bounceAnimation.start();
      lastVolume = volume;
    }
  }

  SequentialAnimation {
    id: bounceAnimation
    PropertyAnimation {
      target: popoutVolume.item
      property: "anchors.bottomMargin"
      to: -8
      duration: 120
      easing.type: Easing.OutBack
    }
    PropertyAnimation {
      target: popoutVolume.item
      property: "anchors.bottomMargin"
      to: 10
      duration: 180
      easing.type: Easing.InOutBounce
    }
    PropertyAnimation {
      target: popoutVolume.item
      property: "anchors.bottomMargin"
      to: -4
      duration: 140
      easing.type: Easing.OutBounce
    }
    PropertyAnimation {
      target: popoutVolume.item
      property: "anchors.bottomMargin"
      to: 6
      duration: 100
      easing.type: Easing.InOutQuad
    }
    PropertyAnimation {
      target: popoutVolume.item
      property: "anchors.bottomMargin"
      to: 0
      duration: 160
      easing.type: Easing.OutElastic
    }
  }

  LazyLoader {
    id: popoutVolume
    active: root.shouldShowOsd

    PanelWindow {
      exclusionMode: ExclusionMode.Ignore
      anchors.bottom: true
      margins.bottom: screen.height / 12
      implicitWidth: root.osdWidth
      implicitHeight: root.osdHeight
      color: "transparent"

      MouseArea {
        anchors.fill: parent

        onClicked: {
          if (sink)
            sink.audio.muted = !root.muted;
        }

        onWheel: wheel => {
          if (sink && !root.muted) {
            const delta = wheel.angleDelta.y > 0 ? 0.1 : -0.1;
            const newVolume = Math.max(0, Math.min(1, root.volume + delta));
            sink.audio.volume = newVolume;
          }
        }
      }

      Rectangle {
        id: osdContainer
        anchors.fill: parent
        radius: root.osdRadius
        color: Colors.backgroundColor
        border.width: root.osdBorderWidth
        border.color: Colors.borderColor

        transform: [
          Scale {
            id: scaleTransform
            origin.x: osdContainer.width / 2
            origin.y: osdContainer.height / 2
            xScale: root.shouldShowOsd ? 1.0 : 0.4
            yScale: root.shouldShowOsd ? 1.0 : 0.4

            Behavior on xScale {
              PropertyAnimation {
                duration: root.shouldShowOsd ? root.showDuration : root.hideDuration
                easing.type: root.shouldShowOsd ? Easing.OutBack : Easing.InBack
              }
            }
            Behavior on yScale {
              PropertyAnimation {
                duration: root.shouldShowOsd ? root.showDuration : root.hideDuration
                easing.type: root.shouldShowOsd ? Easing.OutBack : Easing.InBack
              }
            }
          },
          Translate {
            id: translateTransform
            y: root.shouldShowOsd ? 0 : 100

            Behavior on y {
              PropertyAnimation {
                duration: root.shouldShowOsd ? root.showDuration : root.hideDuration
                easing.type: root.shouldShowOsd ? Easing.OutBack : Easing.InBack
              }
            }
          }
        ]

        SequentialAnimation {
          id: endWiggle
          running: false

          PauseAnimation {
            duration: 450
          }

          SequentialAnimation {
            loops: 2

            PropertyAnimation {
              target: scaleTransform
              properties: "xScale,yScale"
              to: 1.05
              duration: 100
              easing.type: Easing.InOutSine
            }

            PropertyAnimation {
              target: scaleTransform
              properties: "xScale,yScale"
              to: 1.0
              duration: 100
              easing.type: Easing.InOutSine
            }
          }
        }

        onVisibleChanged: {
          if (visible && root.shouldShowOsd) {
            endWiggle.start();
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
            opacity: root.muted ? 0.6 : 1.0
          }

          Rectangle {
            id: volumeBarBg
            color: Colors.indicatorBGColor
            Layout.fillWidth: true
            implicitHeight: 10
            radius: 2

            Rectangle {
              id: volumeBarFill
              radius: 2
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
