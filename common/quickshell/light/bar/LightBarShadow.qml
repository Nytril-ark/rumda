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
import qs.light.bars


Scope {
    WlrLayershell {
      id: barShadow
      margins { 
        top: Config.barMarginTop + Config.shadowOffsetY
        left: Config.barMarginLeft + Config.shadowOffsetX
      }
      anchors { top: true; left: true }
      layer: WlrLayer.Bottom
      width: Config.barWidth + 4
      height: Config.barHeight + 4
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
