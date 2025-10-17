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

Rectangle {
  id: root
  
  // Theme colors
  readonly property color backgroundColor: "#E4C198"
  readonly property color indicatorBGColor: "#AF8C65"
  readonly property color borderColor: "#D1AB86"
  readonly property color moduleBG: "#DAB08B"
  readonly property color accentColor: "#6F4732"
  readonly property color accent2Color: "#9F684C"
  readonly property color errorColor: "#9A4235"
  readonly property color backgroundTransparent: "#661e1e1e"
  readonly property color shadowColor: "#3A2D26"
  
  // Paths
  readonly property string username: Quickshell.env("USER") || "user"
  readonly property string configPath: Quickshell.env("HOME") + "/.config/rumda/quickshell"
  readonly property string iconPath: `${configPath}/icons`
  
  // Module properties
  property string iconName: "power"
  property int moduleSize: 28
  property int iconSize: 20
  property int moduleRadius: 7
  
  // Layout
  Layout.alignment: Qt.AlignHCenter
  Layout.topMargin: 4
  
  // Appearance
  height: moduleSize
  width: moduleSize
  radius: moduleRadius
  color: moduleBG
  border.width: 1
  border.color: borderColor
  
  // Icon
  Image {
    id: icon
    anchors.centerIn: parent
    width: root.iconSize
    height: root.iconSize
    source: `file://${root.iconPath}/${root.iconName}.svg`
    fillMode: Image.PreserveAspectFit
    antialiasing: true
    smooth: true
    mipmap: true
  }
}
