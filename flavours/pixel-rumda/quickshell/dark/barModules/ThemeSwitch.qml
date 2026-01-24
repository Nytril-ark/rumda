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
import qs.dark.config

Rectangle {
  id: themeSwitchButton
  Rectangle {
    id: shadowpowerRect
    anchors.top: themeSwitchButton.top
    anchors.bottom: themeSwitchButton.bottom
    anchors.left: themeSwitchButton.left
    anchors.rightMargin: Config.innerBMSoffsetX
    anchors.bottomMargin: -Config.innerBMSoffsetY
    implicitWidth: themeSwitchButton.implicitWidth + Config.innerBMSoffsetX 
    z: -99
    color: Colors.shadowColorBM
    radius: Config.innerBMSRadius
  }

  Layout.alignment: Qt.AlignHCenter
  // Layout.topMargin: 4
  // Layout.bottomMargin: 2
  color: Colors.moduleBG
  border.width: Config.moduleBorderWidth
  border.color: Colors.shadowColorBM
  width: 30
  height: 30
  radius: Config.innerModulesRadius
  readonly property string iconPath: Config.configPath + "/light/icons"
  readonly property int imageSourceSize: 30
  readonly property int maskWidth: 20
  readonly property int maskHeight: 18
  readonly property int maskRadius: 8 
  
  Process {
    id: darkGlobal
    command: [
      "bash",
      "-c",
      "(nohup " + Quickshell.env("HOME") + "/.config/rumda/scripts/pixeltheme_nokill.sh light > /dev/null 2>&1 &) &"
    ]
  }
  
  Image {
    id: themeSwitchIcon
    anchors.fill: parent
    source: "file://" + themeSwitchButton.iconPath + "/themeSwitch.svg"
    sourceSize.width: themeSwitchButton.imageSourceSize
    sourceSize.height: themeSwitchButton.imageSourceSize
    fillMode: Image.PreserveAspectCrop
    scale: 0.75
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
      darkGlobal.running = true
    }
  } 
}
