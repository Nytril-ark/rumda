pragma Singleton

import QtQuick
import Quickshell

Singleton {
  // User Configuration
  readonly property string username: Quickshell.env("USER") || "user"
  readonly property string configPath: Quickshell.env("HOME") + "/.config/rumda/common/quickshell"




  // Bar Configuration
  readonly property int barMarginTop: 80
  readonly property int barMarginBottom: 80
  readonly property int barMarginLeft: 19
  readonly property int barMarginRight: -7
  readonly property int barWidth: 50
  readonly property int barRadius: 8
  readonly property int barBorderWidth: 2
  readonly property bool showLightBar: true


  readonly property int barHeight: 700 // NOTE TO SELF: delete this LATER

  // Shadow Configuration
  readonly property bool enableBarShadow: true
  readonly property bool enableCatShadow: true
  readonly property int shadowOffsetX: -61
  readonly property int shadowOffsetY: 1
  
  // Cat Configuration
  readonly property bool enableCat: true
  readonly property string catIconPath: configPath + "/light/icons/catsit.svg"
  readonly property int catMarginTop: barMarginTop - 57
  readonly property int catMarginLeft: -50
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

