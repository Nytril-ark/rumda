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
  
  // User Configuration
  readonly property string username: Quickshell.env("USER") || "user"
  readonly property string configPath: Quickshell.env("HOME") + "/.config/rumda/quickshell"
  readonly property string iconPath: configPath + "/icons"
  readonly property bool useFirefox: true  // Set to true to use Firefox instead of xdg-open
  
  // Link Configuration
  readonly property string githubUrl: "https://github.com/Nytril-ark/rumda"
  
  // Dimensions
  readonly property int moduleSize: 26
  readonly property int imageSourceSize: 55
  readonly property int maskWidth: 20
  readonly property int maskHeight: 18
  readonly property int maskRadius: 8
  
  // Layout
  Layout.alignment: Qt.AlignHCenter
  Layout.topMargin: 4
  Layout.bottomMargin: 2
  
  // Appearance
  width: moduleSize
  height: moduleSize
  radius: innerModulesRadius
  color: "transparent"
  clip: true
  
  // Process for opening URLs
  Process {
    id: urlOpener
    command: root.useFirefox ? ["firefox", root.githubUrl] : ["xdg-open", root.githubUrl]
  }
  
  // GitHub icon
  Image {
    id: githubIcon
    anchors.fill: parent
    source: "file://" + root.iconPath + "/github.svg"
    sourceSize.width: root.imageSourceSize
    sourceSize.height: root.imageSourceSize
    fillMode: Image.PreserveAspectCrop
    scale: 1.0
    
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
      urlOpener.running = true
    }
  }
}
