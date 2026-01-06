import Quickshell.Io
import Quickshell
import Quickshell.Wayland
import Quickshell.Services.Pipewire
import Quickshell.Widgets
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import qs.dark.config



Rectangle {
  property string username: Config.githubUsername  // obviously, if you aren't me, which you aren't, just change this into you github username
  property var contributionData: [] // this is fetched, but organised chronologically, so we need to create the following bit..
  property var gridData: []  // < which is this. gotta organise them into weeks

  readonly property int headerMargin: 23

  // lil watcher to clear the data if the username is changed 
  onUsernameChanged: {
    contributionData = []
    gridData = []
    githubFetch.running = true
  }



  id: contribGraphRect
  implicitWidth: {
    let weeks = Math.ceil(gridData.length / 7)
    return weeks * (Config.commitSquareSize + 3) + 44  // +44 for margins
  }
  color: Colors.dashModulesColor
  border.width: Config.dashInnerModuleBorderWidth
  border.color: Colors.borderColor
  radius: Config.dashInnerModuleRadius



  Process {
    id: githubFetch
    command: [
      "curl", "-s",
      `https://github-contributions-api.jogruber.de/v4/${username}`
    ]
    running: true
    
  stdout: SplitParser {
    onRead: data => {
      try {
        let response = JSON.parse(data)
        
        let today = new Date()
        today.setHours(0, 0, 0, 0)
        
        // Calculate one year ago more carefully
        let oneYearAgo = new Date(today)
        oneYearAgo.setFullYear(today.getFullYear() - 1)
        oneYearAgo.setHours(0, 0, 0, 0)
        
        console.log("Today:", today.toISOString())
        console.log("One year ago:", oneYearAgo.toISOString())
        
        contributionData = []
        contributionData = response.contributions.filter(day => {
          // Parse date string directly to avoid timezone issues
          let parts = day.date.split('-')
          let dayDate = new Date(parseInt(parts[0]), parseInt(parts[1]) - 1, parseInt(parts[2]))
          
          let inRange = dayDate >= oneYearAgo && dayDate <= today
          return inRange
        })
        
        console.log(`Loaded ${contributionData.length} days of contributions`)
        if (contributionData.length > 0) {
          console.log("First day:", contributionData[0].date)
          console.log("Last day:", contributionData[contributionData.length - 1].date)
        }
        
        organizeGridData()
      } catch (e) {
        console.error("Failed to parse GitHub data:", e)
      }
    }
  }
  }


  function organizeGridData() {
    gridData = []
    
    if (contributionData.length === 0) return
    
    let sorted = contributionData.slice().sort((a, b) => {
      return new Date(a.date) - new Date(b.date)
    })
    
    const MAX_DAYS = 46 * 7
    if (sorted.length > MAX_DAYS) {
      sorted = sorted.slice(sorted.length - MAX_DAYS)
    }
    
    gridData = sorted
  }

  
  // this is set to auto-refresh every hour
  Timer {
    interval: 3600000
    running: true
    repeat: true
    onTriggered: githubFetch.running = true
  }
  
  Item {
    id: tooltipContainer
    anchors.fill: parent
    z: 1000
    
    Loader {
      id: tooltipLoader
      active: false
      
      sourceComponent: Rectangle {
        id: tooltip
        property var dayData: ({count: 0, date: ""})
        
        function updatePosition(square) {
          let pos = square.mapToItem(tooltipContainer, 0, 0)
          tooltip.x = pos.x + square.width / 2 - tooltip.width / 2
          tooltip.y = pos.y - tooltip.height - 5
        }
        
        width: tooltipText.width + 16
        height: tooltipText.height + 12
        color: Colors.dashAccentColor
        radius: 6
        border.color: Colors.borderColor
        border.width: 1
        
        // Tooltip arrow
        Rectangle {
          width: 8
          height: 8
          color: Colors.dashAccentColor
          rotation: 45
          anchors.horizontalCenter: parent.horizontalCenter
          anchors.top: parent.bottom
          anchors.topMargin: -4
        }
        
        Text {
          id: tooltipText
          anchors.centerIn: parent
          text: dayData.count + " contributions\n" + dayData.date
          color: Colors.accentColor
          font.pixelSize: 11
          horizontalAlignment: Text.AlignHCenter
        }
      }
    }
  }

  ColumnLayout {
      anchors.fill: parent
      // anchors.leftMargin: 8
      // anchors.rightMargin: 8
      anchors.topMargin: 14
      anchors.bottomMargin: 13
      spacing: 4
      
      // // Header   // above graph ========
      RowLayout { 
        Layout.fillWidth: true

        Text {
          text: `@${username}'s Contributions`
          color: Colors.accentColor
          font.pixelSize: 11
          font.bold: true
          Layout.alignment: Qt.AlignBottom  
          Layout.leftMargin: headerMargin
        }

        Item {  // spacer between the 2 texts
          Layout.fillWidth: true
        }

        Text {
          text: contributionData.length > 0 ? 
            `${contributionData.reduce((sum, d) => sum + d.count, 0)} total` : ""
          color: Colors.accent2Color
          font.pixelSize: 19
          font.bold: true
          Layout.rightMargin: headerMargin
          Layout.alignment: Qt.AlignBottom
        }
      }
      // ======================================


      Grid {
        id: contributionGrid
        columns: Math.ceil(gridData.length / 7)
        rows: 7      
        spacing: 3
        flow: Grid.TopToBottom 
        Layout.alignment: Qt.AlignHCenter
        
        Repeater {
          model: gridData.length  
          
          Rectangle {
            id: commitSquares
            width: Config.commitSquareSize
            height: Config.commitSquareSize
            radius: 2
            
            property var day: gridData[index] || {level: 0, count: 0, date: ""} 
            
            color: {
              switch (day.level) {
                case 0: return Colors.level0Contrib
                case 1: return Colors.level1Contrib
                case 2: return Colors.level2Contrib
                case 3: return Colors.level3Contrib
                case 4: return Colors.level4Contrib
                default: return Colors.level0Contrib
              }
            }
            
            // Hover tooltip
            MouseArea {
              id: hoverArea
              anchors.fill: parent
              hoverEnabled: true
              
              onContainsMouseChanged: {
                if (containsMouse && day.date !== "" && day.count !== 0 && Config.dashContribToolTip) {
                  tooltipLoader.active = true
                  tooltipLoader.item.dayData = day
                  tooltipLoader.item.updatePosition(commitSquares)
                } else {
                  tooltipLoader.active = false
                }
              }
            }
          }
        }
      } // END OF CONTRIB GRAPH GRID


      // Header // bottom header =======================
      // RowLayout { 
      //   Layout.fillWidth: true
      //
      //   Text {
      //     text: `@${username}'s Contributions`
      //     color: Colors.accentColor
      //     font.pixelSize: 11
      //     font.bold: true
      //     Layout.alignment: Qt.AlignBottom  
      //     Layout.leftMargin: 19    
      //   }
      //
      //   Item {  // Spacer
      //     Layout.fillWidth: true
      //   }
      //
      //   Text {
      //     text: contributionData.length > 0 ? 
      //       `${contributionData.reduce((sum, d) => sum + d.count, 0)} total` : ""
      //     color: Colors.accent2Color
      //     font.pixelSize: 19
      //     font.bold: true
      //     Layout.rightMargin: 22
      //     Layout.alignment: Qt.AlignBottom
      //   }
      // }
      // // ==================================================


    }
  }

