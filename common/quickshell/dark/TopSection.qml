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
import qs.config
import qs.barModules

Rectangle {
  property string currentTime: Qt.formatDateTime(new Date(), "hh:mm")
  property string currentHours: Qt.formatDateTime(new Date(), "hh")
  property string currentMinutes: Qt.formatDateTime(new Date(), "mm")
  property string currentMonth: Qt.formatDateTime(new Date(), "MM")
  property string currentDay: Qt.formatDateTime(new Date(), "dd")

  Layout.fillWidth: true
  Layout.preferredHeight: clockModule.implicitHeight + 12
  color: "transparent"

  property real innerModulesRadius: 3

  // System info properties
  property real cpuUsage: 0.3
  property real ramUsage: 0.6

  Behavior on Layout.preferredHeight {
    NumberAnimation {
      duration: 1000
      easing.type: Easing.InOutQuart
    }
  }

  property string username: ""

  Process {
    command: ["whoami"]
    running: true
    stdout: SplitParser { onRead: name => username = name }
  }

  // CPU monitoring
  Process {
    id: cpuProcess
    command: ["sh", "-c", "top -bn1 | grep '%Cpu(s):' | awk '{print $2}' | sed 's/%us,//'"]
    running: true

    stdout: SplitParser {
      onRead: data => {
        let usage = parseFloat(data.trim())
        if (!isNaN(usage)) cpuUsage = Math.round(usage)
      }
    }
  }

  // RAM monitoring  
  Process {
    id: ramProcess
    command: ["sh", "-c", "free | grep Mem: | awk '{printf \"%.0f\", ($2-$7)/$2*100}'"]
  running: true

    stdout: SplitParser {
      onRead: data => {
        let usage = parseInt(data.trim())
        if (!isNaN(usage)) ramUsage = usage
      }
    }
  }

  Timer {
    interval: 1000
    running: true
    repeat: true
    onTriggered: {
      cpuProcess.running = true
      ramProcess.running = true
    }
  }


  ColumnLayout {
    id: clockModule
    property bool expanded: false
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.top
    anchors.topMargin: 29
    spacing: 6

    // Time module
  Timer {
    interval: 60000
    running: true
    repeat: true
    onTriggered: {
      currentMonth = Qt.formatDateTime(new Date(), "MM")
      currentDay   = Qt.formatDateTime(new Date(), "dd")
    }
  }
    // Date module
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

  Rectangle {
    Layout.alignment: Qt.AlignHCenter    
    Layout.preferredHeight: clockModule.expanded ? 80 : 45
    Behavior on Layout.preferredHeight {
      NumberAnimation { 
        duration: 250
        easing.type: Easing.InOutQuad
      }
    }
    width: 28
    radius: 7
    border.width: 1
    border.color: Colors.borderColor
    color: Colors.moduleBG

    Loader {
      id: loader
      anchors.centerIn: parent
      sourceComponent: clockModule.expanded ? dateComponent : clockComponent
    }
    // time module component
    Component {
        id: clockComponent
        ColumnLayout {
        anchors.centerIn: parent
        spacing: 0

        Text {
          Layout.alignment: Qt.AlignHCenter
          text: currentHours
          color: Colors.accentColor
          font.family: "Cartograph CF Heavy"
          font.pixelSize: 12
        }

        Text {
          Layout.alignment: Qt.AlignHCenter
          text: currentMinutes
          color: Colors.accentColor
          font.family: "Cartograph CF Heavy"
          font.pixelSize: 12
        }
      }
    }
    // date module component
    Component {
        id: dateComponent
        ColumnLayout {

        anchors.centerIn: parent
        spacing: 0

        Text {
          Layout.alignment: Qt.AlignHCenter
          text: currentDay
          color: Colors.accentColor
          font.family: "Cartograph CF Heavy"
          font.pixelSize: 12
        }

        Text {
          Layout.alignment: Qt.AlignHCenter
          text: currentMonth
          color: Colors.accentColor
          font.family: "Cartograph CF Heavy"
          font.pixelSize: 12
        }
      }
    }
    MouseArea {
      anchors.fill: parent
      cursorShape: Qt.PointingHandCursor
      hoverEnabled: true
      onEntered: clockModule.expanded = !clockModule.expanded
      onExited: clockModule.expanded = !clockModule.expanded
    }

  }
  
  VolumeControl {}


    // CPU and RAM indicators
    Rectangle {
      Layout.alignment: Qt.AlignHCenter
      width: 28
      height: 60
      radius: 7
      color: Colors.moduleBG 

      border.width: 1
      border.color: Colors.borderColor

      ColumnLayout {
        anchors.centerIn: parent
        spacing: 2

        // CPU indicator
        RadialIndicator {
          Layout.alignment: Qt.AlignHCenter
          percent: cpuUsage
          indicatorColor: Colors.accentColor
          backgroundColor: Colors.indicatorBGColor
          size: 24
        }

        // RAM indicator
        RadialIndicator {
          Layout.alignment: Qt.AlignHCenter
          percent: ramUsage
          indicatorColor: Colors.accent2Color
          backgroundColor: Colors.indicatorBGColor
          size: 24
        }
      }
    }
  }
}
