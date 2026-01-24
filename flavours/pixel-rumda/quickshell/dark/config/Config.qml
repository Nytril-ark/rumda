pragma Singleton

import QtQuick
import Quickshell
import qs.shared

Singleton {
  // User Configuration
  readonly property string username: Common.cUsername
  readonly property string configPath: Common.cConfigPath
  readonly property string profilePath: Common.cProfilePathDark
  readonly property string gifPath: Common.cGifPath
  readonly property string fileManager: Common.cFileManager
  readonly property string browser: Common.cBrowser
  readonly property string terminal: Common.cTerminal

  // Bar Configuration
  property bool showLightBar: Common.cShowLightBar
  readonly property int barMarginTop: 80
  readonly property int barMarginBottom: 80
  readonly property int barMarginLeft: 18
  readonly property int barMarginRight: 1
  readonly property int barBorderWidth: 1
  readonly property int barWidth: 50
  readonly property int barRadius: 1
  readonly property int innerBModulesRadius: 3
  readonly property int innerBMSoffsetX: 32
  readonly property int innerBMSoffsetY: 2
  readonly property int innerBMSRadius: 1
  readonly property int hCenterOffsetInnerBM: 1
  // Bar shadow Configuration
  readonly property bool enableBarShadow: true
  readonly property bool enableCatShadow: false
  readonly property int shadowOffsetX: 3
  readonly property int shadowOffsetY: 3

  readonly property int barsGrave: 1400    // where the bar goes in terms of y position when it's animated out on a themeswitch (it then gets killed)
                                          // increasing it will increase animation speed. also, it kinda depends on ur screenheight


  // stuff I'm using to sync the bar switch animation. plz don't mess it up
  property int syncTbar: -(barsGrave - barMarginTop - barMarginBottom)
  property int syncBbar:  (barsGrave - barMarginTop - barMarginBottom)






  // Dashboard Configuration ====================
  readonly property int dashAnimDuration: 270
  readonly property bool pfpMipMap: true
  readonly property string githubUsername: Common.cGithubUsername
  readonly property double dashboardWidth:  Common.cDashboardWidth 
  readonly property double dashboardHeight: Common.cDashboardHeight 

  // config this to align the dashboard to the right or left
  readonly property bool dashboardOnRight: false
  // and config this to adjust the margin if you want something else in-between
  readonly property int dashMargin: 15
  // config this to change its vertical position, default is 0 which puts it in the middle
  readonly property int dashTopMargin: -204



  //  other custom properties
  readonly property int dashRadius: 2
  readonly property int dashBorderWidth: 3
  readonly property int dashInnerModuleBorderWidth: 0 // me when long names
  readonly property int dashInnerModuleRadius: 1
  readonly property int dashInnerPadding: 12
  readonly property int commitSquareSize: 12
  readonly property bool dashContribToolTip: true
  readonly property bool dashInnerModuleShadowVisible: true
  readonly property int outermostDSBorderWidth: 2
  readonly property int innerDSButtonSize: 40
  readonly property int innerDSoffsetX: 42
  readonly property int innerDSoffsetY: 2
  readonly property int innerDSRadius: 2

  // shadow config for the dashboard (outermost large shadow)
  readonly property bool enableDashShadow: true
  readonly property int dashShadowOffsetX: 3 
  readonly property int dashShadowOffsetY: 3


  // inner module-related sizes
  readonly property int profileAndControlsMinHeight: 85  // minimum height for the top row of modules in the dashboard
  readonly property int profileAndControlsMinWidth: 280
  readonly property int contribGraphMinHeight: 55 // bottom row of dashboard
  readonly property int contribMaxCols: 30


  // ============================================

  
  // Cat Configuration
  readonly property bool enableCat: Common.cEnableCat // set this to true to have the cat at the top of the bar
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

