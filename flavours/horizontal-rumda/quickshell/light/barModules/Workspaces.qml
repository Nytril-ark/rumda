import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import Qt5Compat.GraphicalEffects
import qs.light.config

Rectangle {
  id: root
  Rectangle {
    id: shadowpowerRect
    anchors.top: root.top
    anchors.bottom: root.bottom
    anchors.left: root.left
    anchors.rightMargin: Config.innerBMSoffsetX - 2
    anchors.bottomMargin: -Config.innerBMSoffsetY
    implicitWidth: root.implicitWidth + Config.innerBMSoffsetX - 2
    z: -99
    color: Colors.shadowColorBM
    radius: Config.innerBMSRadius
  }
  readonly property int moduleWidth: 28
  readonly property int moduleBorderWidth: 1
  readonly property int workspaceSpacing: 4
  readonly property int workspaceInnerSpacing: 5
  readonly property int workspaceWidth: 5
  readonly property int workspaceActiveHeight: 25
  readonly property int workspaceInactiveHeight: 15
  readonly property int workspaceRadius: 1

  ListModel {
    id: workspaceModel
  }

  function syncWorkspaces(list) {
    for (let i = workspaceModel.count - 1; i >= 0; i--) {
      const id = workspaceModel.get(i).id
      if (!list.some(w => w.id === id)) {
        workspaceModel.remove(i)
      }
    }

    for (const w of list) {
      let idx = -1
      for (let i = 0; i < workspaceModel.count; i++) {
        if (workspaceModel.get(i).id === w.id) {
          idx = i
          break
        }
      }

      if (idx === -1) {
        workspaceModel.append({ id: w.id, name: w.name, focused: w.focused })
      } else {
        workspaceModel.setProperty(idx, "focused", w.focused)
        workspaceModel.setProperty(idx, "name", w.name)
      }
    }
  }

  Process {
    id: workspaceQuery
    command: ["swaymsg", "-t", "get_workspaces"]
    stdout: StdioCollector {
      onStreamFinished: {
        root.syncWorkspaces(JSON.parse(text))
      }
    }
  }

  Process {
    id: workspaceSubscribe
    command: ["swaymsg", "-m", "-t", "subscribe", "[\"workspace\"]"]
    running: true
    stdout: SplitParser {
      onRead: line => {
        workspaceQuery.running = true
      }
    }
  }

  Component.onCompleted: workspaceQuery.running = true

  Layout.alignment: Qt.AlignHCenter
  implicitHeight: childrenRect.height + 19
  width: moduleWidth
  radius: config.innerBModulesRadius
  color: Colors.moduleBG
  border.width: moduleBorderWidth
  border.color: Colors.borderColor

  ColumnLayout {
    anchors.centerIn: parent
    spacing: workspaceSpacing

    ColumnLayout {
      spacing: workspaceInnerSpacing

      Repeater {
        model: workspaceModel

        delegate: Item {
          id: workspaceItem
          required property var model
          property bool hovered: false

          width: root.workspaceWidth
          Layout.preferredHeight: workspaceItem.model.focused ? root.workspaceActiveHeight : root.workspaceInactiveHeight
          Layout.alignment: Qt.AlignHCenter

          Behavior on Layout.preferredHeight {
            NumberAnimation {
              duration: 200
              easing.type: Easing.OutCubic
            }
          }

          Rectangle {
            anchors.centerIn: parent
            width: root.workspaceWidth
            height: parent.height
            radius: root.workspaceRadius
            color: (workspaceItem.model.focused || workspaceItem.hovered) ? Colors.accent2Color : Colors.indicatorBGColor

            Behavior on color {
              ColorAnimation {
                duration: 200
                easing.type: Easing.OutQuart
              }
            }
          }

          MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: workspaceItem.hovered = true
            onExited: workspaceItem.hovered = false
            onWheel: wheel => {
              const direction = wheel.angleDelta.y > 0 ? "prev" : "next"
              Quickshell.execDetached(["swaymsg", "workspace", direction])
            }
          }
        }
      }
    }
  }
}
