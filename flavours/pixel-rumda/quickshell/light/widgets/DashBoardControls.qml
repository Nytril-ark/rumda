import Quickshell.Io
import Quickshell
import Quickshell.Wayland
import Quickshell.Services.Pipewire
import Quickshell.Widgets
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import qs.light.config
import qs.light.widgets

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
  readonly property int pfpSize: 50
  readonly property int pfpRadius: pfpSize / 2
  readonly property int topMarginOfText: 0
  readonly property int buttonsGapFromBottom: 15
  readonly property int iconSizes: 27
  readonly property int buttonFloatAmount: 6

  
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
      Layout.topMargin: 10
      Layout.preferredHeight: 60
      
      Column {
        anchors.centerIn: parent
        spacing: 5
        
        Text {
          anchors.horizontalCenter: parent.horizontalCenter
          text: "Hello.."
          font.family: "Cartograph CF"
          font.italic: true     
          color: Colors.accentColor
          font.pixelSize: 19
          font.bold: true
        }
        
        Text {
          anchors.horizontalCenter: parent.horizontalCenter
          text: Config.username
          font.family: "Cartograph CF"
          font.italic: true     
          color: Colors.accentColor
          font.pixelSize: 24
          font.bold: true
        }
      }
    }
    
  // PFP
  Item {
    Layout.fillWidth: true
    Layout.fillHeight: true
    Layout.topMargin: 10
    Layout.alignment: Qt.AlignCenter
    
    Item {
      anchors.centerIn: parent
      width: pfpSize + 90
      height: pfpSize + 40
      
      // bottom circle (behind pfp)
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
        width: pfpSize + 90
        height: pfpSize + 40
        radius: Config.dashInnerModuleRadius
        color: Colors.dashPFPColor
      }
      
      // border circle
      Rectangle {
        anchors.centerIn: parent
        width: pfpSize + 70
        height: pfpSize + 23
        radius: Config.dashInnerModuleRadius
        color: "transparent"
        border.width: 3
        border.color: Colors.dashBorderColor
      }
      
      // GIF with clipping
      ClippingWrapperRectangle {
        anchors.centerIn: parent
        radius: Config.dashInnerModuleRadius
        width: pfpSize + 50
        height: pfpSize + 3
        
        AnimatedImage {
          anchors.fill: parent
          source: Config.gifPath
          scale: 2.5
          fillMode: Image.PreserveAspectFit
          playing: true
          antialiasing: true
          mipmap: true
          smooth: true
        }
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
      }
    }
  }
}
