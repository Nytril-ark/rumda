import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Services.UPower
import Quickshell.Services.SystemTray
import Quickshell.Services.Pipewire
import Quickshell.Services.Mpris
import Qt5Compat.GraphicalEffects
import qs.light.barModules

Rectangle {
  Layout.fillHeight: true
  Layout.fillWidth: true
  color: "transparent"

  ColumnLayout {
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.verticalCenter: parent.verticalCenter
    Layout.fillHeight: true
    Layout.fillWidth: true
    spacing: 6
    y: (bar.height - height) / 12

    Workspaces {}
  }
}
