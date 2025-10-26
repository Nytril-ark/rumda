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
import qs.dark.bar
import qs.dark.barSections
import qs.dark.config
import qs.dark.widgets
import qs

  
Scope {

    id: barScope
    // Animation functions exposed to parent
    // Note to self: well.. this works.. 
    // what I understand is that we're wrapping
    // the rectangle's function to expose it to the 
    // parent (aka, shell.qml) because it can't 
    // access it directly, and rather accesses
    // this scope
    function animateOut() {
      barRectangle.animateToTop()
    }
    
    function animateIn() {
      barRectangle.animateFromBottom()
    }


  // ================shadow=======================
 Loader {
    active: Config.enableBarShadow
    sourceComponent: WlrLayershell {
      id: barShadow
      property int screenHeight: ScreenConf.screenHeight ? screen.height : 1080 // screenheight or default
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
// ==================== MAIN BAR ====================

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
          // Mpris.players.values.forEach((player, idx) => player.pause())
          // this ^ pauses on wspace switch, which i dont like
        }
      }
      
      Rectangle {
        id: barRectangle
        property bool isAnimatingOut: false
        property bool isAnimatingIn: false     
        anchors.fill: parent
        anchors.horizontalCenter: bar.horizontalCenter
        color: Colors.backgroundColor
        radius: Config.barRadius
        border.width: Config.barBorderWidth
        border.color: Colors.borderColor
        anchors.topMargin: Config.barMarginTop
        anchors.bottomMargin: Config.barMarginBottom
        implicitWidth: Config.barWidth

        Behavior on height {
          NumberAnimation {
            duration: 1000
            easing.type: Easing.InOutQuart
          }
        }

        Component.onCompleted: {
          if (barLoader.animationState === "entering") {
            anchors.topMargin = ScreenConf.screenHeight + 20  // Start from bottom + a few px for good measure
            animateFromBottom()
          }
        }


        function animateToTop() {
          isAnimatingOut = true
          anchors.topMargin = -height  // Slide up
        }
        
        function animateFromBottom() {
          isAnimatingIn = true
          anchors.topMargin = Config.barMarginTop  // Slide to normal position
        }

        Behavior on anchors.topMargin {
          NumberAnimation {
            duration: 500
            easing.type: Easing.InOutQuad
            
            onRunningChanged: {
              if (!running) {
                if (barRectangle.isAnimatingOut) {
                  barRectangle.isAnimatingOut = false
                  barLoader.onExitComplete()
                }
                if (barRectangle.isAnimatingIn) {
                  barRectangle.isAnimatingIn = false
                  barLoader.onEnterComplete()
                }
              }
            }
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
