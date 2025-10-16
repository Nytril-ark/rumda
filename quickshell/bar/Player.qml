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
  id: playerModule
  Layout.alignment: Qt.AlignHCenter
  implicitHeight: playing ? 120 : 28
  layer.enabled: true
  width: 28
  radius: innerModulesRadius
  color: "#111A1F"

  border.width: 1
  border.color: "#171F24"

  property bool playing: false
  property string artUrl: ''

  Process { id: playerPrev; running: false; command: [ "playerctl", "previous" ] }
  Process { id: playerPlayPause; running: false; command: [ "playerctl", "play-pause" ] }
  Process { id: playerNext; running: false; command: [ "playerctl", "next" ] }

  Process {
    id: statusUpdater
    running: true
    command: [ "playerctl", "status" ]
    stdout: SplitParser {
      onRead: s => {
        if (s === "Playing") {
          playing = true;
          if (artUrl === '') { artUrl = `file:///home/${username}/.config/rumda/quickshell/icons/player-background.png` }
        } else playing = false
      }
    }
  }

  Process {
    id: artUrlUpdater
    running: true
    command: [ "playerctl", "metadata", "mpris:artUrl" ]
    stdout: SplitParser {
      onRead: art => {
        if (art && art.trim() !== "") { artUrl = art.trim() }
        else { artUrl = `file:///home/${username}/.config/rumda/quickshell/icons/player-background.png` }
      }
    }

    stderr: SplitParser {
      onRead: err => {
        if (err === "No player could handle this command")
          artUrl = `file:///home/${username}/.config/rumda/quickshell/icons/player-background.png`
      }
    }
  }

  Timer {
    interval: 600
    running: true
    repeat: true
    onTriggered: { artUrlUpdater.running = true }
  }

  Timer {
    interval: 4000
    running: true
    repeat: true
    onTriggered: { statusUpdater.running = true }
  }

  MouseArea {
    anchors.fill: parent
    acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton

    // so the parent handler doesn't trigger here
    onWheel: () => {}

    onClicked: (mouse) => {
      if (mouse.button === Qt.LeftButton) { playerPrev.running = true; }
      else if (mouse.button === Qt.RightButton) { playerNext.running = true; }
      else if (mouse.button === Qt.MiddleButton) { playerPlayPause.running = true; }
    }
  }

  Behavior on implicitHeight {
    NumberAnimation {
      duration: 1000
      easing.type: Easing.InOutQuart
    }
  }

  Rectangle {
    id: topHalf
    visible: height > 0
    anchors.bottom: parent.bottom
    anchors.bottomMargin: 24
    anchors.left: parent.left
    anchors.right: parent.right
    height: playing ? 96 : 0
    clip: true

    Behavior on height {
      NumberAnimation {
        duration: 1000
        easing.type: Easing.InOutQuart
      }
    }

    Image {
      anchors.fill: parent
      source: artUrl
      fillMode: Image.PreserveAspectCrop
      horizontalAlignment: Image.AlignHCenter
      verticalAlignment: Image.AlignVCenter
      cache: false

      Rectangle {
        anchors.fill: parent
        gradient: Gradient {
          GradientStop { position: 0.0; color: "#00000000" }
          GradientStop { position: 0.94; color: "#131B1F" }
        }
      }
    }

    layer.enabled: true
    layer.effect: OpacityMask {
      maskSource: Rectangle {
        width: topHalf.width
        height: topHalf.height
        radius: playerModule.radius
      }
    }
  }

  Rectangle {
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.bottom: parent.bottom
    anchors.bottomMargin: 1
    height: 26
    radius: playerModule.radius
    color: "#111A1F"

    Image {
      anchors.centerIn: parent
      width: 18
      height: 18
      source: `file:///home/${username}/.config/rumda/quickshell/icons/headphones.svg`
      sourceSize.width: 36
      sourceSize.height: 36
    }
  }
}
