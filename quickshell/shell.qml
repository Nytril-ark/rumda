//@ pragma UseQApplication
//@ pragma Env QS_NO_RELOAD_POPUP=1
//@ pragma Env QT_QUICK_CONTROLS_STYLE=Basic
//@ pragma Env QT_QUICK_FLICKABLE_WHEEL_DECELERATION=10000
    pragma ComponentBehavior: Bound

import QtQuick.Shapes

import Quickshell.Widgets
import Quickshell.Wayland
// Adjust this to make the shell smaller or larger
//@ pragma Env QT_SCALE_FACTOR=1
import QtQuick
import QtQuick.Window
import Quickshell


ShellRoot {
    //======================================================================// 

PanelWindow {
  id: window

  property color barColor: "#151518"

  color: "transparent"
  exclusionMode: ExclusionMode.Ignore
  mask: Region {
    item: cornersArea
    intersection: Intersection.Subtract
  }

  anchors {
    left: true
    top: true
    right: true
    bottom: true
  }

  // Inline Components
  component Corner: WrapperItem {
    id: root

    property int corner
    property real radius: 20
    property color color

    Component.onCompleted: {
      switch (corner) {
      case 0:
        anchors.left = parent.left;
        anchors.top = parent.top;
        break;
      case 1:
        anchors.top = parent.top;
        anchors.right = parent.right;
        rotation = 90;
        break;
      case 2:
        anchors.right = parent.right;
        anchors.bottom = parent.bottom;
        rotation = 180;
        break;
      case 3:
        anchors.left = parent.left;
        anchors.bottom = parent.bottom;
        rotation = -90;
        break;
      }
    }

    Shape {
      preferredRendererType: Shape.CurveRenderer

      ShapePath {
        strokeWidth: 0
        fillColor: root.color
        startX: root.radius

        PathArc {
          relativeX: -root.radius
          relativeY: root.radius
          radiusX: root.radius
          radiusY: radiusX
          direction: PathArc.Counterclockwise
        }

        PathLine {
          relativeX: 0
          relativeY: -root.radius
        }

        PathLine {
          relativeX: root.radius
          relativeY: 0
        }
      }
    }
  }
  component Exclusion: PanelWindow {
    property string name
    implicitWidth: 0
    implicitHeight: 0
    WlrLayershell.namespace: `quickshell:${name}ExclusionZone`
  }

  // Exclusions
  Scope {
    Exclusion {
      name: "left"
      exclusiveZone: leftBar.implicitWidth
      anchors.left: true
    }
    Exclusion {
      name: "top"
      exclusiveZone: topBar.implicitHeight
      anchors.top: true
    }
    Exclusion {
      name: "right"
      exclusiveZone: rightBar.implicitWidth
      anchors.right: true
    }
    Exclusion {
      name: "bottom"
      exclusiveZone: bottomBar.implicitHeight
      anchors.bottom: true
    }
  }

  // Bars
  Rectangle {
    id: leftBar
    implicitWidth: 8
    implicitHeight: QsWindow.window?.height ?? 0
    color: window.barColor
    anchors.left: parent.left
  }
  Rectangle {
    id: topBar
    implicitWidth: QsWindow.window?.width ?? 0
    implicitHeight: 8
    color: window.barColor
    anchors.top: parent.top
  }
  Rectangle {
    id: rightBar
    implicitWidth: 8
    implicitHeight: QsWindow.window?.height ?? 0
    color: window.barColor
    anchors.right: parent.right
  }
  Rectangle {
    id: bottomBar
    implicitWidth: QsWindow.window?.width ?? 0
    implicitHeight: 8
    color: window.barColor
    anchors.bottom: parent.bottom
  }

  Rectangle {
    id: cornersArea
    implicitWidth: QsWindow.window?.width - (leftBar.implicitWidth + rightBar.implicitWidth)
    implicitHeight: QsWindow.window?.height - (topBar.implicitHeight + bottomBar.implicitHeight)
    color: "transparent"
    x: leftBar.implicitWidth
    y: topBar.implicitHeight

    Repeater {
      model: [0, 1, 2, 3]

      Corner {
        required property int modelData
        corner: modelData
        color: window.barColor
      }
    }
  }
}



//==============================================================================//
}

