import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Services.UPower
import Quickshell.Services.SystemTray
import Quickshell.Services.Pipewire
import Quickshell.Services.Mpris
import Qt5Compat.GraphicalEffects
import qs.light.config


Rectangle {
  id: profileAndPowerRect

  
  readonly property int pfpRadius: 100
  readonly property int pfpSize: 160

  color: Colors.dashModulesColor
  border.width: Config.dashInnerModuleBorderWidth
  border.color: Colors.borderColor
  radius: Config.dashInnerModuleRadius
  
  
  Column {
    anchors.fill: parent
    anchors.margins: 20
    spacing: 12
    
    Item {
      width: parent.width
      height: pfpSize + 40
      
      Item {
        anchors.horizontalCenter: parent.horizontalCenter
        width: pfpSize + 40
        height: pfpSize + 40
        
        // Bottom circle
        Rectangle {
          anchors.centerIn: parent
          width: pfpSize + 40
          height: pfpSize + 40
          radius: width / 2
          color: Colors.dashPFPColor
        }
        
        // border circle
        Rectangle {
          anchors.centerIn: parent
          width: pfpSize + 23
          height: pfpSize + 23
          radius: width / 2
          color: "transparent"
          border.width: 3
          border.color: Colors.borderColor
        }
        
        // Profile pic
        ClippingWrapperRectangle {
          anchors.centerIn: parent
          radius: pfpRadius
          width: pfpSize
          height: pfpSize
          
          Image {
            source: Config.profilePath
            sourceSize.width: pfpSize
            sourceSize.height: pfpSize
            anchors.fill: parent 
            fillMode: Image.PreserveAspectCrop
            antialiasing: true 
            smooth: true
          }
        }
      }
    }
    
    Row {     
      anchors.horizontalCenter: parent.horizontalCenter
      Text {
        text: "Hello.."
        font.family: "Cartograph CF"
        font.italic: true     
        color: Colors.accentColor
        font.pixelSize: 19
        font.bold: true
      }      
    }
    Row {
      anchors.horizontalCenter: parent.horizontalCenter
      // Text {
      //   text: Config.username
      //   font.family: "Cartograph CF"
      //   font.italic: true        
      //   color: Colors.accent2Color
      //   font.pixelSize: 17
      // }
      Text {
        text: Config.username
        font.family: "Cartograph CF"
        font.italic: true     
        color: Colors.accentColor
        font.pixelSize: 24
        font.bold: true
      }
    }
  }
}

