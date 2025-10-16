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
  property color errorColor: "#9A4235"
  property color backgroundTransparent: "#661e1e1e"
  property color shadowColor: "#3A2D26"
  Layout.alignment: Qt.AlignHCenter
  width: 28
  height: 48
  color: moduleBG
  radius: 7

  border.width: 1
  border.color: borderColor

  property real temperature: 0

  Process {
    id: weatherProcess
    running: true
    command: [ "curl", "-s", "https://wttr.in/?format=%t" ]

    stdout: SplitParser {
      onRead: temp => { temperature = parseFloat(temp.replace(/[^\d.-]/g, '')); }
    }
  }

  Timer {
    interval: 1000000
    running: true
    repeat: true
    onTriggered: { weatherProcess.running = true }
  }

  ColumnLayout {
    anchors.centerIn: parent
    spacing: 0

    Rectangle {
      Layout.alignment: Qt.AlignHCenter
      Layout.topMargin: 4
      height: 20
      Image {
        anchors.centerIn: parent
        width: 20
        height: 20
        source: `file:///home/${username}/.config/rumda/quickshell/icons/weather.svg`
        sourceSize.width: 36
        sourceSize.height: 36
      }
    }

    Rectangle {
      Layout.alignment: Qt.AlignHCenter
      Layout.leftMargin: 5
      height: 20
      Text {
        anchors.centerIn: parent
        text: `${temperature}°`
        color: accent2Color 
        font.family: "Cartograph CF"
        font.pixelSize: 11
      }
    }
  }
}
