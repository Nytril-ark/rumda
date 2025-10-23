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
import qs.barModules
import qs.widgets
import qs.config

ShellRoot {
  id: root



  signal triggerBarAnimation()


// ==================== CONFIGURATION ====================
// configuration moved to /config/Config.qml for now  
  // EXPERIMENTAL ======== rumda-the-cat ========
  // ============================================
  //
  // ==================== TESTING THE CAT WIDGET ====================
    
    // Example 1: Static cat in center
    // Widgets.Rumda_the_cat {
    //     position: "center"
    //     catWidth: 150
    //     catHeight: 150
    // }
    // ================================ 
    // Widgets.Rumda_the_cat {
    //     position: "custom"
    //     customX: 400
    //     customY: 400
    //     catWidth: 100
    //     catHeight: 100
    //     enableMovement: true
    //     movementDirection: "right"
    //     movementSpeed: 2000  // milliseconds to cross screen
    // }
    
    // Example 3: Cat bouncing back and forth at top
    // Widgets.Rumda_the_cat {
    //     position: "top-left"
    //     catWidth: 80
    //     catHeight: 80
    //     enableMovement: true
    //     movementDirection: "right"
    //     movementSpeed: 3000
    //     movementBounce: true
    // }
    
    // Example 4: Custom positioned cat
    // Widgets.Rumda_the_cat {
    //     position: "custom"
    //     customX: 100
    //     customY: 200
    //     catWidth: 120
    //     catHeight: 120
    //     catLayer: WlrLayer.Overlay  // Display on top
    // }
    
    // Example 5: Cat walking up the screen
    // Widgets.Rumda_the_cat {
    //     position: "bottom-left"
    //     enableMovement: true
    //     movementDirection: "up"
    //     movementSpeed: 4000
    // }

    
    // control:
    // Widgets.AnimatedCat {
    //   id: myCat
    // }
    //
    // // Control playback
    // Button { onClicked: myCat.play() }
    // Button { onClicked: myCat.pause() }
    // Button { onClicked: myCat.stop() }
    //
    // // Control movement
    // Button { onClicked: myCat.startMovement() }
    // Button { onClicked: myCat.stopMovement() }

  


  //==============================================================
  // The current animation isn't great, I plan on improving
  // its smoothness soon. I shall keep it like this for now
  // as a placeholder
  //
  property var catFrameConfigs: [
    { marginTop: 25, marginLeft: -85, width: 140, height: 90, delay: 10, rotation: 0 },
    { marginTop: 20, marginLeft: -90, width: 140, height: 92, delay: 25, rotation: 0 },
    { marginTop: 15, marginLeft: -90, width: 140, height: 94, delay: 25, rotation: 14 },
    { marginTop: 13, marginLeft: -90, width: 150, height: 96, delay: 25, rotation: 14 },
    { marginTop: 15, marginLeft: -115, width: 160, height: 98, delay: 30, rotation: 0 },
    { marginTop: 9, marginLeft: -120, width: 170, height: 96, delay: 30, rotation: 0 },
    { marginTop: 2, marginLeft: -150, width: 180, height: 94, delay: 25, rotation: 0 },
    { marginTop: -6, marginLeft: -170, width: 190, height: 92, delay: 20, rotation: 0 },
    { marginTop: -16, marginLeft: -190, width: 200, height: 90, delay: 20, rotation: 0 }
  ]

  CatAnimation {}


// ==================== BAR SHADOW ====================
Loader {


    active: Config.enableBarShadow
    sourceComponent: WlrLayershell {
      id: barShadow
      margins { 
        top: Config.barMarginTop + Config.shadowOffsetY
        left: Config.barMarginLeft + Config.shadowOffsetX
      }
      anchors { top: true; left: true }
      layer: WlrLayer.Bottom
      width: bar.width + 4
      height: bar.height + 4
      color: "transparent"

      Connections {
        target: root
        function onTriggerBarAnimation() {
          console.log("Bar animation triggered!")
          barShadow.margins.top = -barShadow.height
        }
      }


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
  
  Scope {
    id: barScope

    Connections {
      target: root
      function onTriggerBarAnimation() {
        console.log("Bar animation triggered!")
        barRect.anchors.topMargin = -bar.height
        barRect.anchors.bottomMargin = bar.height
      }
    }
    


    PopoutVolume {}
    
    WlrLayershell {
      id: bar
      property int screenHeight: screen ? screen.height : 1080
      
      margins { 
        top: Config.barMarginTop
        left: Config.barMarginLeft
        right: Config.barMarginRight
        bottom: Config.barMarginBottom
      }


      anchors { top: true; bottom: true; left: true }
      layer: WlrLayer.Top
      implicitWidth: Config.barWidth
      implicitHeight: screenHeight - Config.barMarginTop - Config.barMarginBottom
      color: "transparent"
      
      MouseArea {
        anchors.fill: parent
        onWheel: wheel => {
          Hyprland.dispatch("workspace 1")
          // Mpris.players.values.forEach((player, idx) => player.pause())
        }
      }
      
      Rectangle {
        id: barRect
        anchors.fill: parent
        color: Colors.backgroundColor
        radius: Config.barRadius
        border.width: Config.barBorderWidth
        border.color: Colors.borderColor
  

        Behavior on height {
          NumberAnimation {
            duration: 1000
            easing.type: Easing.InOutQuart
          }
        }

        Behavior on anchors.topMargin {
            NumberAnimation {
              duration: 500
              easing.type: Easing.InOutQuad
          }
        }
       Behavior on anchors.bottomMargin {
            NumberAnimation {
              duration: 500
              easing.type: Easing.InOutQuad
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
