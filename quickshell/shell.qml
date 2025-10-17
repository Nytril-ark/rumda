//@ pragma UseQApplication
//@ pragma Env QS_NO_RELOAD_POPUP=1
//@ pragma Env QT_QUICK_CONTROLS_STYLE=Basic
//@ pragma Env QT_QUICK_FLICKABLE_WHEEL_DECELERATION=10000
pragma ComponentBehavior: Bound

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
import 'bar' as Bar

ShellRoot {
  id: root
  
// ==================== CONFIGURATION ====================
  // User Configuration
  property string username: Quickshell.env("USER") || "user"
  property string configPath: Quickshell.env("HOME") + "/.config/rumda/quickshell"
  
  // Color Palette
  property color backgroundColor: "#E4C198"
  property color surfaceColor: "#AF8C65"
  property color borderColor: "#D1AB86"
  property color accentColor: "#AD704A"
  property color accentLightColor: "#F6CD96"
  property color errorColor: "#9A4235"
  property color backgroundTransparent: "#661e1e1e"
  property color shadowColor: "#3A2D26"
  
  // Bar Configuration
  property int barMarginTop: 80
  property int barMarginBottom: 60
  property int barMarginLeft: 19
  property int barMarginRight: -7
  property int barWidth: 50
  property int barRadius: 8
  property int barBorderWidth: 2
  
  // Cat Configuration
  property bool enableCat: true
  property string catIconPath: configPath + "/icons/catsit.svg"
  property int catMarginTop: 23
  property int catMarginLeft: -50
  property int catWidth: 50
  property int catHeight: 90
  
  // Cat Animation Configuration
  property string catAnimationFolder: configPath + "/gato-jump"
  property int catAnimationFrames: 9
  
  // Per-frame configuration: [marginTop, marginLeft, width, height, delay]
  property var catFrameConfigs: [
    { marginTop: 25, marginLeft: -85, width: 140, height: 90, delay: 80 },  // f0
    { marginTop: 20, marginLeft: -90, width: 140, height: 92, delay: 80 },  // f1
    { marginTop: 19, marginLeft: -90, width: 140, height: 94, delay: 80 },  // f2
    { marginTop: 16, marginLeft: -90, width: 140, height: 96, delay: 70 },  // f3
    { marginTop: 12, marginLeft: -90, width: 140, height: 98, delay: 60 },  // f4
    { marginTop: 9, marginLeft: -110, width: 140, height: 96, delay: 55 },  // f5
    { marginTop: 6, marginLeft: -130, width: 140, height: 94, delay: 55 },  // f6
    { marginTop: 3, marginLeft: -160, width: 160, height: 92, delay: 55 },  // f7
    { marginTop: 1, marginLeft: -200, width: 140, height: 90, delay: 55 }   // f8
  ]
  
  // Shadow Configuration
  property bool enableBarShadow: true
  property bool enableCatShadow: true
  property int shadowOffsetX: -59
  property int shadowOffsetY: 2
  
 // Animation state
  property bool catAnimationPlaying: false
  property bool catVisible: true
  property bool catReturning: false
  
  // ==================== STATIC CAT WIDGET ====================
  
  Loader {
    active: root.enableCat && root.catVisible && !root.catAnimationPlaying && !root.catReturning
    sourceComponent: Item {
      WlrLayershell {
        id: catsit
        margins { 
          top: root.catMarginTop
          left: root.catMarginLeft
        }
        anchors { top: true; left: true }
        layer: WlrLayer.Overlay
        implicitWidth: root.catWidth
        color: "transparent"
        
        Rectangle {
          width: root.catWidth
          height: root.catHeight
          color: "transparent"
          clip: true
          
          Image {
            anchors.fill: parent
            source: `file://${root.catIconPath}`
            fillMode: Image.PreserveAspectFit
            antialiasing: true
            smooth: true
            mipmap: true
            
            onStatusChanged: {
              if (status === Image.Error) {
                console.error("Failed to load cat icon from:", root.catIconPath)
              }
            }
          }
          
          MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: {
              root.catAnimationPlaying = true
            }
          }
        }
      }
    }
  }
  
  // ==================== CAT RETURN TRIGGER ====================
  
  Loader {
    active: root.enableCat && !root.catVisible
    sourceComponent: WlrLayershell {
      id: catTrigger
      margins { 
        top: root.barMarginTop
        left: -43
      }
      anchors { top: true; left: true }
      layer: WlrLayer.Overlay
      implicitWidth: root.barWidth
      implicitHeight: 20
      color: "transparent"
      
      Rectangle {
        anchors.fill: parent
        color: "transparent"
        
        MouseArea {
          anchors.fill: parent
          cursorShape: Qt.PointingHandCursor
          onClicked: {
            root.catReturning = true
          }
        }
      }
    }
  }
  
  // ==================== ANIMATED CAT WIDGET (LEAVING) ====================
  
  Loader {
    active: root.enableCat && root.catAnimationPlaying
    sourceComponent: Item {
      WlrLayershell {
        id: animatedCat
        
        property int currentFrame: 0
        property var currentConfig: root.catFrameConfigs[currentFrame] || root.catFrameConfigs[0]
        
        margins { 
          top: currentConfig.marginTop
          left: currentConfig.marginLeft
        }
        anchors { top: true; left: true }
        layer: WlrLayer.Overlay
        implicitWidth: currentConfig.width
        color: "transparent"
        
        Behavior on margins.top {
          NumberAnimation { 
            duration: animatedCat.currentConfig.delay
            easing.type: Easing.Linear 
          }
        }
        Behavior on margins.left {
          NumberAnimation { 
            duration: animatedCat.currentConfig.delay
            easing.type: Easing.Linear 
          }
        }
        Behavior on implicitWidth {
          NumberAnimation { 
            duration: animatedCat.currentConfig.delay
            easing.type: Easing.Linear 
          }
        }
        
        Rectangle {
          width: animatedCat.currentConfig.width
          height: animatedCat.currentConfig.height
          color: "transparent"
          clip: true
          
          Behavior on width {
            NumberAnimation { 
              duration: animatedCat.currentConfig.delay
              easing.type: Easing.Linear 
            }
          }
          Behavior on height {
            NumberAnimation { 
              duration: animatedCat.currentConfig.delay
              easing.type: Easing.Linear 
            }
          }
          
          Image {
            id: animatedImage
            anchors.fill: parent
            fillMode: Image.PreserveAspectFit
            antialiasing: true
            smooth: true
            mipmap: true
            
            source: `file://${root.catAnimationFolder}/f${animatedCat.currentFrame}.png`
            
            onStatusChanged: {
              if (status === Image.Error) {
                console.error("Failed to load animation frame:", source)
              }
            }
            
            Timer {
              id: animationTimer
              interval: animatedCat.currentConfig.delay
              running: true
              repeat: false
              
              onTriggered: {
                animatedCat.currentFrame++
                
                if (animatedCat.currentFrame >= root.catAnimationFrames) {
                  // Animation finished - hide cat
                  root.catAnimationPlaying = false
                  root.catVisible = false
                } else {
                  // Continue to next frame
                  animationTimer.interval = animatedCat.currentConfig.delay
                  animationTimer.restart()
                }
              }
            }
          }
        }
      }
    }
  }
  
  // ==================== ANIMATED CAT WIDGET (RETURNING) ====================
  
  Loader {
    active: root.enableCat && root.catReturning
    sourceComponent: Item {
      WlrLayershell {
        id: returningCat
        
        property int currentFrame: root.catAnimationFrames - 1
        property var currentConfig: root.catFrameConfigs[currentFrame] || root.catFrameConfigs[root.catAnimationFrames - 1]
        
        margins { 
          top: currentConfig.marginTop
          left: currentConfig.marginLeft
        }
        anchors { top: true; left: true }
        layer: WlrLayer.Overlay
        implicitWidth: currentConfig.width
        color: "transparent"
        
        Behavior on margins.top {
          NumberAnimation { 
            duration: returningCat.currentConfig.delay
            easing.type: Easing.Linear 
          }
        }
        Behavior on margins.left {
          NumberAnimation { 
            duration: returningCat.currentConfig.delay
            easing.type: Easing.Linear 
          }
        }
        Behavior on implicitWidth {
          NumberAnimation { 
            duration: returningCat.currentConfig.delay
            easing.type: Easing.Linear 
          }
        }
        
        Rectangle {
          width: returningCat.currentConfig.width
          height: returningCat.currentConfig.height
          color: "transparent"
          clip: true
          
          Behavior on width {
            NumberAnimation { 
              duration: returningCat.currentConfig.delay
              easing.type: Easing.Linear 
            }
          }
          Behavior on height {
            NumberAnimation { 
              duration: returningCat.currentConfig.delay
              easing.type: Easing.Linear 
            }
          }
          
          Image {
            id: returningImage
            anchors.fill: parent
            fillMode: Image.PreserveAspectFit
            antialiasing: true
            smooth: true
            mipmap: true
            
            source: `file://${root.catAnimationFolder}/f${returningCat.currentFrame}.png`
            
            onStatusChanged: {
              if (status === Image.Error) {
                console.error("Failed to load animation frame:", source)
              }
            }
            
            Timer {
              id: returnTimer
              interval: returningCat.currentConfig.delay
              running: true
              repeat: false
              
              onTriggered: {
                returningCat.currentFrame--
                
                if (returningCat.currentFrame < 0) {
                  // Animation finished - show static cat
                  root.catReturning = false
                  root.catVisible = true
                } else {
                  // Continue to previous frame
                  returnTimer.interval = returningCat.currentConfig.delay
                  returnTimer.restart()
                }
              }
            }
          }
        }
      }
    }
  }
  
  // ==================== MAIN BAR ====================
  
  Scope {
    id: barScope
    
    Bar.PopoutVolume {}
    
    WlrLayershell {
      id: bar
      margins { 
        top: root.barMarginTop
        bottom: root.barMarginBottom
        left: root.barMarginLeft
        right: root.barMarginRight
      }
      anchors { top: true; bottom: true; left: true }
      layer: WlrLayer.Top
      implicitWidth: root.barWidth
      color: "transparent"
      
      MouseArea {
        anchors.fill: parent
        onWheel: wheel => {
          Hyprland.dispatch("workspace 1")
          Mpris.players.values.forEach((player, idx) => player.pause())
        }
      }
      
      Rectangle {
        anchors.fill: parent
        color: root.backgroundColor
        radius: root.barRadius
        border.width: root.barBorderWidth
        border.color: root.borderColor
        
        Behavior on height {
          NumberAnimation {
            duration: 1000
            easing.type: Easing.InOutQuart
          }
        }
        
        ColumnLayout {
          anchors { 
            fill: parent
            topMargin: -10
            bottomMargin: 10
            leftMargin: 3
            rightMargin: 3
          }
          spacing: 4
          
          TopSection {}
          CenterSection {}
          BottomSection {}
        }
      }
    }
  }
}
