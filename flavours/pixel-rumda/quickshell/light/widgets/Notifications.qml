import Quickshell
import Quickshell.Services.Notifications
import QtQuick
import QtQuick.Layouts
import qs.light.config

Scope {
  readonly property color textDark: "#4E2E1F"

  NotificationServer {
    id: server
    actionsSupported: true
    bodySupported: true
    imageSupported: true
    keepOnReload: true
    onNotification: n => n.tracked = true
  }

  PanelWindow {
    anchors { top: true; right: true }
    margins { top: Config.notifMarginTop; right: Config.notifMarginRight }
    exclusionMode: ExclusionMode.Ignore
    implicitWidth: Config.notifWidth + Config.notifShadowOffsetX
    implicitHeight: Math.max(1, col.implicitHeight)
    visible: server.trackedNotifications.values.length > 0
    color: "transparent"

    ColumnLayout {
      id: col
      width: parent.width
      spacing: Config.notifSpacing

      Repeater {
        model: server.trackedNotifications

        delegate: Item {
          id: slot
          required property Notification modelData
          required property int index

          readonly property bool critical: modelData.urgency === NotificationUrgency.Critical
          readonly property bool isShot: modelData.appName === "screenshot"
          readonly property real timeoutMs: modelData.expireTimeout > 0
            ? modelData.expireTimeout * 1000
            : Config.notifTimeout
          readonly property real offscreen: Config.notifWidth + Config.notifShadowOffsetX

          property real progress: 1.0
          property real slideX: offscreen
          property bool closing: false
          property bool dismissOnEnd: false

          function close(dismiss) {
            if (closing) return
            closing = true
            dismissOnEnd = dismiss
            slideOut.start()
          }

          Layout.fillWidth: true
          implicitHeight: card.height + Config.notifShadowOffsetY

          NumberAnimation on slideX {
            from: slot.offscreen
            to: 0
            duration: Config.notifSlideDuration
            easing.type: Easing.OutCubic
            running: true
          }

          NumberAnimation on progress {
            from: 1.0
            to: 0.0
            duration: slot.timeoutMs
            running: !slot.critical
            paused: cardHover.hovered || slot.closing
            onFinished: slot.close(false)
          }

          NumberAnimation {
            id: slideOut
            target: slot
            property: "slideX"
            to: slot.offscreen
            duration: Config.notifSlideDuration
            easing.type: Easing.InCubic
            onFinished: {
              if (slot.dismissOnEnd) slot.modelData.dismiss()
              else slot.modelData.expire()
            }
          }

          Rectangle {
            x: card.x + Config.notifShadowOffsetX
            y: Config.notifShadowOffsetY
            width: card.width
            height: card.height
            radius: Config.notifRadius
            color: Colors.shadowColor
            z: 0
          }

          Rectangle {
            id: card
            x: slot.slideX
            y: 0
            z: 1
            width: slot.width - Config.notifShadowOffsetX
            height: innerCol.implicitHeight + Config.notifPadding * 2
              + Config.notifBarTopMargin + Config.notifBarHeight
            color: Colors.dashBGColor
            border.color: slot.critical ? Colors.errorColor : Colors.shadowColor
            border.width: Config.notifBorderWidth
            radius: Config.notifRadius

            HoverHandler { id: cardHover }

            MouseArea {
              anchors.fill: parent
              z: -1
              onClicked: slot.close(true)
            }

            ColumnLayout {
              id: innerCol
              x: Config.notifPadding
              y: Config.notifPadding
              width: parent.width - Config.notifPadding * 2
              spacing: 6

              RowLayout {
                Layout.fillWidth: true
                spacing: Config.notifPadding

                Item {
                  id: iconItem
                  width: Config.notifIconSize
                  height: Config.notifIconSize
                  Layout.alignment: Qt.AlignTop
                  visible: !slot.isShot

                  readonly property string src: {
                    const n = slot.modelData
                    if (n.image && n.image.length > 0) return n.image
                    if (n.appIcon && n.appIcon.length > 0) {
                      if (n.appIcon.startsWith("/")) return "file://" + n.appIcon
                      if (n.appIcon.indexOf("://") >= 0) return n.appIcon
                      return Quickshell.iconPath(n.appIcon, true)
                    }
                    return ""
                  }

                  Image {
                    id: appImg
                    anchors.fill: parent
                    source: iconItem.src
                    asynchronous: true
                    fillMode: Image.PreserveAspectFit
                    smooth: true
                    visible: status === Image.Ready
                  }

                  Rectangle {
                    anchors.fill: parent
                    visible: appImg.status !== Image.Ready
                    color: Colors.dashModulesColor
                    radius: Config.notifRadius

                    Text {
                      anchors.centerIn: parent
                      text: (slot.modelData.appName || slot.modelData.summary || "?")
                        .charAt(0).toUpperCase()
                      color: Colors.accentColor
                      font.family: Config.notifFont
                      font.pixelSize: Math.round(Config.notifIconSize * 0.5)
                      font.bold: true
                    }
                  }
                }

                ColumnLayout {
                  Layout.fillWidth: true
                  spacing: 4

                  Text {
                    Layout.fillWidth: true
                    text: slot.modelData.summary
                    color: textDark
                    font.family: Config.notifFont
                    font.pixelSize: 16
                    font.bold: true
                    elide: Text.ElideRight
                  }

                  Text {
                    Layout.fillWidth: true
                    text: slot.modelData.body
                    color: Colors.accentColor
                    font.family: Config.notifFont
                    font.pixelSize: 14
                    wrapMode: Text.Wrap
                    visible: text.length > 0
                  }
                }
              }

              Image {
                id: preview
                Layout.fillWidth: true
                Layout.preferredHeight: visible ? Config.notifShotHeight : 0
                source: {
                  if (!slot.isShot) return ""
                  const icon = slot.modelData.appIcon
                  if (!icon || icon.length === 0) return ""
                  if (icon.startsWith("/")) return "file://" + icon
                  if (icon.startsWith("file://")) return icon
                  return ""
                }
                sourceSize.width: 1200
                asynchronous: true
                fillMode: Image.PreserveAspectCrop
                clip: true
                smooth: true
                visible: slot.isShot && status === Image.Ready
              }

              Repeater {
                model: slot.modelData.actions
                delegate: Rectangle {
                  required property NotificationAction modelData
                  Layout.preferredWidth: Config.notifIconSize
                  height: Config.notifButtonHeight
                  color: Colors.moduleBG
                  radius: Config.notifRadius

                  Text {
                    anchors.centerIn: parent
                    width: parent.width - 8
                    horizontalAlignment: Text.AlignHCenter
                    elide: Text.ElideRight
                    text: parent.modelData.text
                    color: textDark
                    font.family: Config.notifFont
                    font.pixelSize: 13
                  }

                  MouseArea {
                    anchors.fill: parent
                    onClicked: parent.modelData.invoke()
                  }
                }
              }
            }

            Rectangle {
              x: Config.notifPadding
              y: card.height - Config.notifPadding - Config.notifBarHeight
              width: (card.width - Config.notifPadding * 2) * slot.progress
              height: Config.notifBarHeight
              color: slot.critical ? Colors.errorColor : Colors.accent2Color
            }
          }
        }
      }
    }
  }
}
