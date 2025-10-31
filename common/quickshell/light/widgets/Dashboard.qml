// Dashboard.qml
import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Pipewire
import Quickshell.Widgets
import Quickshell.Io
import qs.light.config

Scope {
  id: dashboardScope
  property int closeDuration: Config.dashAnimDuration

  Timer {
    id: closeTimer
    interval: dashboardScope.closeDuration
    repeat: false
    onTriggered: {
      dashboard.visible = false
    }
  }

  function closeDashboard() {
    dashboardBGRect.anchors.topMargin = dashboard.height
    dashboardBGRect.anchors.bottomMargin = -dashboard.height
    closeTimer.start()
  }


  WlrLayershell {
    id: dashboard
    anchors { top: true; bottom: true; left: true; right: true}
    layer: WlrLayer.Overlay
    visible: false
    // color: Colors.shadowColor
    color: "transparent"
    keyboardFocus: WlrKeyboardFocus.Exclusive


    onVisibleChanged: {  
      if (visible) {
        dashboardBGRect.anchors.topMargin = Config.dashMarginTop
        dashboardBGRect.anchors.bottomMargin = Config.dashMarginBottom          
      } else {
        dashboardBGRect.anchors.topMargin = dashboard.height  
        dashboardBGRect.anchors.bottomMargin = -dashboard.height  
      }
    }
    
    Process {
      id: commandListener
      command: ["bash", "-c", "rm -f /tmp/qs-dashboard.fifo; mkfifo /tmp/qs-dashboard.fifo; while true; do cat /tmp/qs-dashboard.fifo; done"]
      running: true
      
      stdout: SplitParser {
        onRead: data => {
          if (data.includes("toggle")) {
            if (!dashboard.visible) {
              dashboardBGRect.anchors.topMargin = dashboard.height  
              dashboardBGRect.anchors.bottomMargin = -dashboard.height
              dashboard.visible = !dashboard.visible
            } else {
              dashboardScope.closeDashboard()
            }
          }
        }
      }
    }


    FocusScope {  
      anchors.fill: parent
      focus: true
      Keys.onPressed: event => { 
        if (event.key === Qt.Key_Escape) {
          dashboardScope.closeDashboard()
          event.accepted = true         
        }
      }

      MouseArea {
        anchors.fill: parent 
        onClicked: dashboardScope.closeDashboard()
        
        Rectangle {
          id: dashboardBGRect
          anchors.top: parent.top
          anchors.bottom: parent.bottom 
          anchors.left: parent.left 
          anchors.right: parent.right 

          anchors.rightMargin: Config.dashMarginRight 
          anchors.leftMargin: Config.dashMarginLeft 
          anchors.topMargin: dashboard.height  
          anchors.bottomMargin: -dashboard.height  

          color: Colors.dashBGColor
          radius: Config.dashRadius
          border.width: Config.dashBorderWidth
          border.color: Colors.borderColor
          implicitWidth: Config.dashWidth

          MouseArea {
            anchors.fill: parent
          }

          Behavior on anchors.topMargin {
            NumberAnimation {
              duration: dashboardScope.closeDuration
              // easing.type: Easing.InOutBack
              easing.type: Easing.InOutCubic
            }
          }

          Behavior on anchors.bottomMargin {
            NumberAnimation {
              duration: dashboardScope.closeDuration
              // easing.type: Easing.InOutBack
              easing.type: Easing.InOutCubic
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
            // TopSection {}
            // CenterSection {}
          }
        } // end of dashboardBGRect
      }
    }
  }
}
