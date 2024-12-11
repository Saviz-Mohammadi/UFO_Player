import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts
import QtMultimedia

// Custom QML Files
import "./../components_ufo"

// Custom CPP Registered Types
import AppTheme 1.0
import CustomMediaPlayer 1.0

Window {
    id: root

    //signal closed()

    flags: Qt.Window | Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint
    modality: Qt.ApplicationModal
    color: "transparent"

    Component.onCompleted: {
        CustomMediaPlayer.pause()
        CustomMediaPlayer.videoSurface = videoOutput
        CustomMediaPlayer.play()
        showFullScreen()
    }

    Rectangle {
        id: rectangle_Background

        anchors.fill: parent

        color: "black"

        Keys.onPressed: (event)=> {
            if (event.key === Qt.Key_Escape) {
                event.accepted = true;  // Prevent other items from handling this event
                root.close()
            }
        }

        MouseArea {
            anchors.fill: parent

            hoverEnabled: true

            onEntered: {
                columnLayout_InterfaceContainer.visible = false
            }
        }

        VideoOutput {
            id: videoOutput

            anchors.fill: parent

            ColumnLayout {

                anchors.fill: parent
                anchors.margins: 10

                Item {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                }

                MouseArea {
                    Layout.fillWidth: true
                    Layout.preferredHeight: columnLayout_InterfaceContainer.height

                    hoverEnabled: true

                    onEntered: {
                        columnLayout_InterfaceContainer.visible = true
                    }

                    ColumnLayout{
                        id: columnLayout_InterfaceContainer

                        anchors.left: parent.left
                        anchors.right: parent.right

                        visible: false

                        // Buttons
                        RowLayout {

                            Layout.fillWidth: true

                            Item {
                                Layout.fillWidth: true
                            }

                            UFO_Player_Button{
                                Layout.preferredWidth: 70
                                Layout.preferredHeight: 35

                                svg: "./../../icons/Google icons/repeat.svg"
                                checkable: true
                                checked: false

                                // TODO (Saviz): this is problematic, because when you switch to full screen mode, the state of checked becomes lost because
                                // you are creating a new element. I think it may be better to create something like isLooping() bool in C++ instead.
                                onCheckedChanged: {
                                    if(checked)
                                    {
                                        CustomMediaPlayer.setLoopCount(CustomMediaPlayer.Loop.Infinite)
                                        return
                                    }

                                    CustomMediaPlayer.setLoopCount(CustomMediaPlayer.Loop.Once)
                                }
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

                            // TODO (Saviz): Try and replace the model with an Enum.
                            UFO_ComboBox{
                                Layout.preferredWidth: 80
                                Layout.preferredHeight: 35

                                model: ["x 0.5", "x 1.0", "x 1.25", "x 2.0"]
                                currentIndex: 1

                                onActivated: {
                                    if(currentIndex === 0)
                                    {
                                        CustomMediaPlayer.setPlayBackRate(0.5)
                                        return
                                    }

                                    if(currentIndex === 1)
                                    {
                                        CustomMediaPlayer.setPlayBackRate(1.0)
                                        return
                                    }

                                    if(currentIndex === 2)
                                    {
                                        CustomMediaPlayer.setPlayBackRate(1.25)
                                        return
                                    }

                                    if(currentIndex === 3)
                                    {
                                        CustomMediaPlayer.setPlayBackRate(2.0)
                                        return
                                    }
                                }
                            }

                            UFO_Player_Button{
                                Layout.preferredWidth: 70
                                Layout.preferredHeight: 35

                                svg: "./../../icons/Google icons/close_fullscreen.svg"

                                onClicked: {
                                    root.close();
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
                                Layout.fillWidth: true

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

                            UFO_Slider {
                                Layout.preferredWidth: parent.width * 0.15

                                from: 0.0
                                to: 1.0
                                value: CustomMediaPlayer.volume

                                onMoved: {
                                    CustomMediaPlayer.volume = value
                                }
                            }

                            Item {
                                Layout.fillWidth: true
                            }
                        }
                    }
                }
            }
        }
    }
}
