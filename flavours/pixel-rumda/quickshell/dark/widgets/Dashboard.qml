// Dashboard.qml
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
import qs.dark.config
import qs.dark.widgets

Scope {
  id: dashboardScope
  property int closeDuration: Config.dashAnimDuration
  property int dashboardVerticalGap: dashboard.implicitHeight * (1 / Config.dashboardHeight)
  property int dashMargin: Config.dashMargin
  property int dashTopMargin: Config.dashTopMargin

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
        dashboardBGRect.anchors.topMargin = dashboardVerticalGap + dashTopMargin
        dashboardBGRect.anchors.bottomMargin = dashboardVerticalGap - ((2 * (dashboard.height / Config.dashboardHeight)) + dashTopMargin)
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
              dashboardBGRect.anchors.topMargin = dashboardVerticalGap + dashTopMargin
              dashboardBGRect.anchors.bottomMargin = dashboardVerticalGap - ((2 * (dashboard.height / Config.dashboardHeight)) + dashTopMargin)
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
            id: shadowRect
            anchors.top: dashboardBGRect.top
            anchors.bottom: dashboardBGRect.bottom
            anchors.left: dashboardBGRect.left
            anchors.bottomMargin: -Config.dashShadowOffsetY
            implicitWidth: dashboardBGRect.width + Config.dashShadowOffsetX
            color: Colors.outermostDSShadow
            radius: Config.dashRadius
            Behavior on anchors.topMargin {
                NumberAnimation {
                    duration: dashboardScope.closeDuration
                    easing.type: Easing.InOutCubic
                }
            }
            Behavior on anchors.bottomMargin {
                NumberAnimation {
                    duration: dashboardScope.closeDuration
                    easing.type: Easing.InOutCubic
                }
            }
        }



        Rectangle {
          id: dashboardBGRect
          anchors.top: parent.top
          anchors.bottom: parent.bottom 
          anchors.left: parent.left 
          anchors.right: parent.right
          border.width: Config.outermostDSBorderWidth
          border.color: Colors.outermostDSShadow
          anchors.rightMargin: Config.dashboardOnRight ? dashMargin : ((2 * (dashboard.width / Config.dashboardWidth)) - dashMargin)
          anchors.leftMargin: Config.dashboardOnRight ? ((2 * (dashboard.width / Config.dashboardWidth)) - dashMargin) : dashMargin
          // anchors.topMargin: dashboard.height / Config.dashboardHeight
          // anchors.bottomMargin: dashboard.height / Config.dashboardHeight
          anchors.topMargin: Config.dashboardOnTop ? dashTopMargin : ((2 * (dashboard.height / Config.dashboardHeight)) - dashTopMargin)
          anchors.bottomMargin: Config.dashboardOnTop ? ((2 * (dashboard.height / Config.dashboardHeight)) - dashTopMargin) : dashTopMargin

          color: Colors.dashBGColor
          radius: Config.dashRadius

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


          Rectangle {
            id: dashInnerWrapper
            anchors.fill: parent
            anchors.leftMargin: Config.dashInnerPadding
            anchors.rightMargin: Config.dashInnerPadding 
            anchors.topMargin: Config.dashInnerPadding
            anchors.bottomMargin: Config.dashInnerPadding

            anchors.centerIn: parent
            radius: Config.dashRadius
            color: Colors.dashBGColor
            border.width: Config.dashBorderWidth
            border.color: Colors.dashBorderColor
            GridLayout {
              id: dashInnerGrid
              columns: 3
              rows: 2   
              anchors.fill: parent

              anchors.leftMargin: Config.dashInnerModuleShadowVisible? (Config.dashInnerPadding - 2) : Config.dashInnerPadding
              anchors.topMargin: Config.dashInnerModuleShadowVisible? (Config.dashInnerPadding - 2) : Config.dashInnerPadding
              anchors.rightMargin: Config.dashInnerPadding 
              anchors.bottomMargin: Config.dashInnerPadding

              columnSpacing: Config.dashInnerPadding
              rowSpacing: Config.dashInnerPadding

              ProfileAndPower {
                Layout.row: 0
                Layout.column: 0
                Layout.fillHeight: true
                Layout.minimumHeight: Config.profileAndControlsMinHeight
                Layout.minimumWidth: Config.profileAndControlsMinWidth
              }

              DashBoardControls {
                Layout.row: 0
                Layout.column: 1
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.minimumHeight: Config.profileAndControlsMinHeight
              }


              DashBrightnessControl {
                Layout.row: 0     
                Layout.column: 2
                Layout.fillHeight: true     
                Layout.minimumHeight: Config.profileAndControlsMinHeight
                Layout.minimumWidth: 65
              }



              ContribGraph {
                Layout.row: 1
                Layout.column: 0
                Layout.columnSpan: 3
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.minimumHeight: Config.contribGraphMinHeight
              }

            } // end of gridLayout
          }


        } // end of dashboardBGRect
      }
    }
  }
}
