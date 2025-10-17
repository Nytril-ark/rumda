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
  property color backgroundColor: "#E4C198" //bar color
  property color indicatorBGColor: "#AF8C65"
  property color borderColor: "#D1AB86"
  property color moduleBG: "#DAB08B"
  property color accentColor: "#6F4732"
  property color accent2Color: "#9F684C"
  property color errorColor: "#9A4235"
  property color backgroundTransparent: "#661e1e1e"
  property color shadowColor: "#3A2D26"
  Layout.alignment: Qt.AlignHCenter
  Layout.topMargin: 4
  height: 28
  width: 28
  radius: 7
  color: moduleBG

  border.width: 1
  border.color: borderColor

  Image {
    anchors.centerIn: parent
    width: 20
    height: 20
    source: `file:///home/${usr}/.config/rumda/quickshell/icons/power.svg`
    fillMode: Image.PreserveAspectFit
    antialiasing: true
    smooth: true
    mipmap: true
  }
}
