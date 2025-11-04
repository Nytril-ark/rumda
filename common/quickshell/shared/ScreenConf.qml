pragma Singleton

import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import QtQuick
import QtQuick.Window

Singleton {
  required property var screen
  readonly property int screenHeight: Screen.height
  readonly property int screenWidth: 1920
}

