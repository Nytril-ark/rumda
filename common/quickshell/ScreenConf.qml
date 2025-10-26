import QtQuick
import Quickshell

QtObject {
  required property var screen
  
  readonly property int screenHeight: screen.height
  readonly property int screenWidth: screen.width
}
