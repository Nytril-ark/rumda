import Quickshell.Io
import Quickshell
import Quickshell.Wayland
import Quickshell.Services.Pipewire
import Quickshell.Widgets
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import qs.light.config


Rectangle {
  property string username: Config.githubUsername  // obviously, if you aren't me, which you aren't, just change this into you github username
  property var contributionData: [] // this is fetched, but organised chronologically, so we need to create the following bit..
  property var gridData: []  // < which is this. gotta organise them into weeks

  // lil watcher to clear the data if the username is changed 
  onUsernameChanged: {
    contributionData = []
    gridData = []
    githubFetch.running = true
  }



  id: contribGraphRect
  implicitWidth: Math.ceil(gridData.length / 7) * (Config.commitSquareSize + 1)
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
          let yearStart = new Date(today.getFullYear(), 0, 1) 
          today.setHours(23, 59, 59, 999)
          contributionData = [] 


          contributionData = response.contributions.filter(day => {
            let dayDate = new Date(day.date)
            return dayDate >= yearStart && dayDate <= today
          })

          console.log(`Loaded ${contributionData.length} days of contributions`)
          
          organizeGridData()
        } catch (e) {
          console.error("Failed to parse GitHub data:", e)
        }
      }
    }
  }


  function organizeGridData() {
    gridData = []
    let organized = []
    
    // Find the starting day of week for the first contribution
    let firstDate = new Date(contributionData[0].date)
    let startDayOfWeek = firstDate.getDay()  // 0=Sunday, 1=Monday, etc.
    
    // Add empty cells before the first day to align the grid properly
    for (let i = 0; i < startDayOfWeek; i++) {
      organized.push({level: 0, count: 0, date: ""})
    }
    
    // Add all contribution data
    contributionData.forEach(day => {
      organized.push(day)
    })
    
    let lastRealIndex = organized.length - 1
    // Loop backwards to find last entry with a date
    while (lastRealIndex >= 0 && organized[lastRealIndex].date === "") {
      lastRealIndex--
    }
    
    // Trim array to only include up to last real day
    organized = organized.slice(0, lastRealIndex + 1)
    
    // reorganize into column-first order (each column is a week)
    let columnFirst = []
    let numWeeks = Math.ceil(organized.length / 7)
    
    // For each week
    for (let week = 0; week < numWeeks; week++) {
      // For each day of week (0-6)
      for (let day = 0; day < 7; day++) {
        let index = week * 7 + day
        if (index < organized.length) {
          columnFirst.push(organized[index])
        }
      }
    }    

    gridData = columnFirst
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
      anchors.leftMargin: 22
      anchors.rightMargin: 10
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
          Layout.leftMargin: 1
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
          Layout.rightMargin: 25
          Layout.alignment: Qt.AlignBottom
        }
      }
      // ======================================


      Grid {
        id: contributionGrid
        columns: 53 
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

