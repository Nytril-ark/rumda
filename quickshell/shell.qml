//@ pragma UseQApplication
//@ pragma Env QS_NO_RELOAD_POPUP=1
//@ pragma Env QT_QUICK_CONTROLS_STYLE=Basic
//@ pragma Env QT_QUICK_FLICKABLE_WHEEL_DECELERATION=10000
    pragma ComponentBehavior: Bound

import QtQuick.Shapes
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import Qt5Compat.GraphicalEffects
import Quickshell.Widgets
import Quickshell.Wayland
import QtQuick.Window
import Quickshell.Services.UPower
import Quickshell.Services.SystemTray
import Quickshell.Services.Pipewire
import Quickshell.Services.Mpris
import 'bar' as Bar

// Adjust this to make the shell smaller or larger
//@ pragma Env QT_SCALE_FACTOR=1


ShellRoot {
  // Color palette
  property color backgroundColor: "#E4C198" //bar color
  property color surfaceColor: "#AF8C65"
  property color borderColor: "#D1AB86"
  property color accentColor: "#AD704A"
  property color accentLightColor: "#F6CD96"
  property color errorColor: "#9A4235"
  property color backgroundTransparent: "#661e1e1e"
  property color shadowColor: "#3A2D26"



// sitting cat :)
  WlrLayershell {
      id: catsit
      margins { top: 23; left: -50;}
      anchors { top: true; left: true }
      
      layer: WlrLayer.Overlay
      implicitWidth: 50
      color: "transparent"
      
      Rectangle {
        width: 50
        height: 90
        color: "transparent"
        clip: true
        
        Image {
          anchors.fill: parent
          source: "file:///home/hexogen/.config/rumda/quickshell/icons/catsit.svg"  // Hardcoded path
          fillMode: Image.PreserveAspectFit
            antialiasing: true  // Smooths edges
            smooth: true        // Enables smooth filtering
            mipmap: true        // Optional: improves quality at different scales
        }
      }
    }
// SHADOW FOR THE SITTING CAT ========================
// Shadow layer 1 (outermost, most transparent)
WlrLayershell {
    id: catsitShadow1
    margins { top: 28; left: -48;}
    anchors { top: true; left: true }
    
    layer: WlrLayer.Overlay
    implicitWidth: 50
    color: "transparent"
    
    Rectangle {
      width: 50
      height: 90
      color: "transparent"
      clip: true
      
      Image {
        anchors.fill: parent
        source: "file:///home/hexogen/.config/rumda/quickshell/icons/catsit.svg"
        fillMode: Image.PreserveAspectFit
        antialiasing: true
        smooth: true
        mipmap: true
        opacity: 0.1
      }
    }
}

// Shadow layer 2
WlrLayershell {
    id: catsitShadow2
    margins { top: 26; left: -48;}
    anchors { top: true; left: true }
    
    layer: WlrLayer.Overlay
    implicitWidth: 50
    color: "transparent"
    
    Rectangle {
      width: 50
      height: 90
      color: "transparent"
      clip: true
      
      Image {
        anchors.fill: parent
        source: "file:///home/hexogen/.config/rumda/quickshell/icons/catsit.svg"
        fillMode: Image.PreserveAspectFit
        antialiasing: true
        smooth: true
        mipmap: true
        opacity: 0.15
      }
    }
}

// Shadow layer 3 (main shadow)
WlrLayershell {
    id: catsitShadow3
    margins { top: 25; left: -48;}
    anchors { top: true; left: true }
    
    layer: WlrLayer.Overlay
    implicitWidth: 50
    color: "transparent"
    
    Rectangle {
      width: 50
      height: 90
      color: "transparent"
      clip: true
      
      Image {
        anchors.fill: parent
        source: "file:///home/hexogen/.config/rumda/quickshell/icons/catsit.svg"
        fillMode: Image.PreserveAspectFit
        antialiasing: true
        smooth: true
        mipmap: true
        opacity: 0.2
      }
    }
}
// END OF CAT SHADOW=========================================

// BAR SHADOW
  WlrLayershell {
      id: barShadow
      margins { 
          top: 79
          left: -38
      }
      anchors { top: true; left: true }
      layer: WlrLayer.Bottom
      width: bar.width + 2  // Slightly wider for blur effect
      height: bar.height + 2
      color: "transparent" 
      // Outer blur layer (most transparent)
      Rectangle {
          anchors.centerIn: parent
          width: parent.width
          height: parent.height
          color: shadowColor
          opacity: 0.3
          radius: 8
      }
      
      // Middle blur layer
      Rectangle {
          anchors.centerIn: parent
          width: parent.width - 2
          height: parent.height - 2
          color: shadowColor
          opacity: 0.33
          radius: 8
      }
      
      // Inner shadow (darkest)
      Rectangle {
          anchors.centerIn: parent
          width: parent.width - 4
          height: parent.height - 4
          color: shadowColor
          opacity: 0.4
          radius: 8
      }
    }


//shell.qml from xfcasio/amadeus (for the bar's skeleton)
  Scope {
    id: root

    MouseArea {
      anchors.fill: parent
      onWheel: wheel => {
        Hyprland.dispatch("workspace 1")
        Mpris.players.values.forEach((player, idx) => player.pause())
      }
    }

    Bar.PopoutVolume {}

    WlrLayershell {
      id: bar
      margins { top: 80; bottom: 60; left: 19; right: -7}
      anchors { top: true; bottom: true; left: true }
      
      layer: WlrLayer.Top

      implicitWidth: 50
      color: "transparent"

      MouseArea {
        anchors.fill: parent
        onWheel: wheel => {
          Hyprland.dispatch("workspace 1")
          Mpris.players.values.forEach((player, idx) => player.pause())
        }
      }

      // The actual bar - Extra rect to achieve bar-rounding
      Rectangle {
        anchors.fill: parent
        color: backgroundColor
        radius: 8
        border.width: 2
        border.color: borderColor

        Behavior on height {
          NumberAnimation {
            duration: 1000
            easing.type: Easing.InOutQuart
          }
        }

        ColumnLayout {
          anchors { fill: parent; topMargin: 3; bottomMargin: 10; leftMargin: 3; rightMargin: 3 }
          spacing: 4

          TopSection {}
          CenterSection {}
          BottomSection {}
        }
      }
    }
  }


  //==============================================
  //border=====================
  //==============================================
  // PanelWindow {
  //   id: window
  //
  //   property color barColor: "#151518"
  //
  //   color: "transparent"
  //   exclusionMode: ExclusionMode.Ignore
  //   mask: Region {
  //     item: cornersArea
  //     intersection: Intersection.Subtract
  //   }
  //
  //   anchors {
  //     left: true
  //     top: true
  //     right: true
  //     bottom: true
  //   }
  //
  //   // Inline Components
  //   component Corner: WrapperItem {
  //     id: root
  //
  //     property int corner
  //     property real radius: 20
  //     property color color
  //
  //     Component.onCompleted: {
  //       switch (corner) {
  //       case 0:
  //         anchors.left = parent.left;
  //         anchors.top = parent.top;
  //         break;
  //       case 1:
  //         anchors.top = parent.top;
  //         anchors.right = parent.right;
  //         rotation = 90;
  //         break;
  //       case 2:
  //         anchors.right = parent.right;
  //         anchors.bottom = parent.bottom;
  //         rotation = 180;
  //         break;
  //       case 3:
  //         anchors.left = parent.left;
  //         anchors.bottom = parent.bottom;
  //         rotation = -90;
  //         break;
  //       }
  //     }
  //
  //     Shape {
  //       preferredRendererType: Shape.CurveRenderer
  //
  //       ShapePath {
  //         strokeWidth: 0
  //         fillColor: backgroundColor
  //         startX: root.radius
  //
  //         PathArc {
  //           relativeX: -root.radius
  //           relativeY: root.radius
  //           radiusX: root.radius
  //           radiusY: radiusX
  //           direction: PathArc.Counterclockwise
  //         }
  //
  //         PathLine {
  //           relativeX: 0
  //           relativeY: -root.radius
  //         }
  //
  //         PathLine {
  //           relativeX: root.radius
  //           relativeY: 0
  //         }
  //       }
  //     }
  //   }
  //   component Exclusion: PanelWindow {
  //     property string name
  //     implicitWidth: 0
  //     implicitHeight: 0
  //     WlrLayershell.namespace: `quickshell:${name}ExclusionZone`
  //   }
  //
  //   // Exclusions
  //   Scope {
  //     Exclusion {
  //       name: "left"
  //       exclusiveZone: leftBar.implicitWidth
  //       anchors.left: true
  //     }
  //     Exclusion {
  //       name: "top"
  //       exclusiveZone: topBar.implicitHeight
  //       anchors.top: true
  //     }
  //     Exclusion {
  //       name: "right"
  //       exclusiveZone: rightBar.implicitWidth
  //       anchors.right: true
  //     }
  //     Exclusion {
  //       name: "bottom"
  //       exclusiveZone: bottomBar.implicitHeight
  //       anchors.bottom: true
  //     }
  //   }
  //
  //   // Bars
  //   Rectangle {
  //     id: leftBar
  //     implicitWidth: 8
  //     implicitHeight: QsWindow.window?.height ?? 0
  //     color: backgroundColor
  //     anchors.left: parent.left
  //   }
  //   Rectangle {
  //     id: topBar
  //     implicitWidth: QsWindow.window?.width ?? 0
  //     implicitHeight: 8
  //     color: backgroundColor
  //     anchors.top: parent.top
  //   }
  //   Rectangle {
  //     id: rightBar
  //     implicitWidth: 8
  //     implicitHeight: QsWindow.window?.height ?? 0
  //     color: backgroundColor
  //     anchors.right: parent.right
  //   }
  //   Rectangle {
  //     id: bottomBar
  //     implicitWidth: QsWindow.window?.width ?? 0
  //     implicitHeight: 8
  //     color: backgroundColor
  //     anchors.bottom: parent.bottom
  //   }
  //
  //   Rectangle {
  //     id: cornersArea
  //     implicitWidth: QsWindow.window?.width - (leftBar.implicitWidth + rightBar.implicitWidth)
  //     implicitHeight: QsWindow.window?.height - (topBar.implicitHeight + bottomBar.implicitHeight)
  //     color: "transparent"
  //     x: leftBar.implicitWidth
  //     y: topBar.implicitHeight
  //
  //     Repeater {
  //       model: [0, 1, 2, 3]
  //
  //       Corner {
  //         required property int modelData
  //         corner: modelData
  //         color: window.barColor
  //       }
  //     }
  //   }
  // }
    //==============================================
   //BAR=====================
  //==============================================
}

