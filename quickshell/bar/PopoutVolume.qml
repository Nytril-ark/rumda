import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Widgets
import Quickshell.Io

Scope {
  id: root
  
  property color backgroundColor: "#E4C198" //bar color
  property color indicatorBGColor: "#AF8C65"
  property color borderColor: "#D1AB86"
  property color moduleBG: "#DAB08B"
  property color accentColor: "#6F4732"
  property color accent2Color: "#9F684C"
  property color gradientAccent2Color: "#a87358" //bottom / right of volume bar
  property color errorColor: "#9A4235"
  property color backgroundTransparent: "#661e1e1e"
  property color shadowColor: "#3A2D26"
  property string username: ""
  property real lastVolume: 0

  Process {
    command: ["whoami"]
    running: true
    stdout: SplitParser { onRead: name => username = name }
  }

  readonly property PwNode sink: Pipewire.defaultAudioSink
  property bool muted: sink?.audio?.muted ?? false
  property real volume: sink?.audio?.volume ?? 0
  property bool shouldShowOsd: false

  // Bind the pipewire node so its volume will be tracked
  PwObjectTracker {
    objects: [ Pipewire.defaultAudioSink ]
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
    interval: 1000
    onTriggered: root.shouldShowOsd = false
  }

  onVolumeChanged: {
    if (Math.abs(volume - lastVolume) > 0.01) {
      bounceAnimation.start()
      lastVolume = volume
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
      anchors.bottom: true
      margins.bottom: screen.height / 12
      implicitWidth: 200
      implicitHeight: 36
      color: "transparent"

      MouseArea {
        anchors.fill: parent

        onClicked: { sink.audio.muted = !muted; }

        onWheel: wheel => {
          if (sink && !muted) {
            let delta = wheel.angleDelta.y > 0 ? 0.1 : -0.1
            let newVolume = volume + delta
            newVolume = Math.max(0, Math.min(1, newVolume))
            sink.audio.volume = newVolume
          }
        }
      }

      Rectangle {
        id: mainRect
        anchors.fill: parent
        radius: 7
        color: backgroundColor 

        border.width: 2
        border.color: borderColor 

        property real yOffset: 0

        transform: [
          Scale {
            id: scaleTransform
            origin.x: mainRect.width / 2
            origin.y: mainRect.height / 2
            xScale: root.shouldShowOsd ? 1.0 : 0.4
            yScale: root.shouldShowOsd ? 1.0 : 0.4

            Behavior on xScale {
              PropertyAnimation {
                duration: root.shouldShowOsd ? 400 : 300
                easing.type: root.shouldShowOsd ? Easing.OutBack : Easing.InBack
              }
            }

            Behavior on yScale {
              PropertyAnimation {
                duration: root.shouldShowOsd ? 400 : 300
                easing.type: root.shouldShowOsd ? Easing.OutBack : Easing.InBack
              }
            }
          },
          Translate {
            id: translateTransform
            y: root.shouldShowOsd ? 0 : 100

            Behavior on y {
              PropertyAnimation {
                duration: root.shouldShowOsd ? 400 : 300
                easing.type: root.shouldShowOsd ? Easing.OutBack : Easing.InBack
              }
            }
          }
        ]

        SequentialAnimation {
          id: endWiggle
          running: false

          PauseAnimation { duration: 450 }

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
            endWiggle.start()
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
            source: `file:///home/${username}/.config/rumda/quickshell/icons/${muted ? 'speaker-dark' : 'speaker'}.svg`
            opacity: muted ? 0.6 : 1.0
          }

          Rectangle {
            color: indicatorBGColor 
            Layout.fillWidth: true
            implicitHeight: 10
            radius: 2

            Rectangle {
              radius: 2
              anchors {
                left: parent.left
                top: parent.top
                bottom: parent.bottom
              }
              gradient: Gradient {
                orientation: Gradient.Horizontal
                GradientStop { position: 0; color: accentColor }
                GradientStop { position: 1; color: accent2Color }
              }

              width: {
                let len = muted ? 1 : parent.width * (Pipewire.defaultAudioSink?.audio.volume ?? 0);
                return Math.min(len, parent.width);
              }

              Behavior on width {
                PropertyAnimation {
                  duration: 150
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
