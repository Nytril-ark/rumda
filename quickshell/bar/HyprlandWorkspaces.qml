import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Shapes
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
  property color gradientAccent2Color: "#a87358" //bottom / right of volume bar
  property color errorColor: "#9A4235"
  property color backgroundTransparent: "#661e1e1e"
  property color shadowColor: "#3A2D26"
  Layout.alignment: Qt.AlignHCenter
  anchors.horizontalCenter: parent.horizontalCenter
  implicitHeight: childrenRect.height + 19
  width: 28
  radius: 7
  color: moduleBG
  border.width: 1
  border.color: borderColor
  
  ColumnLayout {
    anchors.centerIn: parent
    spacing: 3
    
    ColumnLayout {
      spacing: -3
      
      Repeater {
        model: Hyprland.workspaces
        Item {
          required property var modelData
          property bool hovered: false
          width: 12
          Layout.preferredHeight: modelData.active ? 34 : 19
          Layout.alignment: Qt.AlignHCenter
          
          Shape {
            anchors.centerIn: parent
            width: 8
            height: parent.height
            antialiasing: true
            smooth: true
            layer.enabled: true
            layer.samples: 8
            
            ShapePath {
              fillColor: (modelData.active || parent.parent.hovered) ? accent2Color : indicatorBGColor
              strokeColor: "transparent"
              strokeWidth: 0
              startX: 1
              startY: 8

              PathLine { x: 7; y: 2 }  // Top edge - slanted up-right
              PathArc { x: 8; y: 3; radiusX: 2; radiusY: 2 }  // Top-right corner
              PathLine { x: 8; y: height - 10 }  // Right edge
              PathArc { x: 7; y: height - 8; radiusX: 2; radiusY: 2 }  // Bottom-right corner
              PathLine { x: 1; y: height - 2 }  // Bottom edge - slanted down-left
              PathArc { x: 0; y: height - 3; radiusX: 2; radiusY: 2 }  // Bottom-left corner
              PathLine { x: 0; y: 10 }  // Left edge
              PathArc { x: 1; y: 8; radiusX: 2; radiusY: 2 }  // Top-left corner back to start
            }
          }
          
          MouseArea {
            anchors.fill: parent
            onClicked: Hyprland.dispatch(`workspace ${modelData.id.toString()}`)
            hoverEnabled: true
            onEntered: { parent.hovered = true }
            onExited: { parent.hovered = false }
          }
        }
      } // Close Repeater
    } // Close inner ColumnLayout
  } // Close outer ColumnLayout
} // Close main Rectangle
