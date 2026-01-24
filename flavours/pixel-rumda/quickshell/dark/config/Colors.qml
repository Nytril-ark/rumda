pragma Singleton
import Quickshell
import QtQuick

Singleton {

  property color backgroundColor: "#1c1612"  //bar color
  property color indicatorBGColor: "#f0bb90" 
  property color borderColor: "#784D37" // "#603E2C" // "#3A2D22"
  property color moduleBG: "#3d2e21" 
  property color accentColor: "#c47c4f" 
  property color accent2Color: "#c47c4f" 
  property color gradientAccent2Color: "#d68e60"  // bottom / right of volume bar
  property color errorColor: "#9A4235" 
  property color shadowColor: "#784D37"   // you can disable shadow from config
  property color outermostDSShadow: "#603E2C"
  property color shadowColorBM: "#654331"
  property color shadowColorDS: "#1C1612"
  property color shadowColorCSquare: "#1C1612"

  // dashboard related colors
  property color dashBGColor: "#2b221a"
  property color dashModulesColor: "#3d2e21" // color of the inner modules / rectangles
  property color dashBorderColor: "#3A2D22"     // this is used in the borders / border circle around pfp
  property color dashPFPColor: "#2b221a"   // circle around pfp
  // ========================================those are specific to the contribution squares in the commit graph
  property color level0Contrib: "#5c3d2d"
  property color level1Contrib: "#9e6d54"
  property color level2Contrib: "#cf9174"
  property color level3Contrib: "#db9d7f"
  property color level4Contrib: "#f7b292"
  //========================================
  property color powerButtons: "#2b221a"  // bg color of the buttons (used in all buttons for consistency)
  //========================================
  property color dashAccentColor: "#3A2D00"  // ignore this
}


