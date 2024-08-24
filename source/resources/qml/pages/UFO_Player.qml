import QtCore
import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts
import QtMultimedia
import QtQuick.Dialogs

// Custom QML Files
import "./../components_ufo"
import "./../components_custom"

// Custom CPP Registered Types
import AppTheme 1.0
import CustomMediaPlayer 1.0

UFO_Page {
    id: root

    title: qsTr("Player")
    contentSpacing: 20

    Component.onCompleted: {
        CustomMediaPlayer.videoSurface = videoOutput
    }

    FileDialog {
        id: fileDialog

        title: "Open File"
        fileMode: FileDialog.OpenFile
        nameFilters: ["Video Files (*.avi *.mp4 *.mov *.mkv *.flv *.wmv)"]
        currentFolder: StandardPaths.writableLocation(StandardPaths.MoviesLocation) // Don't ask...

        onAccepted: {
            // Handle the selected file path
            console.log("Selected file path:", fileDialog.selectedFile)
            CustomMediaPlayer.setMediaFile(fileDialog.selectedFile)
            CustomMediaPlayer.play()
        }
    }

    UFO_Button {
        text: "Open File"

        Layout.preferredHeight: 35
        Layout.preferredWidth: 120

        onClicked: {
            fileDialog.open()
        }
    }

    Rectangle {
        id: rectangle_Background

        Layout.fillWidth: true
        Layout.preferredHeight: Math.round(root.height * 0.80) // Apparently, this does not result in biding because it takes this from stackLaytou fill.

        color: "black"

        VideoOutput {
            id: videoOutput

            anchors.fill: parent

            ColumnLayout {

                anchors.fill: parent
                anchors.margins: 10

                Item {
                    Layout.fillHeight: true
                }

                // Buttons
                RowLayout {

                    Layout.fillWidth: true

                    Item {
                        Layout.fillWidth: true
                    }

                    UFO_Player_Button{
                        Layout.preferredWidth: 70
                        Layout.preferredHeight: 35

                        svg: "./../../icons/Google icons/fast_rewind.svg"

                        onClicked: {
                            CustomMediaPlayer.rewind()
                        }
                    }

                    UFO_Player_Button{
                        Layout.preferredWidth: 70
                        Layout.preferredHeight: 35

                        svg: CustomMediaPlayer.isPlaying ? "./../../icons/Google icons/pause.svg" : "./../../icons/Google icons/play_arrow.svg"

                        onClicked: {
                            if(CustomMediaPlayer.isPlaying)
                            {
                                CustomMediaPlayer.pause()
                                return;
                            }

                            CustomMediaPlayer.play()
                        }
                    }

                    UFO_Player_Button{
                        Layout.preferredWidth: 70
                        Layout.preferredHeight: 35

                        svg: "./../../icons/Google icons/fast_forward.svg"

                        onClicked: {
                            CustomMediaPlayer.forward()
                        }
                    }

                    Item {
                        Layout.fillWidth: true
                    }
                }

                // Slider
                RowLayout {

                    Layout.fillWidth: true

                    Item {
                        Layout.fillWidth: true
                    }

                    Text {
                        text: CustomMediaPlayer.position

                        color: "white"
                    }

                    UFO_Slider {
                        Layout.preferredWidth: parent.width * 0.75

                        from: 0
                        to: CustomMediaPlayer.maxValue
                        value: CustomMediaPlayer.currentValue
                    }

                    Text {
                        text: CustomMediaPlayer.duration

                        color: "white"
                    }

                    Item {
                        Layout.fillWidth: true
                    }
                }
            }
        }
    }
}
