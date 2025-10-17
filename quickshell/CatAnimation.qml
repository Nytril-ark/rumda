import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Hyprland
import Qt5Compat.GraphicalEffects

Item {
  id: catRoot
  
  // Properties passed from shell.qml
  required property bool enableCat
  required property string catIconPath
  required property int catMarginTop
  required property int catMarginLeft
  required property int catWidth
  required property int catHeight
  required property string catAnimationFolder
  required property int catAnimationFrames
  required property var catFrameConfigs
  required property int barMarginTop
  required property int barWidth
  
  // Internal state
  property bool catAnimationPlaying: false
  property bool catVisible: true
  property bool catReturning: false
  
  // ==================== STATIC CAT WIDGET ====================
  
  Loader {
    active: catRoot.enableCat && catRoot.catVisible && !catRoot.catAnimationPlaying && !catRoot.catReturning
    sourceComponent: Item {
      WlrLayershell {
        id: catsit
        margins { 
          top: catRoot.catMarginTop
          left: catRoot.catMarginLeft
        }
        anchors { top: true; left: true }
        layer: WlrLayer.Top
        implicitWidth: catRoot.catWidth
        color: "transparent"
        
        Rectangle {
          width: catRoot.catWidth
          height: catRoot.catHeight
          color: "transparent"
          clip: true
          
          Image {
            anchors.fill: parent
            source: `file://${catRoot.catIconPath}`
            fillMode: Image.PreserveAspectFit
            antialiasing: true
            smooth: true
            mipmap: true
            
            onStatusChanged: {
              if (status === Image.Error) {
                console.error("Failed to load cat icon from:", catRoot.catIconPath)
              }
            }
          }
          
          MouseArea {
            anchors.fill: parent
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
    active: catRoot.enableCat && !catRoot.catVisible
    sourceComponent: WlrLayershell {
      id: catTrigger
      margins { 
        top: catRoot.barMarginTop
        left: -43
      }
      anchors { top: true; left: true }
      layer: WlrLayer.Overlay
      implicitWidth: catRoot.barWidth
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
    active: catRoot.enableCat && catRoot.catAnimationPlaying
    sourceComponent: Item {
      WlrLayershell {
        id: animatedCat
        
        property int currentFrame: 0
        property var currentConfig: catRoot.catFrameConfigs[currentFrame] || catRoot.catFrameConfigs[0]
        
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
            
            source: `file://${catRoot.catAnimationFolder}/f${animatedCat.currentFrame}.png`
            
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
                
                if (animatedCat.currentFrame >= catRoot.catAnimationFrames) {
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
    active: catRoot.enableCat && catRoot.catReturning
    sourceComponent: Item {
      WlrLayershell {
        id: returningCat
        
        property int currentFrame: catRoot.catAnimationFrames - 1
        property var currentConfig: catRoot.catFrameConfigs[currentFrame] || catRoot.catFrameConfigs[catRoot.catAnimationFrames - 1]
        
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
            
            source: `file://${catRoot.catAnimationFolder}/f${returningCat.currentFrame}.png`
            
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
