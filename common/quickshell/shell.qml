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
// dark bar imports
import qs.dark.barModules
import qs.dark.bar
import qs.dark.barSections
import qs.dark.config
import qs.dark.widgets
// light bar imports 
import qs.light.barModules
import qs.light.bar
import qs.light.barSections
import qs.light.config
import qs.light.widgets

ShellRoot {
  id: root



  //==============================================================
  // The current animation isn't great, I plan on improving
  // its smoothness soon. I shall keep it like this for now
  // as a placeholder
 
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
  
  CatAnimation {}

  Loader {
    id: barLoader
    readonly property Component lightBar: Qt.createComponent("light/bar/LightBar.qml")
    readonly property Component darkBar: Qt.createComponent("dark/bar/DarkBar.qml")
    
    sourceComponent: Config.showLightBar ? lightBar : darkBar
    
  }
}



// ==================== BAR SHADOW ====================
  // Loader {    // NOTE TO SELF : remove this shadow loader later
  //     active: Config.enableBarShadow
  //     readonly property Component lightBarShadow: Qt.createComponent("light/bar/LightBarShadow.qml")
  //     readonly property Component darkBarShadow: Qt.createComponent("dark/bar/DarkBarShadow.qml") 
  //     sourceComponent: Config.showLightBar ? lightBarShadow : darkBarShadow
  // }

