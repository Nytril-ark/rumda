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
  signal themeChanged()
  readonly property string iconPath: Config.configPath + "/icons"

  // Dimensions
  readonly property int moduleSize: 26
  readonly property int imageSourceSize: 55
  readonly property int maskWidth: 20
  readonly property int maskHeight: 18
  readonly property int maskRadius: 8


  Process {
    id: lightConfigScript
    command: [
      "bash",
      Quickshell.env("HOME") + "/.config/rumda/scripts/light-config.sh"
    ]
  }

  // Layout
  Layout.alignment: Qt.AlignHCenter
  Layout.topMargin: 4
  Layout.bottomMargin: 3
  
  // Appearance
  width: moduleSize
  height: moduleSize
  radius: innerModulesRadius
  color: "transparent"
  clip: true
  

  
  // GitHub icon
  Image {
    id: githubIcon
    anchors.fill: parent
    source: "file://" + root.iconPath + "/themeSwitch.svg"
    sourceSize.width: root.imageSourceSize
    sourceSize.height: root.imageSourceSize
    fillMode: Image.PreserveAspectCrop
    scale: 1.0
    antialiasing: true 
    smooth: true
    mipmap: true
    layer.enabled: true
    layer.effect: OpacityMask {
      maskSource: Rectangle {
        width: root.maskWidth
        height: root.maskHeight
        radius: root.maskRadius
      }
    }
  }
  
  // Click handler
  MouseArea {
    anchors.fill: parent
    cursorShape: Qt.PointingHandCursor

    onClicked: {
      themeChanged()
      lightConfigScript.running = true
    }
  } 
}
