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
// import qs.dark.barModules
// import qs.dark.barSections
// import qs.dark.config
// import qs.dark.widgets
// light bar imports 
// import qs.light.barModules
// import qs.light.barSections
//
import qs.shared
import qs.light.config
import qs.light.bar
import qs.light.widgets
import qs.dark.bar

ShellRoot {
  id: root
  signal themeChangedAnimateCat()
  signal barLoaded()

  //==============================================================
  // The current animation isn't great, I plan on improving
  // its smoothness soon. I shall keep it like this for now
  // as a placeholder
  //
  //
  //
  // NOTE TO SELF: the paths for the frames have changed
  CatAnimation {
    shellRoot: root  
  }
  



  Loader {
    id: barLoader
    readonly property Component lightBar: Qt.createComponent("light/bar/LightBar.qml")
    readonly property Component darkBar: Qt.createComponent("dark/bar/DarkBar.qml")
    sourceComponent: Config.showLightBar ? lightBar : darkBar
  
    // ==================================
    // ==================================
    // NOTE to self:
    // use bezier curve in hypr window 
    // out animation and use a different
    // easing for the bar
    // ==================================
    // ==================================
    
    onLoaded: {
      console.log("Bar created:", barLoader.item)
      barLoader.item.shellRoot = root
      barLoaded()
    }


    Connections {
        target: barLoader.item
        function onBarSignalTheme() { 
          Qt.callLater(() => {
            // root.themeChangedAnimateCat()
          })
          delayTimer.start()
        }
    }

    Timer {
      id: delayTimer
      interval: 950 
      repeat: false
      onTriggered: Qt.callLater(() => {
        Config.showLightBar = !Config.showLightBar
      })
    }


  }
}

