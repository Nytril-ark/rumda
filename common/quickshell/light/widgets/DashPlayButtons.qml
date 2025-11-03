import QtQuick.Shapes
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import Qt5Compat.GraphicalEffects
import Quickshell.Widgets
import Quickshell.Wayland
import QtQuick.Window
import Quickshell.Services.UPower
import Quickshell.Services.SystemTray
import Quickshell.Services.Pipewire
import Quickshell.Services.Mpris
import qs.light.config
import qs.light.widgets



Row {
  readonly property int buttonSizes: 51
  readonly property int buttonSpacing: 7
  readonly property int buttonBorderWidth: 0
  readonly property int pfpRadius: 100
  readonly property int pfpSize: 160
  readonly property int buttonsGapFromBottom: 15
  readonly property int iconSizes: 27
  readonly property int buttonFloatAmount: 6
  property int rowSpacing: 8
  y: -6

  Process { id: playerPrev; command: ["playerctl", "previous"] }
  Process { id: playerPlayPause; command: ["playerctl", "play-pause"] }
  Process { id: playerNext; command: ["playerctl", "next"] }
  
  Process {
    id: playerStatus
    running: true
    command: ["playerctl", "status"]
    property string status: ""
    
    stdout: SplitParser {
      onRead: data => {
        playerStatus.status = data.trim()
      }
    }
  }
  
  Timer {
    interval: 500
    running: true
    repeat: true
    onTriggered: {
      playerStatus.running = true
    }
  }






  // // Header
  // Row {
  //   anchors.horizontalCenter: parent.horizontalCenter
  //   Text {
  //     text: "media controls"
  //     color: Colors.accentColor
  //     font.pixelSize: 16
  //     font.bold: true
  //   }
  // }

  // ===============================================
  // MEDIA CONTROL BUTTONS
  // ===============================================
  
  // Media Controls Row
  Item {
    id: mediaControlWrapper
    width: (buttonSizes + buttonFloatAmount) * 3 + rowSpacing * 2
    height: buttonSizes + buttonFloatAmount + 20
    

    property var player: Mpris.players.values[0] || null  // Get first available player
    
    Row {
      anchors.fill: parent
      spacing: rowSpacing
      
      // Previous Button
      Item {
        width: buttonSizes + buttonFloatAmount
        height: buttonSizes + buttonFloatAmount
        
        Rectangle {
          id: prevButton
          width: buttonSizes
          height: buttonSizes
          anchors.left: parent.left
          anchors.leftMargin: mouseAreaPrev.containsMouse ? -buttonFloatAmount : 0
          anchors.verticalCenter: parent.verticalCenter
          radius: Config.dashInnerModuleRadius
          color: mouseAreaPrev.containsMouse ? Colors.accentColor : Colors.powerButtons 
          border.width: buttonBorderWidth
          border.color: Colors.borderColor
          
          Behavior on color {
            ColorAnimation { duration: 200 }
          }
          
          Behavior on anchors.leftMargin {
            NumberAnimation { duration: 200 }
          }
          
          MouseArea {
            id: mouseAreaPrev
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            hoverEnabled: true
            onClicked: playerPrev.running = true
          }
          
          Image {
            anchors.centerIn: parent
            width: iconSizes
            height: iconSizes
            source: `file://${Config.configPath}/light/icons/dashboard/prev.svg`
            fillMode: Image.PreserveAspectFit
            antialiasing: true
            smooth: true
            mipmap: true
          }
        }
      }
      
      // Play/Pause Button
      Item {
        width: buttonSizes
        height: buttonSizes + buttonFloatAmount
        
        Rectangle {
          id: playPauseButton
          width: buttonSizes
          height: buttonSizes
          anchors.verticalCenter: parent.verticalCenter
          anchors.horizontalCenter: parent.horizontalCenter
          radius: Config.dashInnerModuleRadius
          color: mouseAreaPlayPause.containsMouse ? Colors.accentColor : Colors.powerButtons 
          border.width: buttonBorderWidth
          border.color: Colors.borderColor
          
          scale: mouseAreaPlayPause.containsMouse ? 1.05 : 1.0
          
          Behavior on color {
            ColorAnimation { duration: 200 }
          }
          
          Behavior on scale {
            NumberAnimation { duration: 200 }
          }
          
          MouseArea {
            id: mouseAreaPlayPause
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            hoverEnabled: true
            onClicked: playerPlayPause.running = true
          }
          
          Image {
            anchors.centerIn: parent
            width: iconSizes
            height: iconSizes
            source: playerStatus.status === "Playing" ?
              `file://${Config.configPath}/light/icons/dashboard/pause.svg` :
              `file://${Config.configPath}/light/icons/dashboard/play.svg`
            fillMode: Image.PreserveAspectFit
            antialiasing: true
            smooth: true
            mipmap: true
          }
        }
      }
      
      // Next Button
      Item {
        width: buttonSizes + buttonFloatAmount
        height: buttonSizes + buttonFloatAmount
        
        Rectangle {
          id: nextButton
          width: buttonSizes
          height: buttonSizes
          anchors.right: parent.right
          anchors.rightMargin: mouseAreaNext.containsMouse ? -buttonFloatAmount : 0
          anchors.verticalCenter: parent.verticalCenter
          radius: Config.dashInnerModuleRadius
          color: mouseAreaNext.containsMouse ? Colors.accentColor : Colors.powerButtons 
          border.width: buttonBorderWidth
          border.color: Colors.borderColor
          
          Behavior on color {
            ColorAnimation { duration: 200 }
          }
          
          Behavior on anchors.rightMargin {
            NumberAnimation { duration: 200 }
          }
          
          MouseArea {
            id: mouseAreaNext
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            hoverEnabled: true
            onClicked: playerNext.running = true
          }
          
          Image {
            anchors.centerIn: parent
            width: iconSizes
            height: iconSizes
            source: `file://${Config.configPath}/light/icons/dashboard/next.svg`
            fillMode: Image.PreserveAspectFit
            antialiasing: true
            smooth: true
            mipmap: true
          }
        }
      }
    }
  }
}


