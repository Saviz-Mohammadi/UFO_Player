import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts
import QtMultimedia

// Custom QML Files
import "./../components_ufo"
import "./../components_custom"

// Custom CPP Registered Types
import AppTheme 1.0
import MediaPlayer 1.0

UFO_Page {
    id: root

    title: qsTr("Player")
    contentSpacing: 20

    UFO_Button {
        text: "Open File"

        Layout.preferredHeight: 35
        Layout.preferredWidth: 120
    }

    Rectangle {
        id: rectangle_Background

        Layout.fillWidth: true
        Layout.preferredHeight: Math.round(root.height * 0.80) // Apparently, this does not result in biding because it takes this from stackLaytou fill.

        color: "black"

        // MediaPlayer {
        //     id: player
        //     source: "file://video.webm"
        //     videoOutput: videoOutput
        // }

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
                    }

                    UFO_Player_Button{
                        Layout.preferredWidth: 70
                        Layout.preferredHeight: 35

                        svg: "./../../icons/Google icons/play_arrow.svg"
                    }

                    UFO_Player_Button{
                        Layout.preferredWidth: 70
                        Layout.preferredHeight: 35

                        svg: "./../../icons/Google icons/fast_forward.svg"
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
                        text: "00:00:00"

                        color: "white"
                    }

                    UFO_Slider {
                        Layout.preferredWidth: parent.width * 0.75
                    }

                    Text {
                        text: "00:00:00"

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
