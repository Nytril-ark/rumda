import Quickshell.Io
import Quickshell
import Quickshell.Wayland
import Quickshell.Services.Pipewire
import Quickshell.Widgets
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import qs.light.config
import qs.light.widgets

Rectangle {
  id: dashBoardControls
  color: Colors.dashModulesColor
  border.width: Config.dashInnerModuleBorderWidth
  border.color: Colors.borderColor
  radius: Config.dashInnerModuleRadius
  
  
  Column {
    anchors.fill: parent
    anchors.margins: 20
    spacing: 12
    
    // Header
    Row {
      spacing: 10
    
      Text {
        text: "control"
        color: Colors.accentColor
        font.pixelSize: 16
        font.bold: true
      }
      
      Text {
        text: "hello"
        color: Colors.accent2Color
        font.pixelSize: 12
        anchors.verticalCenter: parent.verticalCenter
      }
    }
  
    // ===============================================
    // CONTROL BUTTONS
    // ===============================================
    // 4 Rectangular buttons in column
    Column {
      spacing: 10
      width: parent.width
      
      // Button 1
      Rectangle {
        width: parent.width
        height: 50
        radius: Config.dashInnerModuleRadius
        color: Colors.powerButtons
        border.width: 2
        border.color: Colors.borderColor
        
        MouseArea {
          anchors.fill: parent
          onClicked: {
            process1.running = true
          }
        }
        
        Process {
          id: process1
          command: ["/bin/sh", "-c", "your-script-here"]
          running: false
        }
      }
      
      // Button 2
      Rectangle {
        width: parent.width
        height: 50
        radius: Config.dashInnerModuleRadius
        color: Colors.powerButtons
        border.width: 2
        border.color: Colors.borderColor
        
        MouseArea {
          anchors.fill: parent
          onClicked: {
            process2.running = true
          }
        }
        
        Process {
          id: process2
          command: ["/bin/sh", "-c", "your-script-here"]
          running: false
        }
      }
      
      // Button 3
      Rectangle {
        width: parent.width
        height: 50
        radius: Config.dashInnerModuleRadius
        color: Colors.powerButtons
        border.width: 2
        border.color: Colors.borderColor
        
        MouseArea {
          anchors.fill: parent
          onClicked: {
            process3.running = true
          }
        }
        
        Process {
          id: process3
          command: ["/bin/sh", "-c", "your-script-here"]
          running: false
        }
      }
      
      // Button 4
      Rectangle {
        width: parent.width
        height: 50
        radius: Config.dashInnerModuleRadius
        color: Colors.powerButtons
        border.width: 2
        border.color: Colors.borderColor
        
        MouseArea {
          anchors.fill: parent
          onClicked: {
            process4.running = true
          }
        }
        
        Process {
          id: process4
          command: ["/bin/sh", "-c", "your-script-here"]
          running: false
        }
      }
    }



    }
  }
