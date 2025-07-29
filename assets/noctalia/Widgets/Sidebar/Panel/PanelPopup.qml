import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import qs.Settings
import qs.Widgets.Sidebar.Config
import qs.Components

PanelWithOverlay {
    id: sidebarPopup

    function showAt() {
        sidebarPopupRect.showAt();
    }

    function hidePopup() {
        sidebarPopupRect.hidePopup();
    }

    function show() {
        sidebarPopupRect.showAt();
    }

    function dismiss() {
        sidebarPopupRect.hidePopup();
    }

    Rectangle {
        id: sidebarPopupRect
        implicitWidth: 500
        implicitHeight: 800
        visible: parent.visible
        color: "transparent"
        anchors.top: parent.top
        anchors.right: parent.right

        property real slideOffset: width
        property bool isAnimating: false

        function showAt() {
            if (!sidebarPopup.visible) {
                sidebarPopup.visible = true;
                forceActiveFocus();
                slideAnim.from = width;
                slideAnim.to = 0;
                slideAnim.running = true;
                if (weather)
                    weather.startWeatherFetch();
                if (systemWidget)
                    systemWidget.panelVisible = true;
                if (quickAccessWidget)
                    quickAccessWidget.panelVisible = true;
            }
        }

        function hidePopup() {
            if (sidebarPopupRect.settingsModal && sidebarPopupRect.settingsModal.visible) {
                sidebarPopupRect.settingsModal.visible = false;
            }
            if (sidebarPopupRect.wallpaperPanelModal && sidebarPopupRect.wallpaperPanelModal.visible) {
                sidebarPopupRect.wallpaperPanelModal.visible = false;
            }
            if (sidebarPopupRect.wifiPanelModal && sidebarPopupRect.wifiPanelModal.visible) {
                sidebarPopupRect.wifiPanelModal.visible = false;
            }
            if (sidebarPopupRect.bluetoothPanelModal && sidebarPopupRect.bluetoothPanelModal.visible) {
                sidebarPopupRect.bluetoothPanelModal.visible = false;
            }
            if (sidebarPopup.visible) {
                slideAnim.from = 0;
                slideAnim.to = width;
                slideAnim.running = true;
            }
        }

        NumberAnimation {
            id: slideAnim
            target: sidebarPopupRect
            property: "slideOffset"
            duration: 300
            easing.type: Easing.OutCubic

            onStopped: {
                if (sidebarPopupRect.slideOffset === sidebarPopupRect.width) {
                    sidebarPopup.visible = false;
                    if (weather)
                        weather.stopWeatherFetch();
                    if (systemWidget)
                        systemWidget.panelVisible = false;
                    if (quickAccessWidget)
                        quickAccessWidget.panelVisible = false;
                }
                sidebarPopupRect.isAnimating = false;
            }

            onStarted: {
                sidebarPopupRect.isAnimating = true;
            }
        }

        property int leftPadding: 20
        property int bottomPadding: 20

        // === SCALE WRAPPER BEGIN ===
		Item {
    		id: scaledWrapper
    		width: sidebarPopupRect.width
    		height: sidebarPopupRect.height
	    	anchors.top: sidebarPopupRect.top
    		anchors.right: sidebarPopupRect.right

    		scale: 0.9
    		transformOrigin: Item.TopRight
        
            Rectangle {
                id: mainRectangle
                width: sidebarPopupRect.width - sidebarPopupRect.leftPadding
                height: sidebarPopupRect.height - sidebarPopupRect.bottomPadding
                anchors.top: sidebarPopupRect.top
                x: sidebarPopupRect.leftPadding + sidebarPopupRect.slideOffset
                y: 0
                color: Theme.backgroundPrimary
                bottomLeftRadius: 20
                z: 0

                Behavior on x {
                    enabled: !sidebarPopupRect.isAnimating
                    NumberAnimation {
                        duration: 300
                        easing.type: Easing.OutCubic
                    }
                }
            }

            Item {
                anchors.fill: mainRectangle
                x: sidebarPopupRect.slideOffset

                Behavior on x {
                    enabled: !sidebarPopupRect.isAnimating
                    NumberAnimation {
                        duration: 300
                        easing.type: Easing.OutCubic
                    }
                }

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 20
                    spacing: 16

                    System {
                        id: systemWidget
                        Layout.alignment: Qt.AlignHCenter
                        z: 3
                    }

                    Weather {
                        id: weather
                        Layout.alignment: Qt.AlignHCenter
                        z: 2
                    }

                    RowLayout {
                        spacing: 12
                        Layout.fillWidth: true
                        Layout.alignment: Qt.AlignHCenter

                        Music {
                            z: 2
                        }

                        SystemMonitor {
                            id: systemMonitor
                            z: 2
                        }
                    }

                    RowLayout {
                        Layout.alignment: Qt.AlignLeft
                        Layout.preferredHeight: 80
                        spacing: 16
                        z: 3

                        PowerProfile {
                            Layout.alignment: Qt.AlignLeft
                            Layout.preferredHeight: 80
                        }

                        Rectangle {
                            Layout.preferredHeight: 80
                            Layout.preferredWidth: 140
                            Layout.fillWidth: false
                            color: Theme.surface
                            radius: 18

                            Row {
                                anchors.centerIn: parent
                                spacing: 20

                                Rectangle {
                                    id: wifiButton
                                    width: 36
                                    height: 36
                                    radius: 18
                                    border.color: Theme.accentPrimary
                                    border.width: 1
                                    color: wifiButtonArea.containsMouse ? Theme.accentPrimary : "transparent"

                                    Text {
                                        anchors.centerIn: parent
                                        text: "wifi"
                                        font.family: "Material Symbols Outlined"
                                        font.pixelSize: 22
                                        color: wifiButtonArea.containsMouse ? Theme.backgroundPrimary : Theme.accentPrimary
                                    }

                                    MouseArea {
                                        id: wifiButtonArea
                                        anchors.fill: parent
                                        hoverEnabled: true
                                        cursorShape: Qt.PointingHandCursor
                                        onClicked: wifiPanel.showAt()
                                    }

                                    StyledTooltip {
                                        text: "Wifi"
                                        targetItem: wifiButtonArea
                                        tooltipVisible: wifiButtonArea.containsMouse
                                    }
                                }

                                Rectangle {
                                    id: bluetoothButton
                                    width: 36
                                    height: 36
                                    radius: 18
                                    border.color: Theme.accentPrimary
                                    border.width: 1
                                    color: bluetoothButtonArea.containsMouse ? Theme.accentPrimary : "transparent"

                                    Text {
                                        anchors.centerIn: parent
                                        text: "bluetooth"
                                        font.family: "Material Symbols Outlined"
                                        font.pixelSize: 22
                                        color: bluetoothButtonArea.containsMouse ? Theme.backgroundPrimary : Theme.accentPrimary
                                    }

                                    MouseArea {
                                        id: bluetoothButtonArea
                                        anchors.fill: parent
                                        hoverEnabled: true
                                        cursorShape: Qt.PointingHandCursor
                                        onClicked: bluetoothPanel.showAt()
                                    }

                                    StyledTooltip {
                                        text: "Bluetooth"
                                        targetItem: bluetoothButtonArea
                                        tooltipVisible: bluetoothButtonArea.containsMouse
                                    }
                                }
                            }
                        }
                    }

                    WifiPanel {
                        id: wifiPanel
                        visible: false
                    }

                    BluetoothPanel {
                        id: bluetoothPanel
                        visible: false
                    }

                    Item {
                        Layout.fillHeight: true
                    }

                    QuickAccess {
                        id: quickAccessWidget
                        Layout.alignment: Qt.AlignHCenter
                        Layout.topMargin: -16
                        z: 2
                        isRecording: sidebarPopupRect.isRecording

                        onRecordingRequested: sidebarPopupRect.startRecording()
                        onStopRecordingRequested: sidebarPopupRect.stopRecording()
                        onRecordingStateMismatch: function (actualState) {
                            isRecording = actualState;
                            quickAccessWidget.isRecording = actualState;
                        }

                        onSettingsRequested: settingsModal.visible = true
                        onWallpaperRequested: wallpaperPanelModal.visible = true
                    }
                }
                Keys.onEscapePressed: sidebarPopupRect.hidePopup()
            }

            Corners {
                id: sidebarCornerLeft
                position: "bottomright"
                size: 1.1
                fillColor: Theme.backgroundPrimary
                anchors.top: mainRectangle.top
                offsetX: -447 + sidebarPopupRect.slideOffset
                offsetY: 0
                visible: Settings.settings.showCorners

                Behavior on offsetX {
                    enabled: !sidebarPopupRect.isAnimating
                    NumberAnimation {
                        duration: 300
                        easing.type: Easing.OutCubic
                    }
                }
            }

            Corners {
                id: sidebarCornerBottom
                position: "bottomright"
                size: 1.1
                fillColor: Theme.backgroundPrimary
                offsetX: 33 + sidebarPopupRect.slideOffset
                offsetY: 46
                visible: Settings.settings.showCorners

                Behavior on offsetX {
                    enabled: !sidebarPopupRect.isAnimating
                    NumberAnimation {
                        duration: 300
                        easing.type: Easing.OutCubic
                    }
                }
            }
        }
        // === SCALE WRAPPER END ===

        property bool isRecording: false

        function startRecording() {
            var currentDate = new Date();
            var hours = String(currentDate.getHours()).padStart(2, '0');
            var minutes = String(currentDate.getMinutes()).padStart(2, '0');
            var day = String(currentDate.getDate()).padStart(2, '0');
            var month = String(currentDate.getMonth() + 1).padStart(2, '0');
            var year = currentDate.getFullYear();

            var filename = hours + "-" + minutes + "-" + day + "-" + month + "-" + year + ".mp4";
            var videoPath = Settings.settings.videoPath;
            if (videoPath && !videoPath.endsWith("/")) {
                videoPath += "/";
            }
            var outputPath = videoPath + filename;
            var command = "gpu-screen-recorder -w portal -f 60 -a default_output -o " + outputPath;
            Quickshell.execDetached(["sh", "-c", command]);
            isRecording = true;
            quickAccessWidget.isRecording = true;
        }

        function stopRecording() {
            Quickshell.execDetached(["sh", "-c", "pkill -SIGINT -f 'gpu-screen-recorder.*portal'"]);
            var cleanupTimer = Qt.createQmlObject('import QtQuick; Timer { interval: 3000; running: true; repeat: false }', sidebarPopupRect);
            cleanupTimer.triggered.connect(function () {
                Quickshell.execDetached(["sh", "-c", "pkill -9 -f 'gpu-screen-recorder.*portal' 2>/dev/null || true"]);
                cleanupTimer.destroy();
            });
            isRecording = false;
            quickAccessWidget.isRecording = false;
        }

        Component.onDestruction: {
            if (isRecording) {
                stopRecording();
            }
        }

        property alias settingsModal: settingsModal
        property alias wallpaperPanelModal: wallpaperPanelModal
        property alias wifiPanelModal: wifiPanel.panel
        property alias bluetoothPanelModal: bluetoothPanel.panel

        SettingsModal { id: settingsModal }

        WallpaperPanel {
            id: wallpaperPanelModal
            visible: false
            Component.onCompleted: {
                if (parent) {
                    wallpaperPanelModal.anchors.top = parent.top;
                    wallpaperPanelModal.anchors.right = parent.right;
                }
            }
        }
    }
}

