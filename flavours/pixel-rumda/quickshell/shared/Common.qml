pragma Singleton

import QtQuick
import Quickshell
import qs.shared

Singleton {
  // tweak this if your dashboard has weird proportions or it's crushed because of screen size
  readonly property double cDashboardWidth: 2.93
  readonly property double cDashboardHeight: 0.35
  readonly property bool cShowLightBar: true // change the default bar theme


  // User Configuration
  readonly property string cUsername: Quickshell.env("USER") || "user"
  readonly property string cConfigPath: Quickshell.env("HOME") + "/.config/rumda/flavours/pixel-rumda/quickshell"
  readonly property string cProfilePathLight:  Quickshell.env("HOME") + "/.config/rumda/pictures/GatoInPan.png"  // profile pic in the dashboard
  readonly property string cProfilePathDark:  Quickshell.env("HOME") + "/.config/rumda/pictures/GatoInPanDarker.png"  // profile pic in the dashboard
  readonly property string cGifPath:  Quickshell.env("HOME") + "/.config/rumda/flavours/pixel-rumda/walk2.gif"  // profile pic in the dashboard
  readonly property string cGithubUsername: "Nytril-ark"   // obviously, if you aren't me, which you aren't, just change this into you github username
  readonly property string cFileManager: "nautilus" // or change it to "yazi", or "thunar" or whatever file manager you like
  readonly property string cBrowser: "firefox" // or whatever browser you like
  readonly property string cTerminal: "alacritty" // same thing here


  readonly property bool cEnableCat: false // set this to true to have the cat at the top of the bar
                                          // I disabled the cat by default because it looks weird when I theme-switch, but
                                         // you can also just kick it off by clicking on it, before switching themes.
}

