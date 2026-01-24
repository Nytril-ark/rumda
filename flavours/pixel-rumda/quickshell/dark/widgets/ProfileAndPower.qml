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
import qs.dark.config


Rectangle {
  id: profileAndPowerRect
  Rectangle {
    visible: Config.dashInnerModuleShadowVisible
    anchors.top: parent.top
    anchors.bottom: parent.bottom
    anchors.left: parent.left
    anchors.bottomMargin: -3
    implicitWidth: parent.width + 3
    z: -99
    color: Colors.shadowColorDS
    radius: Config.innerDSRadius
  }
  readonly property int buttonSizes: 40 //51
  readonly property int buttonSpacing: 13
  readonly property int buttonBorderWidth: 0
  readonly property int pfpRadius: Config.dashInnerModuleRadius // 100
  readonly property int pfpSize: 160
  readonly property int iconSizes: 23 //27
  // properties related to position / animation
  readonly property int allButtonsOffset: 21    // this offset is the distance from the pfp
  readonly property int buttonFloatAmount: allButtonsOffset + 6 // << the amount the button moves when u hover is the small number added to allButtonOffset here, in this case, it's 6
  readonly property int middleButtonsCircularOffset: 0
  readonly property int centerButtonCircularOffset: 0
  // =============================================================================


  color: Colors.dashModulesColor
  border.width: Config.dashInnerModuleBorderWidth
  border.color: Colors.borderColor
  radius: Config.dashInnerModuleRadius
  

  GridLayout {
    anchors.fill: parent
    anchors.topMargin: 10 
    anchors.leftMargin: 10
    anchors.bottomMargin: 53
    columns: 2
    rowSpacing: 0
    columnSpacing: 0

  // PFP and its circular border
    Item {
      Layout.row: 0
      Layout.column: 0
      Layout.rowSpan: 2
      Layout.preferredWidth: pfpSize + 0
      Layout.preferredHeight: pfpSize + 0
      Layout.alignment: Qt.AlignTop
      
      Item {
        width: pfpSize + 40
        height: pfpSize + 40
        
        // bottom circle (behind pfp)
        Rectangle {
          Rectangle {
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.bottomMargin: -3
            implicitWidth: parent.width + 3
            z: -99
            color: Colors.shadowColorDS
            radius: Config.innerDSRadius
          }
          anchors.centerIn: parent
          width: pfpSize + 40
          height: pfpSize + 40
          radius: Config.dashInnerModuleRadius // width / 2
          color: Colors.dashPFPColor
        }
        
        // border circle
        Rectangle {
          anchors.centerIn: parent
          width: pfpSize + 23
          height: pfpSize + 23
          radius: Config.dashInnerModuleRadius // width / 2
          color: "transparent"
          border.width: 3
          border.color: Colors.dashBorderColor
        }
        
        // Profile pic
        ClippingWrapperRectangle {
          anchors.centerIn: parent
          radius: pfpRadius
          width: pfpSize
          height: pfpSize
          clip: true
          
          Image {
            source: Config.profilePath
            anchors.centerIn: parent
            width: pfpSize
            height: pfpSize
            fillMode: Image.PreserveAspectCrop
            smooth: true
            mipmap: Config.pfpMipMap
          }
        }
      }
    }



// POWER BUTTONS ======================================

    ColumnLayout {
      Layout.row: 0
      Layout.column: 1
      Layout.leftMargin: 35
      Layout.topMargin: -13
      spacing: buttonSpacing
      
      // Square Button 1
      Item {
        width: buttonSizes + buttonFloatAmount + allButtonsOffset
        height: buttonSizes 
        
        Rectangle {
          id: powerButton
          Rectangle {
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.bottomMargin: -2
            implicitWidth: parent.width + 2
            z: -99
            color: Colors.shadowColorDS
            radius: Config.innerDSRadius
          }
          width: buttonSizes
          height: buttonSizes
          anchors.bottom: parent.bottom
          anchors.left: parent.left
          anchors.leftMargin: mouseArea1.containsMouse ? buttonFloatAmount : allButtonsOffset
          radius: Config.dashInnerModuleRadius
          color: mouseArea1.containsMouse ? Colors.accentColor : Colors.powerButtons 
          border.width: buttonBorderWidth
          border.color: Colors.borderColor

          Behavior on color {
            ColorAnimation { duration: 200 }
          }
          
          Behavior on anchors.leftMargin {
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
            command: ["/bin/sh", "-c", "shutdown && notify-send 'Rumda' 'Shutting down in 1 minute'"]
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
        width: buttonSizes + buttonFloatAmount  + middleButtonsCircularOffset + allButtonsOffset
        height: buttonSizes 
        
        Rectangle {
          Rectangle {
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.bottomMargin: -2
            implicitWidth: parent.width + 2
            z: -99
            color: Colors.shadowColorDS
            radius: Config.innerDSRadius
          }
          width: buttonSizes
          height: buttonSizes
          anchors.bottom: parent.bottom
          anchors.left: parent.left
          anchors.leftMargin: mouseArea2.containsMouse ? buttonFloatAmount + middleButtonsCircularOffset : middleButtonsCircularOffset + allButtonsOffset
          radius: Config.dashInnerModuleRadius
          color: mouseArea2.containsMouse ? Colors.accentColor : Colors.powerButtons
          border.width: buttonBorderWidth
          border.color: Colors.borderColor
          
          Behavior on color {
            ColorAnimation { duration: 200 }
          }
          
          Behavior on anchors.leftMargin {
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

      // middle button here ====================

      // REMOVED

      // =======================================

      // Square Button 4
      Item {
        width: buttonSizes + buttonFloatAmount  + middleButtonsCircularOffset + allButtonsOffset
        height: buttonSizes 
        
        Rectangle {
          Rectangle {
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.bottomMargin: -2
            implicitWidth: parent.width + 2
            z: -99
            color: Colors.shadowColorDS
            radius: Config.innerDSRadius
          }
          width: buttonSizes
          height: buttonSizes
          anchors.bottom: parent.bottom
          anchors.left: parent.left
          anchors.leftMargin: mouseArea3.containsMouse ? buttonFloatAmount + middleButtonsCircularOffset : middleButtonsCircularOffset + allButtonsOffset
          radius: Config.dashInnerModuleRadius
          color: mouseArea3.containsMouse ? Colors.accentColor : Colors.powerButtons
          border.width: buttonBorderWidth
          border.color: Colors.borderColor
          
          Behavior on color {
            ColorAnimation { duration: 200 }
          }
          
          Behavior on anchors.leftMargin {
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
      
      // Square Button 5
      Item {
        width: buttonSizes + buttonFloatAmount + allButtonsOffset
        height: buttonSizes 
        
        Rectangle {
          Rectangle {
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.bottomMargin: -2
            implicitWidth: parent.width + 2
            z: -99
            color: Colors.shadowColorDS
            radius: Config.innerDSRadius
          }
          width: buttonSizes
          height: buttonSizes
          anchors.bottom: parent.bottom
          anchors.left: parent.left 
          anchors.leftMargin: mouseArea4.containsMouse ? buttonFloatAmount : allButtonsOffset
          radius: Config.dashInnerModuleRadius
          color: mouseArea4.containsMouse ? Colors.accentColor : Colors.powerButtons
          border.width: buttonBorderWidth
          border.color: Colors.borderColor
          
          Behavior on color {
            ColorAnimation { duration: 200 }
          }
          
          Behavior on anchors.leftMargin {
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
            command: ["bash", "-c", "zathura ~/.config/rumda/pictures/keybinds.pdf &disown"]
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
    } // end of ColumnLayout for power buttons

    Item {
      Layout.row: 1
      Layout.column: 0
      Layout.columnSpan: 2
      Layout.fillWidth: true
      Layout.preferredHeight: dashControlExtras.height
      DashControlExtras {
        id: dashControlExtras
      }
    }

  } // end of GridLayout
}  // end of rectangle that contains this whole module (the bg rectangle)
