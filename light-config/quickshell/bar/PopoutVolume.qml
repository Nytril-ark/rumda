import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Widgets
import Quickshell.Io

Scope {
  id: root
  
  // Theme colors
  readonly property color backgroundColor: "#E4C198"
  readonly property color indicatorBGColor: "#AF8C65"
  readonly property color borderColor: "#D1AB86"
  readonly property color moduleBG: "#DAB08B"
  readonly property color accentColor: "#6F4732"
  readonly property color accent2Color: "#9F684C"
  readonly property color gradientAccent2Color: "#a87358"
  readonly property color errorColor: "#9A4235"
  readonly property color backgroundTransparent: "#661e1e1e"
  readonly property color shadowColor: "#3A2D26"
  
  // Configuration
  readonly property string configPath: Quickshell.env("HOME") + "/.config/rumda/light-config/quickshell"
  readonly property string iconPath: `${configPath}/icons`
  property string username: Quickshell.env("USER") || "user"
  
  // Audio state
  readonly property PwNode sink: Pipewire.defaultAudioSink
  readonly property bool muted: sink?.audio?.muted ?? false
  readonly property real volume: sink?.audio?.volume ?? 0
  property bool shouldShowOsd: false
  property real lastVolume: 0
  
  // OSD dimensions
  readonly property int osdWidth: 200
  readonly property int osdHeight: 36
  readonly property int osdRadius: 7
  readonly property int osdBorderWidth: 2
  
  // Animation timings
  readonly property int hideDelay: 1000
  readonly property int showDuration: 400
  readonly property int hideDuration: 300
  readonly property int volumeAnimDuration: 150
  
  // Track audio volume
  PwObjectTracker {
    objects: [Pipewire.defaultAudioSink]
  }
  
  // Show OSD when volume changes
  Connections {
    target: Pipewire.defaultAudioSink?.audio
    function onVolumeChanged() {
      root.shouldShowOsd = true
      hideTimer.restart()
    }
  }
  
  // Auto-hide timer
  Timer {
    id: hideTimer
    interval: root.hideDelay
    onTriggered: root.shouldShowOsd = false
  }
  
  // Bounce animation trigger
  onVolumeChanged: {
    if (Math.abs(volume - lastVolume) > 0.01) {
      bounceAnimation.start()
      lastVolume = volume
    }
  }
  
  // Bounce animation sequence
  SequentialAnimation {
    id: bounceAnimation
    PropertyAnimation {
      target: popoutVolume.item
      property: "anchors.bottomMargin"
      to: -8
      duration: 120
      easing.type: Easing.OutBack
    }
    PropertyAnimation {
      target: popoutVolume.item
      property: "anchors.bottomMargin"
      to: 10
      duration: 180
      easing.type: Easing.InOutBounce
    }
    PropertyAnimation {
      target: popoutVolume.item
      property: "anchors.bottomMargin"
      to: -4
      duration: 140
      easing.type: Easing.OutBounce
    }
    PropertyAnimation {
      target: popoutVolume.item
      property: "anchors.bottomMargin"
      to: 6
      duration: 100
      easing.type: Easing.InOutQuad
    }
    PropertyAnimation {
      target: popoutVolume.item
      property: "anchors.bottomMargin"
      to: 0
      duration: 160
      easing.type: Easing.OutElastic
    }
  }
  
  // OSD window (lazy loaded)
  LazyLoader {
    id: popoutVolume
    active: root.shouldShowOsd
    
    PanelWindow {
      exclusionMode: ExclusionMode.Ignore  // Don't push windows away!
      anchors.bottom: true
      margins.bottom: screen.height / 12
      implicitWidth: root.osdWidth
      implicitHeight: root.osdHeight
      color: "transparent"
      
      // Volume control interactions
      MouseArea {
        anchors.fill: parent
        
        onClicked: {
          if (sink) sink.audio.muted = !root.muted
        }
        
        onWheel: wheel => {
          if (sink && !root.muted) {
            const delta = wheel.angleDelta.y > 0 ? 0.1 : -0.1
            const newVolume = Math.max(0, Math.min(1, root.volume + delta))
            sink.audio.volume = newVolume
          }
        }
      }
      
      // OSD container
      Rectangle {
        id: osdContainer
        anchors.fill: parent
        radius: root.osdRadius
        color: Colors.backgroundColor
        border.width: root.osdBorderWidth
        border.color: Colors.borderColor
        
        // Show/hide animations
        transform: [
          Scale {
            id: scaleTransform
            origin.x: osdContainer.width / 2
            origin.y: osdContainer.height / 2
            xScale: root.shouldShowOsd ? 1.0 : 0.4
            yScale: root.shouldShowOsd ? 1.0 : 0.4
            
            Behavior on xScale {
              PropertyAnimation {
                duration: root.shouldShowOsd ? root.showDuration : root.hideDuration
                easing.type: root.shouldShowOsd ? Easing.OutBack : Easing.InBack
              }
            }
            Behavior on yScale {
              PropertyAnimation {
                duration: root.shouldShowOsd ? root.showDuration : root.hideDuration
                easing.type: root.shouldShowOsd ? Easing.OutBack : Easing.InBack
              }
            }
          },
          Translate {
            id: translateTransform
            y: root.shouldShowOsd ? 0 : 100
            
            Behavior on y {
              PropertyAnimation {
                duration: root.shouldShowOsd ? root.showDuration : root.hideDuration
                easing.type: root.shouldShowOsd ? Easing.OutBack : Easing.InBack
              }
            }
          }
        ]
        
        // End wiggle animation
        SequentialAnimation {
          id: endWiggle
          running: false
          
          PauseAnimation { duration: 450 }
          
          SequentialAnimation {
            loops: 2
            
            PropertyAnimation {
              target: scaleTransform
              properties: "xScale,yScale"
              to: 1.05
              duration: 100
              easing.type: Easing.InOutSine
            }
            
            PropertyAnimation {
              target: scaleTransform
              properties: "xScale,yScale"
              to: 1.0
              duration: 100
              easing.type: Easing.InOutSine
            }
          }
        }
        
        onVisibleChanged: {
          if (visible && root.shouldShowOsd) {
            endWiggle.start()
          }
        }
        
        // OSD content layout
        RowLayout {
          anchors {
            fill: parent
            leftMargin: 10
            rightMargin: 15
          }
          
          // Speaker icon
          IconImage {
            implicitSize: 20
            source: `file://${root.iconPath}/${root.muted ? 'speaker-dark' : 'speaker'}.svg`
            opacity: root.muted ? 0.6 : 1.0
          }
          
          // Volume bar background
          Rectangle {
            id: volumeBarBg
            color: Colors.indicatorBGColor
            Layout.fillWidth: true
            implicitHeight: 10
            radius: 2
            
            // Volume bar fill
            Rectangle {
              id: volumeBarFill
              radius: 2
              anchors {
                left: parent.left
                top: parent.top
                bottom: parent.bottom
              }
              
              gradient: Gradient {
                orientation: Gradient.Horizontal
                GradientStop { position: 0; color: Colors.accentColor }
                GradientStop { position: 1; color: Colors.accent2Color }
              }
              
              width: {
                const volumeWidth = root.muted ? 1 : volumeBarBg.width * root.volume
                return Math.min(volumeWidth, volumeBarBg.width)
              }
              
              Behavior on width {
                PropertyAnimation {
                  duration: root.volumeAnimDuration
                  easing.type: Easing.OutQuad
                }
              }
            }
          }
        }
      }
    }
  }
}
