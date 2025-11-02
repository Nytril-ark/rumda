import Quickshell.Io
import Quickshell
import Quickshell.Wayland
import Quickshell.Services.Pipewire
import Quickshell.Widgets
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import qs.light.config
import qs.light.widgets

Rectangle {
  id: dashBoardControls
  color: Colors.dashModulesColor
  border.width: Config.dashInnerModuleBorderWidth
  border.color: Colors.borderColor
  radius: Config.dashInnerModuleRadius
  
  
  Column {
    anchors.fill: parent
    anchors.margins: 20
    spacing: 12
    
    // Header
    Row {
      spacing: 10
    
      Text {
        text: "control"
        color: Colors.accentColor
        font.pixelSize: 16
        font.bold: true
      }
      
      Text {
        text: "hello"
        color: Colors.accent2Color
        font.pixelSize: 12
        anchors.verticalCenter: parent.verticalCenter
      }
    }
  
    // ===============================================
    // CONTROL BUTTONS
    // ===============================================
    Column {
      spacing: 10
      width: parent.width
      

    }
  }
}
