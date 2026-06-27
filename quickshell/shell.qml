import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

ShellRoot {
	id: root

	// Theme colors
	property color colBg: "#1a1b26"
	property color colFg: "#a9b1d6"
	property color colMuted: "#444b6a"
	property color colCyan: "#0db9d7"
	property color colPurple: "#ad8ee6"
	property color colRed: "#f7768e"
	property color colYellow: "#e0af68"
	property color colBlue: "#7aa2f7"
	property color colGreen: "#00ff00"

	// Font
	property string fontFamily: "JetBrainsMono Nerd Font"
	property int fontSize: 14

	property int minShowWorkspaces: 9
	property int maxShowWorkspaces: 20

	// System info properties
	// property string kernelVersion: "Linux"
	property int cpuUsage: 0
	property int memUsage: 0
	property int diskUsage: 0
	property int volumeLevel: 0
	property bool volumeMuted: false
	property bool bluetooth: false
	property int brightLevel: 0
	// property string activeWindow: "Window"
	property string musicPlaying: ""
	property string musicStatus: ""
	property string currentLayout: "Tile"
	property bool dropboxActive: false
	property string connectedNetwork: "disconnected"
	property bool isConnectedToNetwork: false
	property int batteryLevel: 0
	property bool batteryCharging: false

	// CPU tracking
	property var lastCpuIdle: 0
	property var lastCpuTotal: 0

	// // Kernel version
	// Process {
	// 	id: kernelProc
	// 	command: ["uname", "-r"]
	// 	stdout: SplitParser {
	// 		onRead: data => {
	// 			if (data) kernelVersion = data.trim()
	// 		}
	// 	}
	// 	Component.onCompleted: running = true
	// }

	// CPU usage
	Process {
		id: cpuProc
		command: ["sh", "-c", "head -1 /proc/stat"]
		stdout: SplitParser {
			onRead: data => {
				if (!data) return
				var parts = data.trim().split(/\s+/)
				var user = parseInt(parts[1]) || 0
				var nice = parseInt(parts[2]) || 0
				var system = parseInt(parts[3]) || 0
				var idle = parseInt(parts[4]) || 0
				var iowait = parseInt(parts[5]) || 0
				var irq = parseInt(parts[6]) || 0
				var softirq = parseInt(parts[7]) || 0

				var total = user + nice + system + idle + iowait + irq + softirq
				var idleTime = idle + iowait

				if (lastCpuTotal > 0) {
					var totalDiff = total - lastCpuTotal
					var idleDiff = idleTime - lastCpuIdle
					if (totalDiff > 0) {
						cpuUsage = Math.round(100 * (totalDiff - idleDiff) / totalDiff)
					}
				}
				lastCpuTotal = total
				lastCpuIdle = idleTime
			}
		}
		Component.onCompleted: running = true
	}

	// Memory usage
	Process {
		id: memProc
		command: ["sh", "-c", "free | grep Mem"]
		stdout: SplitParser {
			onRead: data => {
				if (!data) return
				var parts = data.trim().split(/\s+/)
				var total = parseInt(parts[1]) || 1
				var used = parseInt(parts[2]) || 0
				memUsage = Math.round(100 * used / total)
			}
		}
		Component.onCompleted: running = true
	}

	// Volume level (wpctl for PipeWire)
	Process {
		id: volProc1
		// command: ["sh", "-c", "[ $(pactl -f json get-sink-mute @DEFAULT_SINK@ | jq '.mute') == \"true\" ] && echo '0 0' || pactl -f json get-sink-volume @DEFAULT_SINK@ | jq -r '.[\"volume\"].[].[\"value_percent\"]' | tr '\n' ' ' | tr -d %"]
		command: ["sh", "-c", "pactl -f json get-sink-volume @DEFAULT_SINK@ | jq -r '.[\"volume\"].[].[\"value_percent\"]' | tr '\n' ' ' | tr -d %"]
		stdout: SplitParser {
			onRead: data => {
				if (!data) return
				var left = parseInt(data.trim().split(" ")[0])
				var right = parseInt(data.trim().split(" ")[1])
				volumeLevel = (left + right) / 2
			}
		}
		Component.onCompleted: running = true
	}
	Process {
		id: volProc2
		command: ["sh", "-c", "pactl -f json get-sink-mute @DEFAULT_SINK@ | jq '.mute'"]
		stdout: SplitParser {
			onRead: data => {
				if (!data) return
				volumeMuted = data.trim() == "true"
			}
		}
		Component.onCompleted: running = true
	}
	Process {
		id: bluetoothProc
		command: ["sh", "-c", "echo bt $(bluetoothctl info > /dev/null && echo connected)"]
		stdout: SplitParser {
			onRead: data => {
				if (data) {
					bluetooth = data.trim() == "bt connected"
				}
			}
		}
		Component.onCompleted: running = true
	}

	// Brightness level
	Process {
		id: brightProc
		command: ["sh", "-c", "echo $(brightnessctl g) $(brightnessctl m)"]
		stdout: SplitParser {
			onRead: data => {
				if (data && data.trim()) {
					var parts = data.trim().split(" ")
					brightLevel = parseInt(parts[0] / parts[1]  * 100)
				}
			}
		}
		Component.onCompleted: running = true
	}

	// Active window title
	// Process {
	// 	id: windowProc
	// 	command: ["sh", "-c", "hyprctl activewindow -j | jq -r '.title // empty'"]
	// 	stdout: SplitParser {
	// 		onRead: data => {
	// 			if (data && data.trim()) {
	// 				activeWindow = data.trim()
	// 			}
	// 		}
	// 	}
	// 	Component.onCompleted: running = true
	// }

	Process {
		id: musicProc1
		command: ["sh", "-c", "echo $(playerctl metadata title) - $(playerctl metadata artist)"]
		stdout: SplitParser {
			onRead: data => {
				if (data && data.trim()) {
					musicPlaying = data.trim()
				}
			}
		}
		Component.onCompleted: running = true
	}
	Process {
		id: musicProc2
		command: ["sh", "-c", "playerctl status || echo stopped"]
		stdout: SplitParser {
			onRead: data => {
				if (data && data.trim()) {
					musicStatus = data.trim()
				}
			}
		}
		Component.onCompleted: running = true
	}

	// Current layout (Hyprland: dwindle/master/floating)
	Process {
		id: layoutProc
		command: ["sh", "-c", "hyprctl activewindow -j | jq -r 'if .floating then \"Floating\" elif .fullscreen == 1 then \"Fullscreen\" else \"Tiled\" end'"]
		stdout: SplitParser {
			onRead: data => {
				if (data && data.trim()) {
					currentLayout = data.trim()
				}
			}
		}
		Component.onCompleted: running = true
	}

	Process {
		id: dropboxProc
		command: ["sh", "-c", "dropbox-cli running ; echo $?"]
		stdout: SplitParser {
			onRead: data => {
				if (data && data.trim()) {
					dropboxActive = data.trim() == "1"
				}
			}
		}
		Component.onCompleted: running = true
	}
	Process {
		id: networkProc
		command: ["sh", "-c", "if [[ -n $(iwctl station wlan0 show | grep network | tr -s ' ' '\n' | tail -1) ]]; then iwctl station wlan0 show | grep network | tr -s ' ' '\n' | tail -1 ;else echo 'disc' ;fi"]
		stdout: SplitParser {
			onRead: data => {
				if (data && data.trim()) {
					if (data != 'disc') {
						isConnectedToNetwork = true
						connectedNetwork = "  " + data.trim()
					} else {
						isConnectedToNetwork = false
						connectedNetwork = ""
					}
				}
			}
		}
		Component.onCompleted: running = true
	}
	Process {
		id: batteryProc1
		command: ["sh", "-c", "cat /sys/class/power_supply/BAT0/capacity"]
		stdout: SplitParser {
			onRead: data => {
				if(data && data.trim()) {
					batteryLevel = data.trim()
				}
			}
		}
		Component.onCompleted: running = true
	}
	Process {
		id: batteryProc2
		command: ["sh", "-c", "cat /sys/class/power_supply/BAT0/status"]
		stdout: SplitParser {
			onRead: data => {
				if(data && data.trim()) {
					batteryCharging = data.trim() == "Charging"
				}
			}
		}
		Component.onCompleted: running = true
	}
		

	// Slow timer for system stats
	Timer {
		interval: 2000
		running: true
		repeat: true
		onTriggered: {
			cpuProc.running = true
			memProc.running = true
			dropboxProc.running = true
			networkProc.running = true
			batteryProc1.running = true
			batteryProc2.running = true
			musicProc1.running = true
			musicProc2.running = true
			bluetoothProc.running = true
			volProc2.running = true
		}
	}
	Timer {
		interval: 200
		running: true
		repeat: true
		onTriggered: {
			volProc1.running = true
			brightProc.running = true
		}
	}

	// Event-based updates for window/layout (instant)
	Connections {
		target: Hyprland
		function onRawEvent(event) {
			// windowProc.running = true
			layoutProc.running = true
		}
	}

	// Backup timer for window/layout (catches edge cases)
	Timer {
		interval: 2000
		running: true
		repeat: true
		onTriggered: {
			// windowProc.running = true
			layoutProc.running = true
		}
	}

	Variants {
		model: Quickshell.screens

		PanelWindow {
			property var modelData
			screen: modelData

			anchors {
				top: true
				left: true
				right: true
			}

			implicitHeight: 30
			color: root.colBg

			margins {
				top: 0
				bottom: 0
				left: 0
				right: 0
			}
			Rectangle {
				anchors.fill: parent
				color: root.colBg
				RowLayout {
					anchors.fill: parent
					spacing: 0
					Item { width: 8 }
					Text {
						text: "󰣇 "
						color: root.colBlue
						font.pixelSize: root.fontSize + 10
						font.family: root.family
						font.bold: true
						MouseArea {
							anchors.fill: parent
							onClicked: Hyprland.dispatch("hl.dsp.exec_cmd(\"wofi --show drun\")")
						}
					}
					Item { width: 8 }
					Repeater {
						property int activeWorkspace: Hyprland.focusedWorkspace.id
						model: activeWorkspace <= root.minShowWorkspaces?root.minShowWorkspaces:(activeWorkspace > root.maxShowWorkspaces?root.maxShowWorkspaces:activeWorkspace)
						Rectangle {
							Layout.preferredWidth: 20
							Layout.preferredHeight: parent.height
							color: "transparent"
							property var workspace: Hyprland.workspaces.values.find(ws => ws.id === index + 1) ?? null
							property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)
							property bool hasWindows: workspace !== null
							Text {
								text: index + 1
								color: parent.isActive ? root.colCyan : (parent.hasWindows ? root.colCyan : root.colMuted)
								font.pixelSize: root.fontSize
								font.family: root.fontFamily
								font.bold: true
								anchors.centerIn: parent
							}
							Rectangle {
								visible: parent.isActive
								width: 20
								height: 3
								color: root.colPurple 
								anchors.horizontalCenter: parent.horizontalCenter
								anchors.bottom: parent.bottom
							}
							MouseArea {
								anchors.fill: parent
								onClicked: Hyprland.dispatch("hl.dsp.focus({ workspace = \"" + (index + 1) + "\"})")
							}
						}
					}
					Rectangle {
						Layout.preferredWidth: 20
						Layout.preferredHeight: parent.height
						color: "transparent"
						property int activeWorkspace: Hyprland.focusedWorkspace.id
						visible: activeWorkspace > root.maxShowWorkspaces
						Text {
							text: parent.activeWorkspace
							color: root.colCyan
							font.pixelSize: root.fontSize
							font.family: root.fontFamily
							font.bold: true
							anchors.centerIn: parent
						}
						Rectangle {
							width: 20
							height: 3
							color: root.colPurple 
							anchors.horizontalCenter: parent.horizontalCenter
							anchors.bottom: parent.bottom
						}
					}
					Rectangle { Layout.preferredWidth: 1; Layout.preferredHeight: 16;Layout.alignment: Qt.AlignVCenter;Layout.leftMargin: 0;Layout.rightMargin: 8;color: root.colMuted}
					Text {
						text: currentLayout
						color: root.colFg
						font.pixelSize: root.fontSize
						font.family: root.fontFamily
						font.bold: true
						Layout.leftMargin: 5
						Layout.rightMargin: 5
					}
					Rectangle { Layout.preferredWidth: 1; Layout.preferredHeight: 16;Layout.alignment: Qt.AlignVCenter;Layout.leftMargin: 0;Layout.rightMargin: 8;color: root.colMuted}
					// Text {
					// 	text: activeWindow
					// 	color: root.colPurple
					// 	font.pixelSize: root.fontSize
					// 	font.family: root.fontFamily
					// 	font.bold: true
					// 	Layout.fillWidth: true
					// 	Layout.leftMargin: 8
					// 	elide: Text.ElideRight
					// 	maximumLineCount: 1
					// }
					Text {
						text: (musicStatus == "Playing" || musicStatus == "Paused")?(musicStatus=="Playing"?"󰐊 ":"󰏤 ") + musicPlaying:""
						color: root.colPurple
						font.pixelSize: root.fontSize
						font.family: root.fontFamily
						font.bold: true
						Layout.fillWidth: true
						Layout.leftMargin: 8
						elide: Text.ElideRight
						maximumLineCount: 1
						MouseArea {
							anchors.fill: parent
							onClicked: Hyprland.dispatch("hl.dsp.exec_cmd(\"playerctl play-pause\")")
						}

					}
					Text {
						visible: dropboxActive
						text: ""
						color: root.colGreen
						font.pixelSize: root.fontSize
						font.family: root.fontFamily
						font.bold: true
						Layout.rightMargin: 8
					}
					Rectangle { visible: dropboxActive; Layout.preferredWidth: 1; Layout.preferredHeight: 16;Layout.alignment: Qt.AlignVCenter;Layout.leftMargin: 0;Layout.rightMargin: 8;color: root.colMuted}
					Text {
						text: "CPU: " + cpuUsage + "%"
						color: root.colYellow
						font.pixelSize: root.fontSize
						font.family: root.fontFamily
						font.bold: true
						Layout.rightMargin: 8
					}

					Rectangle { Layout.preferredWidth: 1; Layout.preferredHeight: 16;Layout.alignment: Qt.AlignVCenter;Layout.leftMargin: 0;Layout.rightMargin: 8;color: root.colMuted}
					Text {
						text: "Mem: " + memUsage + "%"
						color: root.colCyan
						font.pixelSize: root.fontSize
						font.family: root.fontFamily
						font.bold: true
						Layout.rightMargin: 8
					}
					Rectangle { Layout.preferredWidth: 1; Layout.preferredHeight: 16;Layout.alignment: Qt.AlignVCenter;Layout.leftMargin: 0;Layout.rightMargin: 8;color: root.colMuted}
					Text {
						// text: (bluetooth?"󰂯 ":"") + (volumeMuted == true?"󰖁":((volumeLevel > 0?(volumeLevel <= 33?"󰕿":"󰖀"):"󰕾") + ": " + volumeLevel + "%"))
						text: (bluetooth?"󰂯 ":"") + (volumeMuted == true?"󰖁":"Vol: " + volumeLevel + "%")
						color: root.colPurple
						font.pixelSize: root.fontSize
						font.family: root.fontFamily
						font.bold: true
						Layout.rightMargin: 8
					}
					Rectangle { Layout.preferredWidth: 1; Layout.preferredHeight: 16;Layout.alignment: Qt.AlignVCenter;Layout.leftMargin: 0;Layout.rightMargin: 8;color: root.colMuted}
					Text {
						text: "Bright: " + brightLevel + "%"
						color: root.colBlue
						font.pixelSize: root.fontSize
						font.family: root.fontFamily
						font.bold: true
						Layout.rightMargin: 8
					}
					Rectangle { Layout.preferredWidth: 1; Layout.preferredHeight: 16;Layout.alignment: Qt.AlignVCenter;Layout.leftMargin: 0;Layout.rightMargin: 8;color: root.colMuted}
					Text {
						text: "Batt: " + batteryLevel + "%" + (batteryCharging?" ":"")
						color: batteryLevel <= 20?root.colRed:root.colGreen
						font.pixelSize: root.fontSize
						font.family: root.fontFamily
						font.bold: true
						Layout.rightMargin: 8
					}
					Item { width: 8 }
					Rectangle { Layout.preferredWidth: 1; Layout.preferredHeight: 16;Layout.alignment: Qt.AlignVCenter;Layout.leftMargin: 0;Layout.rightMargin: 8;color: root.colMuted}
					Text {
						text: isConnectedToNetwork?connectedNetwork:"󰖪 Disconnected" 
						color: isConnectedToNetwork?root.colGreen:root.colRed
						font.pixelSize: root.fontSize
						font.family: root.fontFamily
						font.bold: true
						Layout.rightMargin: 8
						MouseArea {
							anchors.fill: parent
							onClicked: Hyprland.dispatch("hl.dsp.exec_cmd(\"kitty impala\", {float = true, size = { 1000, 600},center = true})")
						}
					}
					Rectangle { Layout.preferredWidth: 1; Layout.preferredHeight: 16;Layout.alignment: Qt.AlignVCenter;Layout.leftMargin: 0;Layout.rightMargin: 8;color: root.colMuted}
					Text {
						id: clockText
						text: Qt.formatDateTime(new Date(), "ddd, dd MMM - HH:mm")
						color: root.colCyan
						font.pixelSize: root.fontSize
						font.family: root.fontFamily
						font.bold: true
						Layout.rightMargin: 8
						Timer {
							interval: 1000
							running: true
							repeat: true
							onTriggered: clockText.text = Qt.formatDateTime(new Date(), "ddd, dd MMM - HH:mm")
						}
					}
				}
			}
		}
	}
}

