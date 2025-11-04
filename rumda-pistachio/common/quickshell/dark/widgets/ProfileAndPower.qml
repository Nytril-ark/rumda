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

  readonly property int buttonSizes: 40 //51
  readonly property int buttonSpacing: 7
  readonly property int buttonBorderWidth: 0
  readonly property int pfpRadius: 100
  readonly property int pfpSize: 160
  readonly property int iconSizes: 23 //27
  // properties related to position / animation
  readonly property int allButtonsOffset: 21    // this offset is the distance from the pfp
  readonly property int buttonFloatAmount: allButtonsOffset + 6 // << the amount the button moves when u hover is the small number added to allButtonOffset here, in this case, it's 6


  // dont concern urself with those, I use them to achieve a circular kinda layout
  readonly property int middleButtonsCircularOffset: 30 
  readonly property int centerButtonCircularOffset: 10
  // =============================================================================


  color: Colors.dashModulesColor
  border.width: Config.dashInnerModuleBorderWidth
  border.color: Colors.borderColor
  radius: Config.dashInnerModuleRadius
  



  // PFP and its circular border
  Row {
    id: pfpRow
    anchors.left: parent.left
    anchors.bottom: parent.bottom
    anchors.top: parent.top
    width: pfpSize + 40
    anchors.margins: 20
    spacing: 12
    
    Item {
      width: pfpSize + 40
      height: pfpSize + 40
      anchors.left: parent.left
      anchors.verticalCenter: parent.verticalCenter
      
      Item {
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
          border.color: Colors.dashBorderColor
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



// POWER BUTTONS ======================================

    ColumnLayout {
      anchors.left: pfpRow.right
      anchors.verticalCenter: parent.verticalCenter
      spacing: buttonSpacing
      
      // Square Button 1
      Item {
        width: buttonSizes + buttonFloatAmount + allButtonsOffset
        height: buttonSizes 
        
        Rectangle {
          id: powerButton
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
        width: buttonSizes + buttonFloatAmount  + middleButtonsCircularOffset + allButtonsOffset
        height: buttonSizes 
        
        Rectangle {
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

      // Square Button MIDDLE
      Item {
        width: buttonSizes + buttonFloatAmount  + middleButtonsCircularOffset + centerButtonCircularOffset + allButtonsOffset
        height: buttonSizes 
        
        Rectangle {
          width: buttonSizes
          height: buttonSizes
          anchors.bottom: parent.bottom
          anchors.left: parent.left
          anchors.leftMargin: mouseAreaMiddle.containsMouse ? buttonFloatAmount + middleButtonsCircularOffset + centerButtonCircularOffset 
          : middleButtonsCircularOffset + centerButtonCircularOffset + allButtonsOffset

          radius: Config.dashInnerModuleRadius
          color: mouseAreaMiddle.containsMouse ? Colors.accentColor : Colors.powerButtons
          border.width: buttonBorderWidth
          border.color: Colors.borderColor
          
          Behavior on color {
            ColorAnimation { duration: 200 }
          }
          
          Behavior on anchors.leftMargin {
            NumberAnimation { duration: 200 }
          }
          
          MouseArea {
            id: mouseAreaMiddle
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            hoverEnabled: true
            onClicked: {
              processMiddle.running = true
            }
          }
          
          Process {
            id: processMiddle
            command: ["/bin/sh", "-c", "reboot"]
            running: false
          }

          Image {
            anchors.centerIn: parent
            width: iconSizes  + 1
            height: iconSizes + 1
            source: `file://${Config.configPath}/light/icons/dashboard/reboot.svg`
            fillMode: Image.PreserveAspectFit
            antialiasing: true
            smooth: true
            mipmap: true
          }
        }
      }
         
      // =======================================

      // Square Button 4
      Item {
        width: buttonSizes + buttonFloatAmount  + middleButtonsCircularOffset + allButtonsOffset
        height: buttonSizes 
        
        Rectangle {
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
            command: ["bash", "-c", "zathura ~/.config/rumda-pistachio/pictures/keybinds.pdf"]
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
  } // end of row that contains the pfp and buttons


// normal straight position that animates left. this is nice, but I wanted smth different, so it's commented out
  //   ColumnLayout {
  //     anchors.right: parent.right
  //     anchors.verticalCenter: parent.verticalCenter
  //     spacing: buttonSpacing
  //
  //     // Square Button 1
  //     Item {
  //       width: buttonSizes + buttonFloatAmount
  //       height: buttonSizes 
  //
  //       Rectangle {
  //         id: powerButton
  //         width: buttonSizes
  //         height: buttonSizes
  //         anchors.bottom: parent.bottom
  //         anchors.right: parent.right
  //         anchors.rightMargin: mouseArea1.containsMouse ? buttonFloatAmount : 0
  //         radius: Config.dashInnerModuleRadius
  //         color: mouseArea1.containsMouse ? Colors.accentColor : Colors.powerButtons 
  //         border.width: buttonBorderWidth
  //         border.color: Colors.borderColor
  //
  //         Behavior on color {
  //           ColorAnimation { duration: 200 }
  //         }
  //
  //         Behavior on anchors.rightMargin {
  //           NumberAnimation { duration: 200 }
  //         }
  //
  //         MouseArea {
  //           id: mouseArea1
  //           anchors.fill: parent
  //           cursorShape: Qt.PointingHandCursor
  //           hoverEnabled: true
  //           onClicked: {
  //             process5.running = true
  //           }
  //         }
  //
  //         Process {
  //           id: process5
  //           command: ["/bin/sh", "-c", "shutdown"]
  //           running: false
  //         }
  //
  //         Image {
  //           anchors.centerIn: parent
  //           anchors.horizontalCenterOffset: 1
  //           width: iconSizes - 2
  //           height: iconSizes - 2
  //           source: `file://${Config.configPath}/light/icons/powerPix.svg`
  //           fillMode: Image.PreserveAspectFit
  //           antialiasing: true
  //           smooth: true
  //           mipmap: true
  //         }
  //       }
  //     }
  //
  //
  //
  //     // Square Button 2
  //     Item {
  //       width: buttonSizes + buttonFloatAmount
  //       height: buttonSizes 
  //
  //       Rectangle {
  //         width: buttonSizes
  //         height: buttonSizes
  //         anchors.bottom: parent.bottom
  //         anchors.right: parent.right
  //         anchors.rightMargin: mouseArea2.containsMouse ? buttonFloatAmount : 0
  //         radius: Config.dashInnerModuleRadius
  //         color: mouseArea2.containsMouse ? Colors.accentColor : Colors.powerButtons
  //         border.width: buttonBorderWidth
  //         border.color: Colors.borderColor
  //
  //         Behavior on color {
  //           ColorAnimation { duration: 200 }
  //         }
  //
  //         Behavior on anchors.rightMargin {
  //           NumberAnimation { duration: 200 }
  //         }
  //
  //         MouseArea {
  //           id: mouseArea2
  //           anchors.fill: parent
  //           cursorShape: Qt.PointingHandCursor
  //           hoverEnabled: true
  //           onClicked: {
  //             process6.running = true
  //           }
  //         }
  //
  //         Process {
  //           id: process6
  //           command: ["/bin/sh", "-c", "loginctl terminate-user $USER"]
  //           running: false
  //         }
  //
  //         Image {
  //           anchors.centerIn: parent
  //           anchors.horizontalCenterOffset: 2
  //           width: iconSizes  - 2
  //           height: iconSizes - 2
  //           source: `file://${Config.configPath}/light/icons/logoutPix.svg`
  //           fillMode: Image.PreserveAspectFit
  //           antialiasing: true
  //           smooth: true
  //           mipmap: true
  //         }
  //       }
  //     }
  //
  //     // Square Button 3
  //     Item {
  //       width: buttonSizes + buttonFloatAmount
  //       height: buttonSizes 
  //
  //       Rectangle {
  //         width: buttonSizes
  //         height: buttonSizes
  //         anchors.bottom: parent.bottom
  //         anchors.right: parent.right
  //         anchors.rightMargin: mouseArea3.containsMouse ? buttonFloatAmount : 0
  //         radius: Config.dashInnerModuleRadius
  //         color: mouseArea3.containsMouse ? Colors.accentColor : Colors.powerButtons
  //         border.width: buttonBorderWidth
  //         border.color: Colors.borderColor
  //
  //         Behavior on color {
  //           ColorAnimation { duration: 200 }
  //         }
  //
  //         Behavior on anchors.rightMargin {
  //           NumberAnimation { duration: 200 }
  //         }
  //
  //         MouseArea {
  //           id: mouseArea3
  //           anchors.fill: parent
  //           cursorShape: Qt.PointingHandCursor
  //           hoverEnabled: true
  //           onClicked: {
  //             process7.running = true
  //           }
  //         }
  //
  //         Process {
  //           id: process7
  //           command: ["bash", "-c", "hyprlock"]
  //           running: false
  //         }
  //
  //         Image {
  //           anchors.centerIn: parent
  //           width: iconSizes - 2
  //           height: iconSizes - 2
  //           source: `file://${Config.configPath}/light/icons/padlockPix.svg`
  //           fillMode: Image.PreserveAspectFit
  //           antialiasing: true
  //           smooth: true
  //           mipmap: true
  //         }
  //       }
  //     }
  //
  //     // Square Button 4
  //     Item {
  //       width: buttonSizes + buttonFloatAmount
  //       height: buttonSizes 
  //
  //       Rectangle {
  //         width: buttonSizes
  //         height: buttonSizes
  //         anchors.bottom: parent.bottom
  //         anchors.right: parent.right
  //         anchors.rightMargin: mouseArea4.containsMouse ? buttonFloatAmount : 0
  //         radius: Config.dashInnerModuleRadius
  //         color: mouseArea4.containsMouse ? Colors.accentColor : Colors.powerButtons
  //         border.width: buttonBorderWidth
  //         border.color: Colors.borderColor
  //
  //         Behavior on color {
  //           ColorAnimation { duration: 200 }
  //         }
  //
  //         Behavior on anchors.rightMargin {
  //           NumberAnimation { duration: 200 }
  //         }
  //
  //         MouseArea {
  //           id: mouseArea4
  //           anchors.fill: parent
  //           cursorShape: Qt.PointingHandCursor
  //           hoverEnabled: true
  //           onClicked: {
  //             process8.running = true
  //           }
  //         }
  //
  //         Process {
  //           id: process8
  //           command: ["bash", "-c", "alacritty -e nvim ~/.config/rumda-pistachio/README.md"]
  //           running: false
  //         }
  //
  //         Image {
  //           anchors.centerIn: parent
  //           width: iconSizes 
  //           height: iconSizes 
  //           source: `file://${Config.configPath}/light/icons/readmePix.svg`
  //           fillMode: Image.PreserveAspectFit
  //           antialiasing: true
  //           smooth: true
  //           mipmap: true
  //         }
  //       }
  //     }
  //   }  
  // } // END OF COLUMN
}  // end of rectangle that contains this whole module (the bg rectangle)


