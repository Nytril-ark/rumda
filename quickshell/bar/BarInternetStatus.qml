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
  Layout.alignment: Qt.AlignHCenter
  width: 28
  height: 28
  radius: innerModulesRadius
  color: "#111A1F"
  
  property bool internetConnected: false
  
  Process {
    id: connectionCheck
    running: true
    command: ["nmcli", "-t", "-f", "STATE", "connection", "show", "--active"]
    property string fullOutput: ""
    
    stdout: SplitParser {
      onRead: out => {
        connectionCheck.fullOutput += out
      }
    }
    
    onExited: {
      // Check if we have any active connections (wifi or ethernet)
      internetConnected = fullOutput.includes("activated")
      fullOutput = ""
    }
  }
  
  Timer {
    id: updateTimer
    interval: 5000
    running: true
    repeat: true
    onTriggered: {
      connectionCheck.running = true
    }
  }
  
  Image {
    anchors.centerIn: parent
    width: 23
    height: 23
    source: {
      if (!internetConnected) {
        return `file:///home/${username}/.config/rumda/quickshell/icons/disconnected.svg`
      } else if (connectionType === "wifi") {
        return `file:///home/${username}/.config/rumda/quickshell/icons/connected.svg`
      } else if (connectionType === "ethernet") {
        return `file:///home/${username}/.config/rumda/quickshell/icons/connected.svg`
      } else {
        return `file:///home/${username}/.config/rumda/quickshell/icons/connected.svg`
      }
    }
  }
}
