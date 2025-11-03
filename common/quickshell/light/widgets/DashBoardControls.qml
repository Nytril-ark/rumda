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
  id: brightnessRect
  readonly property int buttonSizes: 51
  readonly property int buttonSpacing: 7
  readonly property int buttonBorderWidth: 0
  readonly property int buttonsGapFromBottom: 15
  readonly property int iconSizes: 27
  readonly property int buttonFloatAmount: 6

  
  color: Colors.dashModulesColor
  border.width: Config.dashInnerModuleBorderWidth
  border.color: Colors.borderColor
  radius: Config.dashInnerModuleRadius








// contains header for controls + the controls
  ColumnLayout {
    anchors.fill: parent
    anchors.margins: 20 
    spacing: 12           
    // Header
    Row {
      spacing: 10
      Layout.fillWidth: true
    
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


  // ==========================
  // NOTE TO SELF: in GridLayout, things are 0-indexed.
    GridLayout {
      Layout.fillWidth: true
      Layout.fillHeight: true
      columns: 9  
      rows: 5     
      columnSpacing: 10
      rowSpacing: 10
      
      Item {
        Layout.row: 0
        Layout.column: 0
        Layout.rowSpan: 4     
        Layout.columnSpan: 8  
        Layout.fillWidth: true
        Layout.fillHeight: true
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -20

        DashControlExtras {
          id: dashControlExtras
          anchors.fill: parent
        }
      }

      Item {
        Layout.row: 4     
        Layout.column: 0        
        Layout.columnSpan: 8
        Layout.rowSpan: 1
        Layout.fillWidth: true

        Item {
          anchors.centerIn: parent
          width: dashPlayButtonsCol.width
          height: dashPlayButtonsCol.height
          
          DashPlayButtons {
            id: dashPlayButtonsCol
          }
        }
      }

    } // end of grid layout
  } // end of columnLayout

}
