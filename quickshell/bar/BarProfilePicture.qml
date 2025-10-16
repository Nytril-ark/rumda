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
  Layout.alignment: Qt.AlignHCenter
  Layout.topMargin: 4//2
  Layout.bottomMargin: 2//2
  width: 26//32
  height: 26//32
  radius: innerModulesRadius
  color: "transparent"
  clip: true
  //color: "#111A1F"

  Image {
    anchors.fill: parent
    source: `file:///home/${username}/.config/rumda/quickshell/icons/github.svg`
    sourceSize.width: 55
    sourceSize.height: 55
    fillMode: Image.PreserveAspectCrop
    scale: 1.0

    layer.enabled: true
    layer.effect: OpacityMask {
      maskSource: Rectangle {
        width: 20
        height: 18
        radius: 8
      }
    }
  }

//  Rectangle {
//    anchors.centerIn: parent
//    radius: 8
//    width: 26
//    height: 24
//    clip: true
//    color: "transparent"
//
//  }
}
