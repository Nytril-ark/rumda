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
import qs.light.barModules
import qs.light.widgets
import qs.light.config
import qs.light.barSections

// ==================== MAIN BAR ====================
  
  Scope {
    id: barScope
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
          // this ^ pauses on wspace switch, which i dont like
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
