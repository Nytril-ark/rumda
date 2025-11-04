pragma Singleton

import QtQuick
import Quickshell
import qs.shared

Singleton {
                                                                  // this file is for stuff that applies to both light and dark bar
  // ScreenConf
  readonly property int cScreenHeight: 1080 // note: un-hard-code this
  readonly property int cScreenWidth: 1920 // un-hard-code this too


  // User Configuration
  readonly property string cUsername: Quickshell.env("USER") || "user"
  readonly property string cConfigPath: Quickshell.env("HOME") + "/.config/rumda/common/quickshell"
  readonly property string cProfilePath:  Quickshell.env("HOME") + "/.config/rumda/pictures/GatoInPan.png"  // profile pic in the dashboard
  readonly property string cGithubUsername: "Nytril-ark"   // obviously, if you aren't me, which you aren't, just change this into you github username
  readonly property string cFileManager: "nautilus" // or change it to "yazi", or "thunar" or whatever file manager you like
  readonly property string cBrowser: "firefox" // or whatever browser you lik
  readonly property string cTerminal: "ghostty" // same thing here

  readonly property bool cShowLightBar: true

}

