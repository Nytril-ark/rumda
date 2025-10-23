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
import qs.config

// The cat above the power button frowns if you're disconnected, and smiles when you're connected. :)
Rectangle {

  Layout.alignment: Qt.AlignHCenter
  width: 28
  height: 35
  color: Colors.moduleBG
  radius: 7
  border.width: 1
  border.color: Colors.borderColor
  ColumnLayout {
    anchors.centerIn: parent
    spacing: 0
    // Internet Module
    QtObject {
      id: internetModule
      property bool internetConnected: false
    }
    Item {
      Layout.alignment: Qt.AlignHCenter
      width: 28
      height: 29
      Process {
        id: internetProcess
        running: true
        command: [ "ping", "-c1", "1.0.0.1" ]
        property string fullOutput: ""
        stdout: SplitParser {
          onRead: out => {
            internetProcess.fullOutput += out + "\n"
            if (out.includes("0% packet loss")) internetModule.internetConnected = true
          }
        }
        onExited: {
          internetModule.internetConnected = fullOutput.includes("0% packet loss")
          fullOutput = ""
          // Restart the timer after this check completes
          updateTimer.restart()
        }
      }
      Timer {
        id: updateTimer
        interval: 5000
        running: true
        repeat: true
        onTriggered: {
          internetModule.internetConnected = false
          internetProcess.running = true
        }
      }
      Image {
        id: connectionImage
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        width: 32
        height: 32
        source: `file:///home/${username}/.config/rumda/light-config/quickshell/icons/${internetModule.internetConnected ? 'connected' : 'disconnected'}.svg`
        antialiasing: true
        smooth: true
        mipmap: true
      }
    }
  }
}
