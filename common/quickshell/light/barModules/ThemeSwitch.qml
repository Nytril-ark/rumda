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
  id: themeSwitchButton

  readonly property string iconPath: Config.configPath + "/light/icons"
  
  readonly property int moduleSize: 26
  readonly property int imageSourceSize: 55
  readonly property int maskWidth: 20
  readonly property int maskHeight: 18
  readonly property int maskRadius: 8 
  
  Process {
    id: darkConfigScript
    command: [
      "bash",
      "-c",
      Quickshell.env("HOME") + "/.config/rumda/scripts/wall.sh dark"
    ]
  }

  Process {
    id: darkAlacritty
    command: [
      "bash",
      "-c",
      Quickshell.env("HOME") + "/.config/rumda/scripts/hyprtheme.sh dark"
    ]
  }


  Layout.alignment: Qt.AlignHCenter
  Layout.topMargin: 4
  Layout.bottomMargin: 2
  
  width: moduleSize
  height: moduleSize
  radius: innerModulesRadius
  color: "transparent"
  clip: true
  
  Image {
    id: githubIcon
    anchors.fill: parent
    source: "file://" + themeSwitchButton.iconPath + "/themeSwitch.svg"
    sourceSize.width: themeSwitchButton.imageSourceSize
    sourceSize.height: themeSwitchButton.imageSourceSize
    fillMode: Image.PreserveAspectCrop
    scale: 1.0
    antialiasing: true 
    smooth: true
    mipmap: true
    layer.enabled: true
    layer.effect: OpacityMask {
      maskSource: Rectangle {
        width: themeSwitchButton.maskWidth
        height: themeSwitchButton.maskHeight
        radius: themeSwitchButton.maskRadius
      }
    }
  }
  
  signal themeChanged()
  MouseArea {
    anchors.fill: parent
    cursorShape: Qt.PointingHandCursor
    onClicked: {
      themeChanged()
      darkConfigScript.running = true
      darkAlacritty.running = true
    }
  } 
}
