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
  readonly property int dashWidth: Config.dashboardWidth
  readonly property int dashHeight: Config.dashboardHeight

  Timer {
    id: closeTimer
    interval: dashboardScope.closeDuration
    repeat: false
    onTriggered: {
      dashboard.visible = false;
      dashboardBGRect.visible = false;
      dashboardBGRect.animating = false;
    }
  }

  function openDashboard() {
    dashboardBGRect.animating = false;
    dashboardBGRect.y = dashboard.screenH;
    dashboardBGRect.visible = true;
    dashboard.visible = true;
    Qt.callLater(() => {
      dashboardBGRect.animating = true;
      dashboardBGRect.y = (dashboard.screenH - dashboardScope.dashHeight) * 0.5;
    });
  }

  function closeDashboard() {
    dashboardBGRect.animating = true;
    dashboardBGRect.y = dashboard.screenH;
    closeTimer.start();
  }

  WlrLayershell {
    id: dashboard
    readonly property int screenW: Screen.width
    readonly property int screenH: Screen.height
    anchors {
      top: true
      bottom: true
      left: true
      right: true
    }
    layer: WlrLayer.Overlay
    visible: false
    // color: Colors.shadowColor
    color: "transparent"
    keyboardFocus: WlrKeyboardFocus.Exclusive

    Process {
      id: commandListener
      command: ["bash", "-c", "rm -f /tmp/qs-dashboard.fifo; mkfifo /tmp/qs-dashboard.fifo; while true; do cat /tmp/qs-dashboard.fifo; done"]
      running: true
      stdout: SplitParser {
        onRead: data => {
          if (data.includes("toggle")) {
            if (!dashboard.visible) {
              dashboardScope.openDashboard();
            } else {
              dashboardScope.closeDashboard();
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
          dashboardScope.closeDashboard();
          event.accepted = true;
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
          width: dashboardScope.dashWidth
          height: dashboardScope.dashHeight
          anchors.horizontalCenter: parent.horizontalCenter
          y: 0
          visible: false
          border.width: Config.outermostDSBorderWidth
          border.color: Colors.outermostDSShadow
          color: Colors.dashBGColor
          radius: Config.dashRadius

          MouseArea {
            anchors.fill: parent
          }

          property bool animating: false

          Behavior on y {
            enabled: dashboardBGRect.animating
            NumberAnimation {
              duration: dashboardScope.closeDuration
              easing.type: Easing.InOutCubic
            }
          }

          Rectangle {
            id: dashInnerWrapper
            anchors.fill: parent
            anchors.margins: Config.dashInnerPadding
            radius: Config.dashRadius
            color: Colors.dashBGColor
            border.width: Config.dashBorderWidth
            border.color: Colors.dashBorderColor

            ColumnLayout {
              id: dashColumnLayout
              anchors.fill: parent
              anchors.margins: Config.dashInnerPadding
              spacing: Config.dashInnerPadding

              RowLayout {
                id: topRow
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.preferredHeight: (dashInnerWrapper.height - Config.dashInnerPadding * 4) * Config.dashTopRowRatio
                spacing: Config.dashInnerPadding

                ProfileAndPower {
                  Layout.fillHeight: true
                  Layout.preferredWidth: topRow.width * Config.dashProfileColRatio
                }
                DashBoardControls {
                  Layout.fillHeight: true
                  Layout.fillWidth: true
                }
                DashBrightnessControl {
                  Layout.fillHeight: true
                  Layout.minimumWidth: 58
                  Layout.maximumWidth: 80
                }
              }

              ContribGraph {
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.preferredHeight: (dashInnerWrapper.height - Config.dashInnerPadding * 4) * (1.0 - Config.dashTopRowRatio)
              }
            }
          }
        } // end of dashboardBGRect
      }
    }
  }
}
