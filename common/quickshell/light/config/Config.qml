pragma Singleton
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
import qs

Singleton {
  // ScreenConf
  readonly property int screenHeight: 1080 // note: un-hard-code this
  readonly property int screenWidth: 1920 // un-hard-code this too


  // User Configuration
  readonly property string username: Quickshell.env("USER") || "user"
  readonly property string configPath: Quickshell.env("HOME") + "/.config/rumda/common/quickshell"
  readonly property string profilePath:  Quickshell.env("HOME") + "/.config/rumda/pictures/gatoInPan.png"  // profile pic in the dashboard
  readonly property string fileManager: "nautilus" // or change it to "yazi", or "thunar" or whatever file manager you like
  readonly property string browser: "firefox" // or whatever browser you like
  

  // Bar Configuration
  readonly property int barMarginTop: 80
  readonly property int barMarginBottom: 80
  readonly property int barMarginLeft: 18
  readonly property int barMarginRight: 1
  readonly property int barWidth: 48
  readonly property int barRadius: 8
  readonly property int barBorderWidth: 2
  readonly property int barsGrave: 1400    // where the bar goes in terms of y position when it's animated out on a themeswitch (it then gets killed)
                                          // increasing it will increase animation speed. also, it kinda depends on ur screenheight
  property bool showLightBar: true
  // stuff I'm using to sync the bar switch animation. plz don't mess it up
  property int syncTbar: -(barsGrave - barMarginTop - barMarginBottom)
  property int syncBbar:  (barsGrave - barMarginTop - barMarginBottom)


  // Shadow Configuration
  readonly property bool enableBarShadow: true
  readonly property bool enableCatShadow: false
  readonly property int shadowOffsetX: 3 // note: hardcoded, bind later
  readonly property int shadowOffsetY: 0


  // Dashboard Configuration =========
  readonly property int dashAnimDuration: 250
  // obviously, if you aren't me, which you aren't, just change this into you github username
  readonly property string githubUsername: "Nytril-ark"
  // dashboard size config
  readonly property double dashboardWidth:  3.36 // this is what you change, don't touch the below 2
  readonly property double dashboardHeight: 3.6    // same here       // note that both those values are proportional to screen width/height
  
  // to change width accordingly: (don't mess with those)
  readonly property int dashMarginLeft: ((1 / dashboardWidth) * screenWidth) - barWidth - barBorderWidth - shadowOffsetX - 4
  readonly property int dashMarginRight: ((1 / dashboardWidth) * screenWidth) // note to self: allow it to change according to github graph size
  readonly property int dashMarginTop: ((1 / dashboardHeight) * screenHeight)
  readonly property int dashMarginBottom: ((1 / dashboardHeight) * screenHeight) 



  //  other custom properties
  readonly property int dashRadius: 12
  readonly property int dashBorderWidth: 3
  readonly property int dashInnerModuleBorderWidth: 0 // me when long names
  readonly property int dashInnerModuleRadius: 9
  readonly property int dashInnerPadding: 10
  readonly property int commitSquareSize: 12
  readonly property bool dashContribToolTip: false // note: fix the layer for this

  // shadow config for the dashboard
  readonly property bool enableDashShadow: true //note to self: implement
  readonly property int dashShadowOffsetX: 3 // note: hardcoded, bind later
  readonly property int dashShadowOffsetY: 3


  // inner module-related sizes
  readonly property int profileAndControlsMinHeight: 85  // minimum height for the top row of modules in the dashboard
  readonly property int contribGraphMinHeight: 55 // bottom row of dashboard

  // =================================
  
  // Cat Configuration
  readonly property bool enableCat: false // note: I disabled le cat momentarily because it looks weird when I switch themes
  readonly property string catIconPath: configPath + "/light/icons/catsit.svg"
  readonly property int catMarginTop: barMarginTop - 57
  readonly property int catMarginLeft: -15 - barWidth //note: this is hardcoded, bind it to the bar later
  readonly property int catWidth: 50
  readonly property int catHeight: 90
  //==============================================================
  // The current animation isn't great, I plan on improving
  // its smoothness soon. I shall keep it like this for now
  // as a placeholder
  //
  // Cat jump out Animation Configuration
  property string catAnimationFolder: configPath + "/light/gato-jump"
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
}

