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
import qs.light.config
Rectangle {
  id: root
  Rectangle {
    id: shadowpowerRect
    anchors.top: root.top
    anchors.bottom: root.bottom
    anchors.left: root.left
    anchors.rightMargin: Config.innerBMSoffsetX
    anchors.bottomMargin: -Config.innerBMSoffsetY
    implicitWidth: root.implicitWidth + Config.innerBMSoffsetX
    z: -99
    color: Colors.shadowColorBM
    radius: Config.innerBMSRadius
  }

  Layout.alignment: Qt.AlignHCenter
  width: 30
  height: 48
  color: Colors.moduleBG
  radius: config.innerBModulesRadius

  border.width: 1
  border.color: Colors.borderColor

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
        source: `file://${Config.configPath}/light/icons/weather.svg`
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
        color: Colors.accent2Color 
        font.family: "Cartograph CF"
        font.pixelSize: 11
      }
    }
  }
}
