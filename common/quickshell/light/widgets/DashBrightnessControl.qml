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






Column {
  property int columnSpacing: 10
  readonly property int buttonSizes: 51
  readonly property int buttonSpacing: 7
  readonly property int buttonBorderWidth: 0
  readonly property int pfpRadius: 100
  readonly property int pfpSize: 160
  readonly property int buttonsGapFromBottom: 15
  readonly property int iconSizes: 27
  readonly property int buttonFloatAmount: 6    
  x: -17

  // ===============================================
  // CONTROL BUTTONS
  // ===============================================
  //
  // brightness control buttons (experimental)
  //
  // Brightness Control Section
  Item {
    id: brightnessControlWrapper
    width: buttonSizes
    height: ((buttonSizes + buttonFloatAmount) * 2 + brightnessDisplayRect.height + columnSpacing * 2) + 20

    
    Column {
      anchors.fill: parent
      spacing: columnSpacing 
      
      // Brightness Up Button
      Item {
        width: buttonSizes
        height: buttonSizes + buttonFloatAmount
        
        Rectangle {
          id: brightnessUpButton
          width: buttonSizes
          height: buttonSizes
          anchors.top: parent.top
          anchors.topMargin: mouseAreaBrightnessUp.containsMouse ? -buttonFloatAmount : 0
          anchors.horizontalCenter: parent.horizontalCenter
          radius: Config.dashInnerModuleRadius
          color: mouseAreaBrightnessUp.containsMouse ? Colors.accentColor : Colors.powerButtons 
          border.width: buttonBorderWidth
          border.color: Colors.borderColor
          
          Behavior on color {
            ColorAnimation { duration: 200 }
          }
          
          Behavior on anchors.topMargin {
            NumberAnimation { duration: 200 }
          }
          
          MouseArea {
            id: mouseAreaBrightnessUp
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            hoverEnabled: true
            onClicked: {
              processBrightnessUp.running = true
            }
          }
          
          Process {
            id: processBrightnessUp
            command: useDdcutil ? 
              ["ddcutil", "setvcp", "10", "+", "10"] : 
              ["brightnessctl", "-c", "backlight", "set", "10%+"]
            running: false
          }
          
          Image {
            anchors.centerIn: parent
            width: iconSizes - 2
            height: iconSizes - 2
            source: `file://${Config.configPath}/light/icons/dashboard/chevronUP.svg`
            fillMode: Image.PreserveAspectFit
            antialiasing: true
            smooth: true
            mipmap: true
          }
        }
      }
      
      // Brightness Display Rectangle
      Rectangle {
        id: brightnessDisplayRect
        width: buttonSizes
        height: buttonSizes + 10
        radius: Config.dashInnerModuleRadius
        color: mouseAreaBrightnessDisplay.containsMouse ? Colors.accentColor : Colors.powerButtons 
        border.width: buttonBorderWidth
        border.color: Colors.borderColor

        Behavior on color {
          ColorAnimation { duration: 200 }
        }


        MouseArea {
          id: mouseAreaBrightnessDisplay
          anchors.fill: parent
          cursorShape: Qt.PointingHandCursor
          hoverEnabled: true
        }

        Column {
          anchors.centerIn: parent
          spacing: 4
          
          Image {
            anchors.horizontalCenter: parent.horizontalCenter
            width: iconSizes 
            height: iconSizes
            source: `file://${Config.configPath}/light/icons/dashboard/brightness.svg`
            fillMode: Image.PreserveAspectFit
            antialiasing: true
            smooth: true
            mipmap: true
          }
          
          Text {
            id: brightnessText
            anchors.horizontalCenter: parent.horizontalCenter
            text: brightnessValue
            color: mouseAreaBrightnessDisplay.containsMouse ? Colors.dashModulesColor : Colors.accent2Color               
            font.pixelSize: 10
            font.bold: false

            Behavior on color {
              ColorAnimation { duration: 200 }
            }
            
            property string brightnessValue: "50%"
            
            Process {
              id: brightnessReader
              command: ["sh", "-c", "brightnessctl -c backlight 2>/dev/null | grep -oP '\\(\\K[0-9]+(?=%\\))' || ddcutil getvcp 10 2>/dev/null | grep -oP 'current value =\\s+\\K[0-9]+'"]
              running: true
                            
              stdout: SplitParser {
                onRead: data => {
                  brightnessText.brightnessValue = data.trim() + "%"
                }
              }
            }
            
            Timer {
              interval: 500
              running: true
              repeat: true
              onTriggered: brightnessReader.running = true
            }
          }
        }
      }
      
      // Brightness Down Button
      Item {
        width: buttonSizes
        height: buttonSizes + buttonFloatAmount
        
        Rectangle {
          id: brightnessDownButton
          width: buttonSizes
          height: buttonSizes
          anchors.bottom: parent.bottom
          anchors.bottomMargin: mouseAreaBrightnessDown.containsMouse ? -buttonFloatAmount : 0
          anchors.horizontalCenter: parent.horizontalCenter
          radius: Config.dashInnerModuleRadius
          color: mouseAreaBrightnessDown.containsMouse ? Colors.accentColor : Colors.powerButtons 
          border.width: buttonBorderWidth
          border.color: Colors.borderColor
          
          Behavior on color {
            ColorAnimation { duration: 200 }
          }
          
          Behavior on anchors.bottomMargin {
            NumberAnimation { duration: 200 }
          }
          
          MouseArea {
            id: mouseAreaBrightnessDown
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            hoverEnabled: true
            onClicked: {
              processBrightnessDown.running = true
            }
          }
          
          Process {
            id: processBrightnessDown
            command: useDdcutil ? 
              ["ddcutil", "setvcp", "10", "-", "10"] : 
              ["brightnessctl", "-c", "backlight", "set", "10%-"]
            running: false
          }
          
          Image {
            anchors.centerIn: parent
            width: iconSizes - 2
            height: iconSizes - 2
            source: `file://${Config.configPath}/light/icons/dashboard/chevronDOWN.svg`
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

