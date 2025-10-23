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
  id: root
  
  // Theme colors
  readonly property color backgroundColor: "#E4C198"
  readonly property color indicatorBGColor: "#AF8C65"
  readonly property color borderColor: "#D1AB86"
  readonly property color moduleBG: "#DAB08B"
  readonly property color accentColor: "#6F4732"
  readonly property color accent2Color: "#9F684C"
  readonly property color gradientAccent2Color: "#a87358"
  readonly property color errorColor: "#9A4235"
  readonly property color backgroundTransparent: "#661e1e1e"
  readonly property color shadowColor: "#3A2D26"
  
  // Dimensions
  readonly property int moduleWidth: 28
  readonly property int moduleRadius: 7
  readonly property int moduleBorderWidth: 1
  readonly property int workspaceSpacing: 3
  readonly property int workspaceInnerSpacing: -3
  readonly property int workspaceWidth: 12
  readonly property int workspaceActiveHeight: 34
  readonly property int workspaceInactiveHeight: 19
  readonly property int workspaceShapeWidth: 8
  
  // Layout
  Layout.alignment: Qt.AlignHCenter
  anchors.horizontalCenter: parent.horizontalCenter
  implicitHeight: childrenRect.height + 19
  width: moduleWidth
  radius: moduleRadius
  color: moduleBG
  border.width: moduleBorderWidth
  border.color: borderColor
  
  // Workspace container
  ColumnLayout {
    anchors.centerIn: parent
    spacing: workspaceSpacing
    
    ColumnLayout {
      spacing: workspaceInnerSpacing
      
      Repeater {
        model: Hyprland.workspaces
        
        delegate: Item {
          id: workspaceItem
          required property var modelData
          property bool hovered: false
          
          width: root.workspaceWidth
          Layout.preferredHeight: modelData.active ? root.workspaceActiveHeight : root.workspaceInactiveHeight
          Layout.alignment: Qt.AlignHCenter
          
          // Workspace indicator shape
          Shape {
            id: workspaceShape
            anchors.centerIn: parent
            width: root.workspaceShapeWidth
            height: parent.height
            antialiasing: true
            smooth: true
            layer.enabled: true
            layer.samples: 8
            
            ShapePath {
              fillColor: (workspaceItem.modelData.active || workspaceItem.hovered) 
                         ? root.accent2Color 
                         : root.indicatorBGColor
              strokeColor: "transparent"
              strokeWidth: 0
              
              // Define parallelogram shape with rounded corners
              startX: 1
              startY: 8
              
              // Top edge - slanted up-right
              PathLine { x: 7; y: 2 }
              PathArc { x: 8; y: 3; radiusX: 2; radiusY: 2 }
              
              // Right edge
              PathLine { x: 8; y: workspaceShape.height - 10 }
              PathArc { x: 7; y: workspaceShape.height - 8; radiusX: 2; radiusY: 2 }
              
              // Bottom edge - slanted down-left
              PathLine { x: 1; y: workspaceShape.height - 2 }
              PathArc { x: 0; y: workspaceShape.height - 3; radiusX: 2; radiusY: 2 }
              
              // Left edge
              PathLine { x: 0; y: 10 }
              PathArc { x: 1; y: 8; radiusX: 2; radiusY: 2 }
            }
            
            Behavior on height {
              NumberAnimation {
                duration: 200
                easing.type: Easing.OutQuart
              }
            }
          }
          
          // Interaction area
          MouseArea {
            anchors.fill: parent
            onWheel: wheel => {
              const direction = wheel.angleDelta.y > 0 ? "-1" : "+1"
              Hyprland.dispatch("workspace e" + direction)  // e+1 or e-1 for relative workspace switching
            }
          }
        }
      }
    }
  }
}
