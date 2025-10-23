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
  Layout.preferredHeight: childrenRect.height + 10
  visible: SystemTray.items.values.length
  width: 28
  radius: 7
  color: moduleBG

  border.width: 1
  border.color: borderColor


  ColumnLayout {
    anchors.centerIn: parent
    spacing: 3

    Repeater {
      model: SystemTray.items

      Rectangle {
        required property var modelData
        Layout.alignment: Qt.AlignHCenter
        height: 18
        width: 18
        color: "transparent"

        Image {
          anchors.centerIn: parent
          width: 17
          height: 17
          source: modelData.icon
        }

        MouseArea {
          anchors.fill: parent
          onClicked: {
            if (modelData.hasMenu) QsMenuAnchor.open(modelData.menu)
          }
        }
      }
    }
  }
}
