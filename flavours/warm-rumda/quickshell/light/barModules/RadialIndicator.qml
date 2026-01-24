import QtQuick

Canvas {
    id: root
    
    property int percent: 0
    property real size: 60
    property color indicatorColor: "#0f0"
    property color backgroundColor: "#333"
    
    width: size
    height: size
    
    readonly property real progress: percent / 100
    
    onPaint: {
        let ctx = getContext("2d")
        let centerX = width / 2
        let centerY = height / 2
        let radius = width / 2 - 4
        
        ctx.clearRect(0, 0, width, height)
        
        ctx.lineCap = "round"
        
        ctx.strokeStyle = backgroundColor
        ctx.lineWidth = 3
        ctx.beginPath()
        ctx.arc(centerX, centerY, radius, 0, 2 * Math.PI)
        ctx.stroke()
        
        if (progress > 0) {
            ctx.strokeStyle = indicatorColor
            ctx.beginPath()
            ctx.arc(centerX, centerY, radius, -Math.PI / 2, -Math.PI / 2 + 2 * Math.PI * progress)
            ctx.stroke()
        }
    }
    
    onProgressChanged: requestPaint()
    onIndicatorColorChanged: requestPaint()
    onBackgroundColorChanged: requestPaint()
}
