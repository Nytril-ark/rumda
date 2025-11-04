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
import qs.light.config

Rectangle {
  id: root
  
  property string iconName: "power"
  property int moduleSize: 28
  property int iconSize: 20
  property int moduleRadius: 7
  
  Layout.alignment: Qt.AlignHCenter
  Layout.topMargin: 4
  
  height: moduleSize
  width: moduleSize
  radius: moduleRadius
  color: Colors.moduleBG
  border.width: 1
  border.color: Colors.borderColor
  
  Process {
    id: openDashboard
    command: ["bash", "-c", "echo 'toggle' > /tmp/qs-dashboard.fifo",] 
  }
  
  // Icon
  Image {
    id: icon
    anchors.centerIn: parent
    width: root.iconSize
    height: root.iconSize
    source: `file://${Config.configPath}/light/icons/${root.iconName}.svg`
    fillMode: Image.PreserveAspectFit
    antialiasing: true
    smooth: true
    mipmap: true
    rotation: 0 

    Behavior on rotation {
      NumberAnimation {
        duration: 800
        easing.type: Easing.OutBack
      }
    }
  }
  
  // Click handler
  MouseArea {
    anchors.fill: parent
    cursorShape: Qt.PointingHandCursor
    
    onClicked: {
      openDashboard.running = true
      icon.rotation = icon.rotation + 360
    }
  }
}
