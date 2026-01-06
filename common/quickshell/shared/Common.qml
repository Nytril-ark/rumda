pragma Singleton

import QtQuick
import Quickshell
import qs.shared

Singleton {

  // User Configuration
  readonly property string cUsername: Quickshell.env("USER") || "user"
  readonly property string cConfigPath: Quickshell.env("HOME") + "/.config/rumda/common/quickshell"
  readonly property string cProfilePath:  Quickshell.env("HOME") + "/.config/rumda/pictures/GatoInPan.png"  // profile pic in the dashboard
  readonly property string cGithubUsername: "Nytril-ark"   // obviously, if you aren't me, which you aren't, just change this into you github username
  readonly property string cFileManager: "nautilus" // or change it to "yazi", or "thunar" or whatever file manager you like
  readonly property string cBrowser: "firefox" // or whatever browser you like
  readonly property string cTerminal: "alacritty" // same thing here

  readonly property bool cShowLightBar: true

  readonly property bool cEnableCat: false // set this to true to have the cat at the top of the bar
                                          // I disabled the cat by default because it looks weird when I theme-switch, but
                                         // you can also just kick it off by clicking on it, before switching themes.
}

