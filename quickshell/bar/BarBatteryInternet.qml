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
  height: 35
  color: moduleBG
  radius: 7
  border.width: 1
  border.color: borderColor
  
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
          // Check if there are active connections (wifi or ethernet)
          internetModule.internetConnected = fullOutput.includes("activated")
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
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        width: 32
        height: 32
        source: `file:///home/${username}/.config/rumda/quickshell/icons/${internetModule.internetConnected ? 'connected' : 'disconnected'}.svg`
        antialiasing: true
        smooth: true
        mipmap: true
      }
    }
  }
}
