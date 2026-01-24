import Quickshell.Io
import Quickshell
import Quickshell.Wayland
import Quickshell.Services.Pipewire
import Quickshell.Widgets
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import qs.dark.config
import qs.dark.widgets

Rectangle {
  Rectangle {
    visible: Config.dashInnerModuleShadowVisible
    anchors.top: parent.top
    anchors.bottom: parent.bottom
    anchors.left: parent.left
    anchors.bottomMargin: -3
    implicitWidth: parent.width + 3
    z: -99
    color: Colors.shadowColorDS
    radius: Config.innerDSRadius
  }
  readonly property int buttonSizes: 51
  readonly property int buttonSpacing: 7
  readonly property int buttonBorderWidth: 0
  readonly property int displaySize: 52
  readonly property int topMarginOfText: 0
  readonly property int buttonsGapFromBottom: 15
  readonly property int iconSizes: 27
  readonly property int buttonFloatAmount: 6
  property color clockColor:  "#9E6D54"// Colors.indicatorBGColor
  
  color: Colors.dashModulesColor
  border.width: Config.dashInnerModuleBorderWidth
  border.color: Colors.borderColor
  radius: Config.dashInnerModuleRadius
  ColumnLayout {
    anchors.fill: parent
    anchors.margins: 10
    spacing: 12           
   
  Item {
    Layout.fillWidth: true
    Layout.fillHeight: true
    Layout.topMargin: 10
    Layout.alignment: Qt.AlignCenter
    
    Item {
      anchors.centerIn: parent
      width: displaySize + 90
      height: displaySize + 140
      
      // bottom rect (behind pfp)
      Rectangle {
        Rectangle {
          anchors.top: parent.top
          anchors.bottom: parent.bottom
          anchors.left: parent.left
          anchors.bottomMargin: -2
          implicitWidth: parent.width + 2
          z: -99
          color: Colors.shadowColorDS
          radius: Config.innerDSRadius
        }
        anchors.centerIn: parent
        width: displaySize + 90
        height: displaySize + 140
        radius: Config.dashInnerModuleRadius
        color: Colors.dashPFPColor
      }
      
      // border rect
      Rectangle {
        anchors.centerIn: parent
        width: displaySize + 70
        height: displaySize + 115
        radius: Config.dashInnerModuleRadius
        color: "transparent"
        border.width: 3
        border.color: Colors.dashBorderColor
      }



      // clock and date
      Column {
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 30
        spacing: 2
         
        // time
        Text {
          id: clockText
          anchors.horizontalCenter: parent.horizontalCenter
          text: Qt.formatTime(new Date(), "hh:mm")
          font.pixelSize: 30
          font.family: "Terminess Nerd Font"
          font.bold: true
          color: clockColor
          
          Timer {
            interval: 1000
            running: true
            repeat: true
            onTriggered: clockText.text = Qt.formatTime(new Date(), "hh:mm")
          }
        }
        // day 
        Text {
          anchors.horizontalCenter: parent.horizontalCenter
          text: Qt.formatDate(new Date(), "dddd")
          font.pixelSize: 16
          font.family: "Cartograph CF"
          font.italic: true
          font.bold: true
          color: clockColor
        }

        // date
        Text {
          anchors.horizontalCenter: parent.horizontalCenter
          text: Qt.formatDate(new Date(), "d MMM yyyy")
          font.pixelSize: 11
          font.bold: true
          font.family: "Terminess Nerd Font"
          color: clockColor
        }
      }



      // hilal gato
      Image {
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.bottomMargin: 10
        anchors.leftMargin: 10
        width: 70
        height: 70
        source: `file://${Config.configPath}/dark/icons/hilal.svg`
        fillMode: Image.PreserveAspectFit
        antialiasing: true
        mipmap: true
        smooth: true
      }
    }
  }
    Item {
      Layout.fillWidth: true
      Layout.bottomMargin: -20
      Layout.preferredHeight: dashPlayButtonsCol.height
      
      DashPlayButtons {
        id: dashPlayButtonsCol
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: 2
      }
    }
  }
}
