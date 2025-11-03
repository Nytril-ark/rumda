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

  readonly property int buttonSizes: 51
  readonly property int buttonSpacing: 7
  readonly property int buttonBorderWidth: 0
  readonly property int pfpRadius: 100
  readonly property int pfpSize: 160
  readonly property int buttonsGapFromBottom: 15
  readonly property int iconSizes: 27
  readonly property int buttonFloatAmount: 6

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
        
        // bottom circle (behind pfp)
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
      anchors.verticalCenter: parent.verticalCenter
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
      anchors.verticalCenter: parent.verticalCenter
      anchors.verticalCenterOffset: 20
      Text {
        text: Config.username
        font.family: "Cartograph CF"
        font.italic: true     
        color: Colors.accentColor
        font.pixelSize: 24
        font.bold: true
      }
    }

// POWER BUTTONS ======================================

    Row {
      anchors.horizontalCenter: parent.horizontalCenter
      anchors.verticalCenter: parent.bottom
      spacing: buttonSpacing
      anchors.verticalCenterOffset: -(buttonsGapFromBottom)
      
      // Square Button 1
      Item {
        width: buttonSizes
        height: buttonSizes + buttonFloatAmount
        
        Rectangle {
          id: powerButton
          width: buttonSizes
          height: buttonSizes
          anchors.bottom: parent.bottom
          anchors.bottomMargin: mouseArea1.containsMouse ? buttonFloatAmount : 0
          anchors.horizontalCenter: parent.horizontalCenter
          radius: Config.dashInnerModuleRadius
          color: mouseArea1.containsMouse ? Colors.accentColor : Colors.powerButtons 
          border.width: buttonBorderWidth
          border.color: Colors.borderColor

          Behavior on color {
            ColorAnimation { duration: 200 }
          }
          
          Behavior on anchors.bottomMargin {
            NumberAnimation { duration: 200 }
          }
          
          MouseArea {
            id: mouseArea1
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            hoverEnabled: true
            onClicked: {
              process5.running = true
            }
          }
          
          Process {
            id: process5
            command: ["/bin/sh", "-c", "shutdown"]
            running: false
          }

          Image {
            anchors.centerIn: parent
            anchors.horizontalCenterOffset: 1
            width: iconSizes - 2
            height: iconSizes - 2
            source: `file://${Config.configPath}/light/icons/powerPix.svg`
            fillMode: Image.PreserveAspectFit
            antialiasing: true
            smooth: true
            mipmap: true
          }
        }
      }
      
      // Square Button 2
      Item {
        width: buttonSizes
        height: buttonSizes + buttonFloatAmount
        
        Rectangle {
          width: buttonSizes
          height: buttonSizes
          anchors.bottom: parent.bottom
          anchors.bottomMargin: mouseArea2.containsMouse ? buttonFloatAmount : 0
          anchors.horizontalCenter: parent.horizontalCenter
          radius: Config.dashInnerModuleRadius
          color: mouseArea2.containsMouse ? Colors.accentColor : Colors.powerButtons
          border.width: buttonBorderWidth
          border.color: Colors.borderColor
          
          Behavior on color {
            ColorAnimation { duration: 200 }
          }
          
          Behavior on anchors.bottomMargin {
            NumberAnimation { duration: 200 }
          }
          
          MouseArea {
            id: mouseArea2
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            hoverEnabled: true
            onClicked: {
              process6.running = true
            }
          }
          
          Process {
            id: process6
            command: ["/bin/sh", "-c", "loginctl terminate-user $USER"]
            running: false
          }

          Image {
            anchors.centerIn: parent
            anchors.horizontalCenterOffset: 2
            width: iconSizes  - 2
            height: iconSizes - 2
            source: `file://${Config.configPath}/light/icons/logoutPix.svg`
            fillMode: Image.PreserveAspectFit
            antialiasing: true
            smooth: true
            mipmap: true
          }
        }
      }
      
      // Square Button 3
      Item {
        width: buttonSizes
        height: buttonSizes + buttonFloatAmount
        
        Rectangle {
          width: buttonSizes
          height: buttonSizes
          anchors.bottom: parent.bottom
          anchors.bottomMargin: mouseArea3.containsMouse ? buttonFloatAmount : 0
          anchors.horizontalCenter: parent.horizontalCenter
          radius: Config.dashInnerModuleRadius
          color: mouseArea3.containsMouse ? Colors.accentColor : Colors.powerButtons
          border.width: buttonBorderWidth
          border.color: Colors.borderColor
          
          Behavior on color {
            ColorAnimation { duration: 200 }
          }
          
          Behavior on anchors.bottomMargin {
            NumberAnimation { duration: 200 }
          }
          
          MouseArea {
            id: mouseArea3
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            hoverEnabled: true
            onClicked: {
              process7.running = true
            }
          }
          
          Process {
            id: process7
            command: ["bash", "-c", "hyprlock"]
            running: false
          }

          Image {
            anchors.centerIn: parent
            width: iconSizes - 2
            height: iconSizes - 2
            source: `file://${Config.configPath}/light/icons/padlockPix.svg`
            fillMode: Image.PreserveAspectFit
            antialiasing: true
            smooth: true
            mipmap: true
          }
        }
      }
      
      // Square Button 4
      Item {
        width: buttonSizes
        height: buttonSizes + buttonFloatAmount
        
        Rectangle {
          width: buttonSizes
          height: buttonSizes
          anchors.bottom: parent.bottom
          anchors.bottomMargin: mouseArea4.containsMouse ? buttonFloatAmount : 0
          anchors.horizontalCenter: parent.horizontalCenter
          radius: Config.dashInnerModuleRadius
          color: mouseArea4.containsMouse ? Colors.accentColor : Colors.powerButtons
          border.width: buttonBorderWidth
          border.color: Colors.borderColor
          
          Behavior on color {
            ColorAnimation { duration: 200 }
          }
          
          Behavior on anchors.bottomMargin {
            NumberAnimation { duration: 200 }
          }
          
          MouseArea {
            id: mouseArea4
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            hoverEnabled: true
            onClicked: {
              process8.running = true
            }
          }
          
          Process {
            id: process8
            command: ["bash", "-c", "alacritty -e nvim ~/.config/rumda/README.md"]
            running: false
          }

          Image {
            anchors.centerIn: parent
            width: iconSizes 
            height: iconSizes 
            source: `file://${Config.configPath}/light/icons/readmePix.svg`
            fillMode: Image.PreserveAspectFit
            antialiasing: true
            smooth: true
            mipmap: true
          }
        }
      }
    }  
  } // END OF COLUMN
}


