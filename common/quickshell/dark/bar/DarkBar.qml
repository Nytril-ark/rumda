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
  property int margint: Config.barMarginTop
  property int marginb: Config.barMarginBottom 

  signal barAnimate()
  signal barSignalTheme()
  function animationTrig() {
    console.log("Bar animation triggered!")
      margint = Config.syncTbar
      marginb = Config.syncBbar 
      barSignalTheme()
      // barShadow.margins.top = bar.margins.top + Config.barMarginTop + Config.shadowOffsetY 
      // barShadow.margins.bottom = bar.margins.bottom + Config.barMarginBottom - Config.shadowOffsetY
      // barShadow.margins.top = -ScreenConf.screenHeight
      // barShadow.margins.bottom = ScreenConf.screenHeight
  }


  Behavior on margint {
    NumberAnimation {
      duration: 500
      easing.type: Easing.InOutQuad
    }
  }
  Behavior on marginb {
      NumberAnimation {
      duration: 500
      easing.type: Easing.InOutQuad
    }
  }



    // Animation functions exposed to parent
    // Note to self: well.. this works.. 
    // what I understand is that we're wrapping
    // the rectangle's function to expose it to the 
    // parent (aka, shell.qml) because it can't 
    // access it directly, and rather accesses
    // this scope




  // ================shadow=======================
 Loader {
    active: Config.enableBarShadow
    sourceComponent: WlrLayershell {
      id: barShadow
      property int screenHeight: ScreenConf.screenHeight ? screen.height : 1080 // screenheight or default
      margins {
        left: Config.barMarginLeft + Config.shadowOffsetX
        top: barScope.margint  + Config.shadowOffsetY 
        bottom : barScope.marginb  - Config.shadowOffsetY
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
     Behavior on margins.bottom {
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
        left: Config.barMarginLeft
        right: Config.barMarginRight
        top: 0 
        bottom : 0
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
        anchors.fill: parent
        anchors.horizontalCenter: bar.horizontalCenter
        color: Colors.backgroundColor
        radius: Config.barRadius
        border.width: Config.barBorderWidth
        border.color: Colors.borderColor
        implicitWidth: Config.barWidth
        anchors.topMargin: barScope.margint
        anchors.bottomMargin: barScope.marginb


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
          BottomSection {
            onBarAnimate: animationTrig()
          }
        }
      }
    }
  }
