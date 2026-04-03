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
    // exclusiveZone: -1
    visible: false
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

        DropShadow {
          anchors.fill: dashboardBGRect
          horizontalOffset: Config.dashShadowOffsetX
          verticalOffset: Config.dashShadowOffsetY
          radius: 5
          samples: 29
          spread: 0.73
          transparentBorder: true
          color: Config.enableDashShadow ? Colors.shadowColor : "transparent"
          source: dashboardBGRect
        }

        Rectangle {
          id: dashboardBGRect
          width: dashboardScope.dashWidth
          height: dashboardScope.dashHeight
          anchors.horizontalCenter: parent.horizontalCenter
          y: 0
          visible: false

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
              anchors.fill: parent
              anchors.margins: Config.dashInnerPadding
              spacing: Config.dashInnerPadding

              RowLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.preferredHeight: parent.height * Config.dashTopRowRatio
                spacing: Config.dashInnerPadding

                ProfileAndPower {
                  Layout.fillHeight: true
                  Layout.fillWidth: true
                }

                DashBoardControls {
                  Layout.fillHeight: true
                  Layout.fillWidth: true
                }

                DashBrightnessControl {
                  Layout.fillHeight: true
                  Layout.minimumWidth: 65
                  Layout.maximumWidth: 80
                }
              }

              ContribGraph {
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.preferredHeight: parent.height * (1.0 - Config.dashTopRowRatio)
              }
            }
          }
        }
      }
    }
  }
}
