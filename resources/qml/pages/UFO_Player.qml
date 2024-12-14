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

    title: qsTr("Media Player")
    contentSpacing: 20

    Component.onCompleted: {
        CustomMediaPlayer.videoSurface = videoOutput
    }

    function onFullScreenClosed()
    {
        CustomMediaPlayer.pause()
        CustomMediaPlayer.videoSurface = videoOutput
        CustomMediaPlayer.play()
    }

    function onItemSelected(url)
    {
        CustomMediaPlayer.pause()
        CustomMediaPlayer.setMediaFile(url)
        CustomMediaPlayer.play()
    }

    FileDialog {
        id: fileDialog

        title: "Open File"
        fileMode: FileDialog.OpenFile
        nameFilters: ["Video Files (*.avi *.mp4 *.mov *.mkv *.flv *.wmv)", "Audio Files(*.mp3 *.wav)", "All Files (*)"]
        currentFolder: StandardPaths.writableLocation(StandardPaths.MoviesLocation) // Don't ask...

        onAccepted: {
            console.log("Selected file path:", fileDialog.selectedFile)

            CustomMediaPlayer.setMediaFile(fileDialog.selectedFile)
            CustomMediaPlayer.play()
        }
    }

    UFO_Button {
        Layout.preferredWidth: 120
        Layout.preferredHeight: 35

        text: "Open File"
        svg: "./../../icons/Google icons/file_open.svg"

        onClicked: {
            fileDialog.open()
        }
    }

    Rectangle {
        Layout.fillWidth: true
        Layout.preferredHeight: Math.round(root.height * 0.80) // Apparently, this does not result in biding because it takes this from stackLaytou fill.

        color: "black"

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

                                svg: "./../../icons/Google icons/fullscreen.svg"

                                onClicked: {
                                    var component = Qt.createComponent("./../components_custom/UFO_FullScreen.qml");
                                    var fullScreen = component.createObject(root);

                                    fullScreen.closing.connect(onFullScreenClosed)

                                    return;
                                }
                            }

                            Item {
                                Layout.fillWidth: true
                            }
                        }

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

                                onMoved: {
                                    CustomMediaPlayer.setPosition(value)
                                }
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
