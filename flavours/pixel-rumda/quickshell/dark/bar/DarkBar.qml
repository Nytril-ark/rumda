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
import qs.dark.barModules
import qs.dark.widgets
import qs.dark.config
import qs.dark.barSections





Scope {
  id: barScope
  property var shellRoot
  property int margint: Config.barMarginTop
  property int marginb: Config.barMarginBottom


  // DASHBOARD ==========

  Dashboard {}

  // ===================


  signal barLoaded()
  function initialiseBar() {
    barRectangle.anchors.topMargin = barScope.margint
    barRectangle.anchors.bottomMargin = barScope.marginb
  }
  Connections {
    target: shellRoot
    function onBarLoaded() {
      initialiseBar()
    }
  }

  signal barAnimate()
  signal barSignalTheme()
  function animationTrig() {
    console.log("Bar animation triggered!")
      barRectangle.anchors.topMargin = Config.syncTbar
      barRectangle.anchors.bottomMargin = Config.syncBbar 
      barSignalTheme()
  }
    // Animation functions exposed to parent
    // Note to self: well.. this works.. 
    // what I understand is that we're wrapping
    // the rectangle's function to expose it to the 
    // parent (aka, shell.qml) because it can't 
    // access it directly, and rather accesses
    // this scope


// ==================== MAIN BAR ====================
    PopoutVolume {}
    WlrLayershell {
      id: bar 
      anchors { top: true; bottom: true; left: true }
      layer: WlrLayer.Top
      implicitWidth: Config.barWidth + Config.barBorderWidth + Config.shadowOffsetX + 4
      color: "transparent"    
      margins {
        left: Config.barMarginLeft
        right: Config.barMarginRight 
        top: 0 
        bottom : 0
      }
      MouseArea {
        anchors.fill: parent
        onWheel: wheel => {
          Hyprland.dispatch("workspace 1")
          // Mpris.players.values.forEach((player, idx) => player.pause())
          // this ^ pauses on wspace switch, which i dont like
        }
      }


    Rectangle {
        id: shadowRect
        visible: Config.enableBarShadow
        anchors.top: barRectangle.top
        anchors.bottom: barRectangle.bottom
        anchors.left: barRectangle.left
        anchors.bottomMargin: -Config.shadowOffsetY
        anchors.rightMargin: -Config.shadowOffsetX
        implicitWidth: barRectangle.implicitWidth + Config.shadowOffsetX
        color: Colors.shadowColor
        radius: Config.barRadius
        Behavior on anchors.topMargin {
            NumberAnimation {
                duration: 600
                easing.type: Easing.InOutCubic
            }
        }
        Behavior on anchors.bottomMargin {
            NumberAnimation {
                duration: 600
                easing.type: Easing.InOutCubic
            }
        }
    }


     Rectangle {
        id: barRectangle
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        // anchors.horizontalCenter: parent.horizontalCenter
        color: Colors.backgroundColor
        radius: Config.barRadius
        border.width: Config.barBorderWidth
        border.color: Colors.borderColor
        implicitWidth: Config.barWidth + Config.barBorderWidth
        anchors.topMargin: -Config.syncTbar
        anchors.bottomMargin: -Config.syncBbar


        Behavior on anchors.topMargin {
          NumberAnimation {
            duration: 600
            // easing.type: Easing.InOutBack
            easing.type: Easing.InOutCubic
          }
        }
       Behavior on anchors.bottomMargin {
          NumberAnimation {
          duration: 600
          // easing.type: Easing.InOutBack
            easing.type: Easing.InOutCubic
        }
       }


        ColumnLayout {
          anchors { 
            fill: parent
            topMargin: -10
            bottomMargin: 10
            leftMargin: 3
            rightMargin: 3
          }
          spacing: 4
          TopSection {
            Layout.alignment: Qt.AlignHCenter    
            Layout.leftMargin: -Config.hCenterOffsetInnerBM
          }
          CenterSection {}
          BottomSection {
            onBarAnimate: animationTrig()
          }
        }
      }
    }
  }
