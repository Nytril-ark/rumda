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

ShellRoot {
  id: root
  
// ==================== CONFIGURATION ====================
  // User Configuration
  property string username: Quickshell.env("USER") || "user"
  property string configPath: Quickshell.env("HOME") + "/.config/rumda/quickshell"
  
  // Color Palette
  property color backgroundColor: "#E4C198"
  property color surfaceColor: "#AF8C65"
  property color borderColor: "#D1AB86"
  property color accentColor: "#AD704A"
  property color accentLightColor: "#F6CD96"
  property color errorColor: "#9A4235"
  property color backgroundTransparent: "#661e1e1e"
  property color shadowColor: "#3A2D26"
  
  // Bar Configuration
  property int barMarginTop: 80
  property int barMarginBottom: 80
  property int barMarginLeft: 19
  property int barMarginRight: -7
  property int barWidth: 50
  property int barRadius: 8
  property int barBorderWidth: 2
  // Shadow Configuration
  property bool enableBarShadow: true
  property bool enableCatShadow: true
  property int shadowOffsetX: -61
  property int shadowOffsetY: 1

  // Catsit.svg Configuration
  property bool enableCat: true
  property string catIconPath: configPath + "/icons/catsit.svg"
  property int catMarginTop: barMarginTop - 57   // attach cat to bar
  property int catMarginLeft: -50
  property int catWidth: 50
  property int catHeight: 90


  //==============================================================
  // The current animation isn't great, I plan on improving
  // its smoothness soon. I shall keep it like this for now
  // as a placeholder
  //
  // Cat Animation Configuration
  property string catAnimationFolder: configPath + "/gato-jump"
  property int catAnimationFrames: 9
  
  property var catFrameConfigs: [
    { marginTop: 25, marginLeft: -85, width: 140, height: 90, delay: 10, rotation: 0 },
    { marginTop: 20, marginLeft: -90, width: 140, height: 92, delay: 25, rotation: 0 },
    { marginTop: 15, marginLeft: -90, width: 140, height: 94, delay: 25, rotation: 14 },
    { marginTop: 13, marginLeft: -90, width: 150, height: 96, delay: 25, rotation: 14 },
    { marginTop: 15, marginLeft: -115, width: 160, height: 98, delay: 30, rotation: 0 },
    { marginTop: 9, marginLeft: -120, width: 170, height: 96, delay: 30, rotation: 0 },
    { marginTop: 2, marginLeft: -150, width: 180, height: 94, delay: 25, rotation: 0 },
    { marginTop: -6, marginLeft: -170, width: 190, height: 92, delay: 20, rotation: 0 },
    { marginTop: -16, marginLeft: -190, width: 200, height: 90, delay: 20, rotation: 0 }
  ]

  CatAnimation {
    enableCat: root.enableCat
    catIconPath: root.catIconPath
    catMarginTop: root.catMarginTop
    catMarginLeft: root.catMarginLeft
    catWidth: root.catWidth
    catHeight: root.catHeight
    catAnimationFolder: root.catAnimationFolder
    catAnimationFrames: root.catAnimationFrames
    catFrameConfigs: root.catFrameConfigs
    barMarginTop: root.barMarginTop
    barWidth: root.barWidth
  }


// ==================== BAR SHADOW ====================
  Loader {
    active: root.enableBarShadow
    sourceComponent: WlrLayershell {
      id: barShadow
      margins { 
        top: root.barMarginTop + root.shadowOffsetY
        left: root.barMarginLeft + root.shadowOffsetX
      }
      anchors { top: true; left: true }
      layer: WlrLayer.Bottom
      width: bar.width + 4
      height: bar.height + 4
      color: "transparent"
      
      Repeater {
        model: [
          { size: 0, opacity: 0.3, radius: 8 },
          { size: 2, opacity: 0.33, radius: 8 },
          { size: 4, opacity: 0.4, radius: 8 }
        ]
        
        Rectangle {
          required property var modelData
          
          anchors.centerIn: parent
          width: parent.width - modelData.size
          height: parent.height - modelData.size
          color: root.shadowColor
          opacity: modelData.opacity
          radius: modelData.radius
        }
      }
    }
  }

  // ==================== MAIN BAR ====================
  
  Scope {
    id: barScope
    
    Bar.PopoutVolume {}
    
    WlrLayershell {
      id: bar
      margins { 
        top: root.barMarginTop
        bottom: root.barMarginBottom
        left: root.barMarginLeft
        right: root.barMarginRight
      }
      anchors { top: true; bottom: true; left: true }
      layer: WlrLayer.Top
      implicitWidth: root.barWidth
      color: "transparent"
      
      MouseArea {
        anchors.fill: parent
        onWheel: wheel => {
          Hyprland.dispatch("workspace 1")
          // Mpris.players.values.forEach((player, idx) => player.pause())
        }
      }
      
      Rectangle {
        anchors.fill: parent
        color: root.backgroundColor
        radius: root.barRadius
        border.width: root.barBorderWidth
        border.color: root.borderColor
        
        Behavior on height {
          NumberAnimation {
            duration: 1000
            easing.type: Easing.InOutQuart
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
          
          TopSection {}
          CenterSection {}
          BottomSection {}
        }
      }
    }
  }
}
