pragma Singleton
import Quickshell
import QtQuick

Singleton {
  property color backgroundColor: "#f0c997"  //bar color
  property color indicatorBGColor: "#dba380" 
  property color borderColor: "#f2bc88" 
  property color moduleBG: "#f0bb90" 
  property color accentColor: "#a1694d" 
  property color accent2Color: "#c47c4f" 
  property color gradientAccent2Color: "#a87358"  //bottom/right of volume bar
  property color errorColor: "#9A4235" 
  property color shadowColor: "#AA784d37" 
  // dashboard related colors
  property color dashBGColor: "#F5DCC6"        
  property color dashModulesColor: "#f2cdac"  // color of the inner modules / rectangles
  property color dashBorderColor: "#f2bc88"     // this is used in the borders / border circle around pfp
  property color dashPFPColor: "#F5DCC6"   // circle around pfp
  // ========================================those are specific to the contribution squares in the commit graph
  property color level0Contrib: "#db986e"
  property color level1Contrib: "#ba7245"
  property color level2Contrib: "#9e5b2f"
  property color level3Contrib: "#8f4f24"
  property color level4Contrib: "#7d431f"
  //========================================
  property color powerButtons: "#F5DCC6"  // bg color of the buttons (used in all buttons for consistency)
  //========================================
  property color dashAccentColor: "#f2bc88" // ignore this
}


