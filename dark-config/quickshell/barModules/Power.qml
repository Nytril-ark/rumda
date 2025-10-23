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
import qs.config

Rectangle {
  id: root
  
  readonly property string iconPath: `${Config.configPath}/icons`
  
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
  color: Colors.moduleBG
  border.width: 1
  border.color: Colors.borderColor
  
  // Process for opening ghostty terminal with shutdown command
  Process {
    id: shutdownTerminal
    command: ["ghostty"/*, "-e", "",*/] // (if you want a shutdown command, you add it between those quotation marks.)
  }
  
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
  
  // Click handler
  MouseArea {
    anchors.fill: parent
    cursorShape: Qt.PointingHandCursor
    
    onClicked: {
      shutdownTerminal.running = true
    }
  }
}
