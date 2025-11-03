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
  readonly property int buttonSizes: 51
  readonly property int buttonSpacing: 7
  readonly property int buttonBorderWidth: 0
  readonly property int pfpRadius: 100
  readonly property int pfpSize: 160
  readonly property int buttonsGapFromBottom: 15
  readonly property int iconSizes: 27
  readonly property int buttonFloatAmount: 6
  property bool useDdcutil: false
  property bool brightnessChecked: false
  
  id: dashBoardControls
  color: Colors.dashModulesColor
  border.width: Config.dashInnerModuleBorderWidth
  border.color: Colors.borderColor
  radius: Config.dashInnerModuleRadius

  Component.onCompleted: {
    brightnessDetector.running = true
  }

  // ==========================================
  // Detect which brightness control to use
  Process {
    id: brightnessDetector
    command: ["sh", "-c", "brightnessctl -c backlight info 2>/dev/null"]
    running: false
    
    stdout: SplitParser {
      onRead: data => {
        if (data.trim().length > 0) {
          useDdcutil = false
          console.log("Using brightnessctl for backlight")
        }
        brightnessChecked = true
      }
    }
    
    onExited: code => {
      if (code !== 0) {
        useDdcutil = true
        console.log("Using ddcutil for external monitor")
        brightnessChecked = true
      }
    }
  }




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
        
        // placeholder for other buttons
      }

      Item {
        Layout.row: 0     
        Layout.column: 8        
        Layout.columnSpan: 1
        Layout.rowSpan: 5
        Layout.fillHeight: true     
        Item {
          anchors.centerIn: parent
          width: dashBrightnessButtons.width
          height: dashBrightnessButtons.height
          
          DashBrightnessControl {
            id: dashBrightnessButtons
          }
        }
      }


      Item {
        Layout.row: 4     
        Layout.column: 0        
        Layout.columnSpan: 9    
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
