pragma Singleton

import QtQuick
import Quickshell
import qs.shared

Singleton {
  // ScreenConf
  readonly property int screenHeight: Common.cScreenHeight
  readonly property int screenWidth:  Common.cScreenWidth


  // User Configuration
  readonly property string username: Common.cUsername
  readonly property string configPath: Common.cConfigPath
  readonly property string profilePath: Common.cProfilePath
  readonly property string fileManager: Common.cFileManager
  readonly property string browser: Common.cBrowser
  readonly property string terminal: Common.cTerminal

  // Bar Configuration
  property bool showLightBar: Common.cShowLightBar
  readonly property int barMarginTop: 80
  readonly property int barMarginBottom: 80
  readonly property int barMarginLeft: 18
  readonly property int barMarginRight: 1
  readonly property int barWidth: 48
  readonly property int barRadius: 8
  readonly property int barBorderWidth: 3
  readonly property int barsGrave: 1400    // where the bar goes in terms of y position when it's animated out on a themeswitch (it then gets killed)
                                          // increasing it will increase animation speed. also, it kinda depends on ur screenheight


  // stuff I'm using to sync the bar switch animation. plz don't mess it up
  property int syncTbar: -(barsGrave - barMarginTop - barMarginBottom)
  property int syncBbar:  (barsGrave - barMarginTop - barMarginBottom)


  // Shadow Configuration
  readonly property bool enableBarShadow: false
  readonly property bool enableCatShadow: false
  readonly property int shadowOffsetX: 1 // note: hardcoded, bind later
  readonly property int shadowOffsetY: 2


  // Dashboard Configuration ====================
  readonly property int dashAnimDuration: 250
  readonly property string githubUsername: Common.cGithubUsername
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
  readonly property bool enableDashShadow: true
  readonly property int dashShadowOffsetX: 3 // note: hardcoded, bind later
  readonly property int dashShadowOffsetY: 3


  // inner module-related sizes
  readonly property int profileAndControlsMinHeight: 85  // minimum height for the top row of modules in the dashboard
  readonly property int contribGraphMinHeight: 55 // bottom row of dashboard

  // ============================================

  
  // Cat Configuration
  readonly property bool enableCat: true
  readonly property string catIconPath: configPath + "/dark/icons/catsit.svg"
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
  property string catAnimationFolder: configPath + "/dark/gato-jump"
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

