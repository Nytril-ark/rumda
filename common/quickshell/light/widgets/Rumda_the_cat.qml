import QtQuick
import Quickshell
import Quickshell.Wayland

WlrLayershell {
  id: animatedCat

  property string framesPath: Quickshell.env("HOME") + "/.config/rumda/light-config/quickshell/rumda-the-cat/walk_frames"
  property int startFrame: 1
  property int endFrame: 15
  property int frameDelay: 50  // milliseconds between frames

  property string position: "center"  // "center", "top-left", "top-right", "bottom-left", "bottom-right", "custom"
  property int customX: 0
  property int customY: 0

  property int catWidth: 100
  property int catHeight: 100

  property bool enableMovement: false
  property bool movementEnabled: enableMovement
  property int movementSpeed: 4000
  property string movementDirection: "right"  // "left", "right", "up", "down"
  property bool movementLoop: true
  property bool movementBounce: false

  property var catLayer: WlrLayer.Overlay

  property bool isPlaying: true
  property bool flipHorizontal: false

  property int currentFrame: startFrame
  property real movementProgress: 0.0
  property bool movingForward: true

  anchors {
    top: position.includes("top") || position === "custom"
    bottom: position.includes("bottom")
    left: position.includes("left") || position === "custom"
    right: position.includes("right")
  }

  margins {
    top: getTopMargin()
    left: getLeftMargin()
    right: getRightMargin()
    bottom: getBottomMargin()
  }

  function getTopMargin() {
    if (position === "custom")
      return customY;
    if (position === "center")
      return 0;
    return 50;
  }

  function getLeftMargin() {
    if (position === "custom")
      return customX;
    if (position === "center")
      return 0;
    if (enableMovement && movementDirection === "right") {
      return -catWidth + (movementProgress * (width + catWidth * 2));
    }
    return 50;
  }

  function getRightMargin() {
    if (enableMovement && movementDirection === "left") {
      return -catWidth + (movementProgress * (width + catWidth * 2));
    }
    return 50;
  }

  function getBottomMargin() {
    if (position === "custom")
      return customY;
    if (enableMovement && movementDirection === "up") {
      return -catHeight + (movementProgress * (height + catHeight * 2));
    }
    return 50;
  }

  function resetAnimation() {
    currentFrame = startFrame;
  }

  function resetMovement() {
    movementProgress = 0.0;
    movingForward = true;
  }

  layer: catLayer
  color: "transparent"
  keyboardFocus: WlrKeyboardFocus.None
  implicitWidth: catWidth
  implicitHeight: catHeight

  Rectangle {
    id: catContainer

    anchors {
      centerIn: position === "center" ? parent : undefined
      fill: position !== "center" ? parent : undefined
    }

    width: position === "center" ? animatedCat.catWidth : undefined
    height: position === "center" ? animatedCat.catHeight : undefined

    color: "transparent"

    Image {
      id: catImage

      anchors.fill: parent
      source: `file://${animatedCat.framesPath}/${String(animatedCat.currentFrame)}.svg`
      mipmap: true
      smooth: true
      fillMode: Image.PreserveAspectFit
      antialiasing: true

      mirror: animatedCat.flipHorizontal || (animatedCat.enableMovement && animatedCat.movementDirection === "left")

      rotation: animatedCat.enableMovement && (animatedCat.movementDirection === "up" || animatedCat.movementDirection === "down") ? 90 : 0

      onStatusChanged: {
        if (status === Image.Error) {
          console.error("AnimatedCat: Failed to load frame", animatedCat.currentFrame, "from", source);
        }
      }
    }
  }

  Timer {
    id: frameTimer

    interval: animatedCat.frameDelay
    running: animatedCat.isPlaying
    repeat: true

    onTriggered: {
      animatedCat.currentFrame++;

      if (animatedCat.currentFrame > animatedCat.endFrame) {
        animatedCat.currentFrame = animatedCat.startFrame;
      }
    }
  }

  Timer {
    id: movementTimer

    interval: 16 // ~60 fps (?)
    running: animatedCat.enableMovement
    repeat: true

    onTriggered: {
      if (!animatedCat.enableMovement)
        return;
      var step = interval / animatedCat.movementSpeed;

      if (animatedCat.movingForward) {
        animatedCat.movementProgress += step;

        if (animatedCat.movementProgress >= 1.0) {
          animatedCat.movementProgress = 1.0;

          if (animatedCat.movementBounce) {
            animatedCat.movingForward = false;
            animatedCat.flipHorizontal = !animatedCat.flipHorizontal;
          } else if (animatedCat.movementLoop) {
            animatedCat.movementProgress = 0.0;
          } else {
            animatedCat.enableMovement = false;
          }
        }
      } else {
        animatedCat.movementProgress -= step;

        if (animatedCat.movementProgress <= 0.0) {
          animatedCat.movementProgress = 0.0;
          animatedCat.movingForward = true;
          animatedCat.flipHorizontal = !animatedCat.flipHorizontal;
        }
      }
    }
  }

  function play() {
    isPlaying = true;
  }

  function pause() {
    isPlaying = false;
  }

  function stop() {
    isPlaying = false;
    resetAnimation();
  }

  function startMovement() {
    enableMovement = true;
    resetMovement();
  }

  function stopMovement() {
    enableMovement = false;
    resetMovement();
  }
}
