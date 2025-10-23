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
import qs.barModules

Rectangle {
  Layout.fillWidth: true
  Layout.preferredHeight: childrenRect.height + 8
  color: "transparent"
  
  property real innerModulesRadius: 3

  // Date/time formatting
  property string currentTime: Qt.formatDateTime(new Date(), "hh:mm")
  property string currentHours: Qt.formatDateTime(new Date(), "hh")
  property string currentMinutes: Qt.formatDateTime(new Date(), "mm")

  property string username: ""

  Process {
    command: ["whoami"]
    running: true
    stdout: SplitParser { onRead: name => username = name }
  }

  Timer {
    interval: 1000
    running: true
    repeat: true
    onTriggered: {
      currentTime = Qt.formatDateTime(new Date(), "hh:mm")
      currentHours = Qt.formatDateTime(new Date(), "hh")
      currentMinutes = Qt.formatDateTime(new Date(), "mm")
    }
  }

  Behavior on height {
    NumberAnimation {
      duration: 1000
      easing.type: Easing.InOutQuart
    }
  }

  ColumnLayout {
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.bottom: parent.bottom
    anchors.bottomMargin: 2
    spacing: 6

    ThemeSwitch {
      onThemeChanged: root.triggerBarAnimation()  // Pass the signal through
    }
    WeatherStatus {}
    InternetConnection {}
    Power {}

  }
}
