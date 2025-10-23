import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Services.UPower
import Quickshell.Services.SystemTray
import Quickshell.Services.Pipewire
import Quickshell.Services.Mpris
import Qt5Compat.GraphicalEffects

Rectangle {
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

  Layout.alignment: Qt.AlignHCenter
  width: 28
  height: 78
  radius: 7
  color: moduleBG 

  border.width: 1
  border.color: borderColor 

  readonly property PwNode sink: Pipewire.defaultAudioSink

  property bool muted: sink?.audio?.muted ?? false
  property real volume: sink?.audio?.volume ?? 0
  property real currentVolume: 0.5
  property real lastVolume: 0

  
  PwObjectTracker {
    id: pwObjectTracker
    objects: [Pipewire.defaultAudioSink, Pipewire.defaultAudioSource]
  }

  SequentialAnimation {
    id: bounceAnimation
    PropertyAnimation {
      target: volumeBar
      property: "anchors.bottomMargin"
      to: -8
      duration: 120
      easing.type: Easing.OutBack
    }
    PropertyAnimation {
      target: volumeBar
      property: "anchors.bottomMargin"
      to: 10
      duration: 180
      easing.type: Easing.InOutBounce
    }
    PropertyAnimation {
      target: volumeBar
      property: "anchors.bottomMargin"
      to: -4
      duration: 140
      easing.type: Easing.OutBounce
    }
    PropertyAnimation {
      target: volumeBar
      property: "anchors.bottomMargin"
      to: 6
      duration: 100
      easing.type: Easing.InOutQuad
    }
    PropertyAnimation {
      target: volumeBar
      property: "anchors.bottomMargin"
      to: 0
      duration: 160
      easing.type: Easing.OutElastic
    }
  }

  onVolumeChanged: {
    if (Math.abs(volume - lastVolume) > 0.01) {
      bounceAnimation.start()
      lastVolume = volume
    }
  }

  ColumnLayout {
    anchors.centerIn: parent
    spacing: 6

    // Speaker icon
    Rectangle {
      Layout.alignment: Qt.AlignHCenter
      width: 14
      height: 14
      color: "transparent"

      Image {
        anchors.fill: parent
        fillMode: Image.PreserveAspectFit
        source: `file:///home/${username}/.config/rumda/light-config/quickshell/icons/${muted ? 'speaker-dark' : 'speaker'}.svg`
        opacity: muted ? 0.6 : 1.0
        antialiasing: true
        smooth: true
        mipmap: true
      }
    }

    // Volume bar (vertical)
    Rectangle {
      id: volumeBar
      Layout.alignment: Qt.AlignHCenter
      Layout.bottomMargin: 4
      width: 8
      height: 46
      color:  indicatorBGColor
      radius: 2

      Rectangle {
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width
        height: {
          let len = muted ? 1 : parent.height * volume;
          return (len > 42) ? 42 : len;
        }
        radius: 1
        gradient: Gradient {
          orientation: Gradient.Vertical
          GradientStop { position: 0; color: accent2Color }
          GradientStop { position: 1; color: gradientAccent2Color }
        }

        Behavior on height {
          NumberAnimation {
            duration: 150
            easing.type: Easing.OutCubic
          }
        }
      }
    }
  }

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
}
