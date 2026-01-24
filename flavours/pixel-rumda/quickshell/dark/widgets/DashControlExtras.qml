import Quickshell.Io
import Quickshell
import Quickshell.Wayland
import Quickshell.Services.Pipewire
import Quickshell.Bluetooth
import Quickshell.Widgets
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import qs.dark.config

Item {
  property int rowSpacing: 10
  readonly property int buttonSizes: Config.innerDSButtonSize
  readonly property int iconSizes: 26
  readonly property int buttonBorderWidth: 0
  readonly property int pfpRadius: 100
  readonly property int pfpSize: 160
  readonly property int buttonsGapFromBottom: 15
  readonly property int buttonFloatAmount: 4
  readonly property int topMarginOfText: 0 // i aint even got energy to remove this



    Row {
      anchors.top: parent.top 
      anchors.left: parent.left
      spacing: rowSpacing

      // folder button ==============================================
      Item {
        width: buttonSizes + buttonFloatAmount
        height: buttonSizes + buttonFloatAmount
        
        Rectangle {
          id: root
          Rectangle {
          anchors.top: root.top
          anchors.bottom: root.bottom
          anchors.left: root.left
          anchors.rightMargin: Config.innerDSoffsetX
          anchors.bottomMargin: -Config.innerDSoffsetY
          implicitWidth: root.implicitWidth + Config.innerDSoffsetX
          z: -99
          color: Colors.shadowColorDS
          radius: Config.innerDSRadius
          }

          width: buttonSizes
          height: buttonSizes
          anchors.verticalCenter: parent.verticalCenter
          radius: Config.dashInnerModuleRadius
          color: mouseArea1.containsMouse ? Colors.accentColor : Colors.powerButtons 
          border.width: buttonBorderWidth
          border.color: Colors.borderColor
          scale: mouseArea1.containsMouse ? 0.95 : 1.0
             
          Behavior on scale {
            NumberAnimation { duration: 200 }
          }       
          
          Behavior on color {
            ColorAnimation { duration: 200 }
          }


          Process {
            id: process1
            command: ["bash", "-c", `${Config.fileManager} &disown`]
            running: false
          }
          
          MouseArea {
            id: mouseArea1
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            hoverEnabled: true
            onClicked: process1.running = true
          }
          
          Image {
            anchors.centerIn: parent
            width: iconSizes
            height: iconSizes
            source: `file://${Config.configPath}/light/icons/dashboard/folder.svg`
            fillMode: Image.PreserveAspectFit
            antialiasing: true
            smooth: true
            mipmap: true
          }
        }
      }


      // browser button ==============================================
      Item {
        width: buttonSizes + buttonFloatAmount
        height: buttonSizes + buttonFloatAmount
        
        Rectangle {
          id: root2
          Rectangle {
            anchors.top: root2.top
            anchors.bottom: root2.bottom
            anchors.left: root2.left
            anchors.rightMargin: Config.innerDSoffsetX
            anchors.bottomMargin: -Config.innerDSoffsetY
            implicitWidth: root2.implicitWidth + Config.innerDSoffsetX
            z: -99
            color: Colors.shadowColorDS
            radius: Config.innerDSRadius
          }

          width: buttonSizes
          height: buttonSizes
          anchors.verticalCenter: parent.verticalCenter
          radius: Config.dashInnerModuleRadius
          color: mouseArea2.containsMouse ? Colors.accentColor : Colors.powerButtons 
          border.width: buttonBorderWidth
          border.color: Colors.borderColor
          scale: mouseArea2.containsMouse ? 0.95 : 1.0
             
          Behavior on scale {
            NumberAnimation { duration: 200 }
          }       
          
          Behavior on color {
            ColorAnimation { duration: 200 }
          }


          Process {
            id: process2
            command: ["/bin/sh", "-c", `${Config.browser} &disown`]   // note to self: maybe this should be auto-read from hyprland.conf later
            running: false
          }

          
          MouseArea {
            id: mouseArea2
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            hoverEnabled: true
            onClicked: process2.running = true
          }
          
          Image {
            anchors.centerIn: parent
            width: iconSizes
            height: iconSizes
            source: `file://${Config.configPath}/light/icons/dashboard/search.svg`
            fillMode: Image.PreserveAspectFit
            antialiasing: true
            smooth: true
            mipmap: true
          }
        }
      }


      // screenshot button ==============================================
      Item {
        width: buttonSizes + buttonFloatAmount
        height: buttonSizes + buttonFloatAmount
        
        Rectangle {
          id: root3
          Rectangle {
            anchors.top: root3.top
            anchors.bottom: root3.bottom
            anchors.left: root3.left
            anchors.rightMargin: Config.innerDSoffsetX
            anchors.bottomMargin: -Config.innerDSoffsetY
            implicitWidth: root3.implicitWidth + Config.innerDSoffsetX
            z: -99
            color: Colors.shadowColorDS
            radius: Config.innerDSRadius
          }

          width: buttonSizes
          height: buttonSizes
          anchors.verticalCenter: parent.verticalCenter
          radius: Config.dashInnerModuleRadius
          color: mouseArea3.containsMouse ? Colors.accentColor : Colors.powerButtons 
          border.width: buttonBorderWidth
          border.color: Colors.borderColor
          scale: mouseArea3.containsMouse ? 0.95 : 1.0
             
          Behavior on scale {
            NumberAnimation { duration: 200 }
          }       
          
          Behavior on color {
            ColorAnimation { duration: 200 }
          }



          Process {
            id: process3
            command: ["bash", "-c", "~/.config/rumda/scripts/delayedScreenshot.sh &disown"] 
            running: false
          }
          
          MouseArea {
            id: mouseArea3
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            hoverEnabled: true
            onClicked: process3.running = true
          }
          
          Image {
            anchors.centerIn: parent
            width: iconSizes
            height: iconSizes
            source: `file://${Config.configPath}/light/icons/dashboard/screenshot.svg`
            fillMode: Image.PreserveAspectFit
            antialiasing: true
            smooth: true
            mipmap: true
          }
        }
      }


      // terminal button ==============================================
      Item {
        width: buttonSizes + buttonFloatAmount
        height: buttonSizes + buttonFloatAmount
        
        Rectangle {
          id: root4
          Rectangle {
            anchors.top: root4.top
            anchors.bottom: root4.bottom
            anchors.left: root4.left
            anchors.rightMargin: Config.innerDSoffsetX
            anchors.bottomMargin: -Config.innerDSoffsetY
            implicitWidth: root4.implicitWidth + Config.innerDSoffsetX
            z: -99
            color: Colors.shadowColorDS
            radius: Config.innerDSRadius
          }

          width: buttonSizes
          height: buttonSizes
          anchors.verticalCenter: parent.verticalCenter
          radius: Config.dashInnerModuleRadius
          color: mouseArea4.containsMouse ? Colors.accentColor : Colors.powerButtons 
          border.width: buttonBorderWidth
          border.color: Colors.borderColor
          scale: mouseArea4.containsMouse ? 0.95 : 1.0
             
          Behavior on scale {
            NumberAnimation { duration: 200 }
          }       
          
          Behavior on color {
            ColorAnimation { duration: 200 }
          }
          
          
          Process {
            id: process4
            command: ["/bin/sh", "-c", `${Config.terminal} &disown`]
            running: false
          }


          MouseArea {
            id: mouseArea4
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            hoverEnabled: true
            onClicked: process4.running = true
          }
          
          Image {
            anchors.centerIn: parent
            width: iconSizes
            height: iconSizes
            source: `file://${Config.configPath}/light/icons/dashboard/terminal.svg`
            fillMode: Image.PreserveAspectFit
            antialiasing: true
            smooth: true
            mipmap: true
          }
        }
      }



      // bluetooth button ==============================================
      Item {                              // PLEASE note that I do not use bluetooth nor have it as a feature on my pc 
                                          // so I have no idea whether or not this works.. sorry
        width: buttonSizes + buttonFloatAmount
        height: buttonSizes + buttonFloatAmount
        
        Rectangle {
          id: root5
          Rectangle {
            anchors.top: root5.top
            anchors.bottom: root5.bottom
            anchors.left: root5.left
            anchors.rightMargin: Config.innerDSoffsetX
            anchors.bottomMargin: -Config.innerDSoffsetY
            implicitWidth: root5.implicitWidth + Config.innerDSoffsetX
            z: -99
            color: Colors.shadowColorDS
            radius: Config.innerDSRadius
          }

          width: buttonSizes
          height: buttonSizes
          anchors.verticalCenter: parent.verticalCenter
          radius: Config.dashInnerModuleRadius
          color: mouseArea5.containsMouse ? Colors.accentColor : Colors.powerButtons
          border.width: buttonBorderWidth
          border.color: Colors.borderColor
          scale: mouseArea5.containsMouse ? 0.95 : 1.0
             
          Behavior on scale {
            NumberAnimation { duration: 200 }
          }       
          
          Behavior on color {
            ColorAnimation { duration: 200 }
          }
          
          MouseArea {
            id: mouseArea5
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            hoverEnabled: true
            onClicked: {
              if (Bluetooth.adapter) {
                Bluetooth.adapter.powered = !Bluetooth.adapter.powered
              } else {
                console.error("No bluetooth adapter found")
              }
            }
          }
          
          Image {
            anchors.centerIn: parent
            width: iconSizes
            height: iconSizes
            source: Bluetooth.adapter?.powered ? 
              `file://${Config.configPath}/light/icons/dashboard/bluetooth.svg` :
              `file://${Config.configPath}/light/icons/dashboard/bluetoothOff.svg`
            fillMode: Image.PreserveAspectFit
            antialiasing: true
            smooth: true
            mipmap: true
          }
        }
      }


    }   // row 1 ends here

} // end of column that contains the 2 rows of buttons
