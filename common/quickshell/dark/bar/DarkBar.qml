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
import qs.dark.barModules
import qs.dark.widgets
import qs.dark.config
import qs.dark.barSections
import qs

Scope {
  id: barScope
  
  // SIGNAL: Emitted when exit animation completes
  signal exitAnimationDone()
  
  // SIGNAL: Emitted when enter animation completes
  signal enterAnimationDone()
  
  // FUNCTION: Called by parent (shell.qml) to start exit animation
  function animateOut() {
    barRectangle.slideToTop()
  }
  
  // FUNCTION: Called automatically when this bar is first created
  function animateIn() {
    barRectangle.slideFromBottom()
  }
  
  // AUTO-CONNECT: When exit animation finishes, notify parent
  onExitAnimationDone: {
    barLoader.barExitComplete()
  }
  
  // Shadow
  Loader {
    active: Config.enableBarShadow
    sourceComponent: WlrLayershell {
      id: barShadow
      property int screenHeight: ScreenConf.screenHeight ? screen.height : 1080
      margins { 
        top: Config.barMarginTop + Config.shadowOffsetY
        left: Config.barMarginLeft + Config.shadowOffsetX
      }
      anchors { top: true; left: true }
      layer: WlrLayer.Bottom
      width: Config.barWidth + 5
      height: screenHeight - Config.barMarginTop - Config.barMarginBottom + 5
      color: "transparent"
      
      Behavior on margins.top {
        NumberAnimation {
          duration: 300
          easing.type: Easing.InOutQuad
        }
      }
      
      Repeater {
        model: [
          { size: 0, opacity: 0.3, radius: 8 },
          { size: 2, opacity: 0.33, radius: 8 },
          { size: 4, opacity: 0.4, radius: 8 }
        ]
        
        Rectangle {
          required property var modelData
          anchors.centerIn: parent
          width: parent.width - modelData.size
          height: parent.height - modelData.size
          color: Colors.shadowColor
          opacity: modelData.opacity
          radius: modelData.radius
        }
      }
    }
  }

  // Main Bar
  PopoutVolume {}
  
  WlrLayershell {
    id: bar 
    anchors { top: true; bottom: true; left: true }
    layer: WlrLayer.Top
    implicitWidth: Config.barWidth + Config.barBorderWidth
    color: "transparent"
    
    margins { 
      top: 0
      left: Config.barMarginLeft
      right: Config.barMarginRight
      bottom: 0
    }
    
    MouseArea {
      anchors.fill: parent
      onWheel: wheel => {
        Hyprland.dispatch("workspace 1")
      }
    }
    
    Rectangle {
      id: barRectangle
      anchors.fill: parent
      anchors.horizontalCenter: bar.horizontalCenter
      color: Colors.backgroundColor
      radius: Config.barRadius
      border.width: Config.barBorderWidth
      border.color: Colors.borderColor
      anchors.topMargin: Config.barMarginTop
      anchors.bottomMargin: Config.barMarginBottom
      implicitWidth: Config.barWidth
      
      // LIFECYCLE: When bar is first created, start at bottom and animate in
      Component.onCompleted: {
        anchors.topMargin = ScreenConf.screenHeight + 20  // Start below screen
        Qt.callLater(() => slideFromBottom())  // Wait one frame then animate in
      }
      
      // FUNCTION: Slide bar up off screen (exit animation)
      function slideToTop() {
        anchors.topMargin = -height  // Move above screen
      }
      
      // FUNCTION: Slide bar up from bottom to normal position (enter animation)
      function slideFromBottom() {
        anchors.topMargin = Config.barMarginTop  // Move to normal position
      }
      
      // ANIMATION: Smooth transition for topMargin changes
      Behavior on anchors.topMargin {
        NumberAnimation {
          duration: 500
          easing.type: Easing.InOutQuad
          
          // CALLBACK: When animation finishes, emit appropriate signal
          onRunningChanged: {
            if (!running) {  // Animation just stopped
              // Check if we're off-screen (exit complete)
              if (barRectangle.anchors.topMargin < 0) {
                barScope.exitAnimationDone()
              }
              // Check if we're at normal position (enter complete)
              else if (barRectangle.anchors.topMargin === Config.barMarginTop) {
                barScope.enterAnimationDone()
              }
            }
          }
        }
      }
      
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
