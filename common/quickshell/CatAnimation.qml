import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Hyprland
import Qt5Compat.GraphicalEffects
import qs.light.config

Item {
  id: catRoot
  

  
  // Internal state
  property bool catAnimationPlaying: false
  property bool catVisible: true
  property bool catReturning: false
  
  // ==================== STATIC CAT WIDGET ====================
  
  Loader {
    active: Config.enableCat && catRoot.catVisible && !catRoot.catAnimationPlaying && !catRoot.catReturning
    sourceComponent: Item {
      WlrLayershell {
        id: catsit
        margins { 
          top: Config.catMarginTop
          left: Config.catMarginLeft
        }
        anchors { top: true; left: true }
        layer: WlrLayer.Top
        implicitWidth: Config.catWidth
        color: "transparent"
        
        Rectangle {
          width: Config.catWidth
          height: Config.catHeight
          color: "transparent"
          clip: true
          
          Image {
            anchors.fill: parent
            source: `file://${Config.catIconPath}`
            fillMode: Image.PreserveAspectFit
            antialiasing: true
            smooth: true
            mipmap: true
            
            onStatusChanged: {
              if (status === Image.Error) {
                console.error("Failed to load cat icon from:", Config.catIconPath)
              }
            }
          }
          
          MouseArea {
            anchors.fill: parent
            anchors.topMargin: 2
            anchors.bottomMargin: 36  // this makes the cat's tail unclickable, dont wanna interfere with the clock
            cursorShape: Qt.PointingHandCursor
            onClicked: {
              catRoot.catAnimationPlaying = true
            }
          }
        }
      }
    }
  }
  
  // ==================== CAT RETURN TRIGGER ====================
  
  Loader {
    active: Config.enableCat && !catRoot.catVisible
    sourceComponent: WlrLayershell {
      id: catTrigger
      margins { 
        top: Config.barMarginTop
        left: -43
      }
      anchors { top: true; left: true }
      layer: WlrLayer.Overlay
      implicitWidth: Config.barWidth
      implicitHeight: 20
      color: "transparent"
      
      Rectangle {
        anchors.fill: parent
        color: "transparent"
        
        MouseArea {
          anchors.fill: parent
          cursorShape: Qt.PointingHandCursor
          onClicked: {
            catRoot.catReturning = true
          }
        }
      }
    }
  }
  
  // ==================== ANIMATED CAT WIDGET (LEAVING) ====================
  
  Loader {
    active: Config.enableCat && catRoot.catAnimationPlaying
    sourceComponent: Item {
      WlrLayershell {
        id: animatedCat
        
        property int currentFrame: 0
        property var currentConfig: Config.catFrameConfigs[currentFrame] || Config.catFrameConfigs[0]
        
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
            rotation: animatedCat.currentConfig.rotation || 0  
            Behavior on rotation {
              NumberAnimation { 
                duration: animatedCat.currentConfig.delay
                easing.type: Easing.Linear 
              }
            }


            source: `file://${Config.catAnimationFolder}/f${animatedCat.currentFrame}.png`
            
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
                
                if (animatedCat.currentFrame >= Config.catAnimationFrames) {
                  catRoot.catAnimationPlaying = false
                  catRoot.catVisible = false
                } else {
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
    active: Config.enableCat && catRoot.catReturning
    sourceComponent: Item {
      WlrLayershell {
        id: returningCat
        
        property int currentFrame: Config.catAnimationFrames - 1
        property var currentConfig: Config.catFrameConfigs[currentFrame] || Config.catFrameConfigs[Config.catAnimationFrames - 1]
        
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
            rotation: returningCat.currentConfig.rotation || 0 
            Behavior on rotation {
              NumberAnimation { 
                duration: returningCat.currentConfig.delay
                easing.type: Easing.Linear 
              }
            }


            source: `file://${Config.catAnimationFolder}/f${returningCat.currentFrame}.png`
            
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
                  catRoot.catReturning = false
                  catRoot.catVisible = true
                } else {
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
}
