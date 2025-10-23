pragma Singleton

import QtQuick
import Quickshell

Singleton {
  // User Configuration
  readonly property string username: Quickshell.env("USER") || "user"
  readonly property string configPath: Quickshell.env("HOME") + "/.config/rumda/light-config/quickshell"
  
  // Bar Configuration
  readonly property int barMarginTop: 80
  readonly property int barMarginBottom: 80
  readonly property int barMarginLeft: 19
  readonly property int barMarginRight: -7
  readonly property int barWidth: 50
  readonly property int barRadius: 8
  readonly property int barBorderWidth: 2
  
  // Shadow Configuration
  readonly property bool enableBarShadow: true
  readonly property bool enableCatShadow: true
  readonly property int shadowOffsetX: -61
  readonly property int shadowOffsetY: 1
  
  // Cat Configuration
  readonly property bool enableCat: true
  readonly property string catIconPath: configPath + "/icons/catsit.svg"
  readonly property int catMarginTop: barMarginTop - 57
  readonly property int catMarginLeft: -50
  readonly property int catWidth: 50
  readonly property int catHeight: 90
}
