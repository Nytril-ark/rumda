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





Rectangle {
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
  property int columnSpacing: 10
  readonly property int buttonSizes: 40
  readonly property int middleButtonHeight: 100 // extra height that the middle button has
  readonly property int iconSizes: 26
  readonly property int brightnessTextSize: 9
  readonly property int buttonBorderWidth: 0
  readonly property int buttonFloatAmount: 4    
  // brightness control stuff (bro im sleep deprived)
  property bool useDdcutil: false
  property bool brightnessChecked: false

  color: Colors.dashModulesColor
  border.width: Config.dashInnerModuleBorderWidth
  border.color: Colors.borderColor
  radius: Config.dashInnerModuleRadius

  Component.onCompleted: {
    brightnessDetector.running = true
  }

  // ==========================================
  // Detect which brightness control to use
  Process {
    id: brightnessDetector
    command: ["sh", "-c", "brightnessctl -c backlight info 2>/dev/null"]
    running: false
    
    stdout: SplitParser {
      onRead: data => {
        if (data.trim().length > 0) {
          useDdcutil = false
          console.log("Using brightnessctl for backlight")
        }
        brightnessChecked = true
      }
    }
    
    onExited: code => {
      if (code !== 0) {
        useDdcutil = true
        console.log("Using ddcutil for external monitor")
        brightnessChecked = true
      }
    }
  }



  Column {
      anchors.horizontalCenter : parent.horizontalCenter
      anchors.verticalCenter : parent.verticalCenter
    Item {
      id: brightnessControlWrapper
      anchors.horizontalCenter : parent.horizontalCenter
      anchors.verticalCenter : parent.verticalCenter
      width: buttonSizes
      height: ((buttonSizes + buttonFloatAmount) * 2 + brightnessDisplayRect.height + columnSpacing * 2) + 20

      
      Column {
        anchors.horizontalCenter : parent.horizontalCenter
        anchors.verticalCenter : parent.verticalCenter
        spacing: columnSpacing 
        
        // Brightness Up Button
        Item {
          width: buttonSizes
          height: buttonSizes + buttonFloatAmount
          
          Rectangle {
            id: brightnessUpButton
            Rectangle {
              anchors.top: brightnessUpButton.top
              anchors.bottom: brightnessUpButton.bottom
              anchors.left: brightnessUpButton.left
              anchors.rightMargin: Config.innerDSoffsetX
              anchors.bottomMargin: -Config.innerDSoffsetY
              implicitWidth: brightnessUpButton.implicitWidth + Config.innerDSoffsetX
              z: -99
              color: Colors.shadowColorDS
              radius: Config.innerDSRadius
            }

            width: buttonSizes
            height: buttonSizes
            anchors.top: parent.top
            anchors.topMargin: mouseAreaBrightnessUp.containsMouse ? -buttonFloatAmount : 0
            anchors.horizontalCenter: parent.horizontalCenter
            radius: Config.dashInnerModuleRadius
            color: mouseAreaBrightnessUp.containsMouse ? Colors.accentColor : Colors.powerButtons 
            border.width: buttonBorderWidth
            border.color: Colors.borderColor
            scale: mouseAreaBrightnessUp.containsMouse ? 0.95 : 1.0
               
            Behavior on scale {
              NumberAnimation { duration: 200 }
            }                 
            
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
          Rectangle {
              anchors.top: brightnessDisplayRect.top
              anchors.bottom: brightnessDisplayRect.bottom
              anchors.left: brightnessDisplayRect.left
              anchors.rightMargin: Config.innerDSoffsetX
              anchors.bottomMargin: -Config.innerDSoffsetY
              implicitWidth: brightnessDisplayRect.implicitWidth + Config.innerDSoffsetX
              z: -99
              color: Colors.shadowColorDS
              radius: Config.innerDSRadius
          }

          width: buttonSizes
          height: buttonSizes + middleButtonHeight  // bro i could use a layout but im too sleep deprived imma hardcode this rq sorry
          radius: Config.dashInnerModuleRadius
          color: mouseAreaBrightnessDisplay.containsMouse ? Colors.accentColor : Colors.powerButtons 
          border.width: buttonBorderWidth
          border.color: Colors.borderColor
          scale: mouseAreaBrightnessDisplay.containsMouse ? 1.05 : 1.0
         
          Behavior on scale {
            NumberAnimation { duration: 200 }
          }
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
            spacing: 5
            
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
              font.pixelSize: brightnessTextSize
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
                    brightnessText.brightnessValue = data.trim() 
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
            Rectangle {
              anchors.top: brightnessDownButton.top
              anchors.bottom: brightnessDownButton.bottom
              anchors.left: brightnessDownButton.left
              anchors.rightMargin: Config.innerDSoffsetX
              anchors.bottomMargin: -Config.innerDSoffsetY
              implicitWidth: brightnessDownButton.implicitWidth + Config.innerDSoffsetX
              z: -99
              color: Colors.shadowColorDS
              radius: Config.innerDSRadius
            }

            width: buttonSizes
            height: buttonSizes
            anchors.bottom: parent.bottom
            anchors.bottomMargin: mouseAreaBrightnessDown.containsMouse ? -buttonFloatAmount : 0
            anchors.horizontalCenter: parent.horizontalCenter
            radius: Config.dashInnerModuleRadius
            color: mouseAreaBrightnessDown.containsMouse ? Colors.accentColor : Colors.powerButtons 
            border.width: buttonBorderWidth
            border.color: Colors.borderColor
            scale: mouseAreaBrightnessDown.containsMouse ? 0.95 : 1.0
               
            Behavior on scale {
              NumberAnimation { duration: 200 }
            }                 
            
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
}
