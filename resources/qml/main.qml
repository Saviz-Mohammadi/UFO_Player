import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

// Custom QML Files
import "components_ufo"
import "components_custom"
import "pages"

// Custom CPP Registered Types
import AppTheme 1.0

ApplicationWindow {
    id: rootWindow

    width: 800
    height: 600

    visible: true
    title: qsTr("UFO_Player")

    menuBar: UFO_MenuBar {
        spacing: 0

        UFO_Menu {
            topMargin: 0
            leftMargin: 0

            title: qsTr("File")

            UFO_MenuItem {
                leftPadding: 10
                rightPadding: 10

                text: qsTr("Quit")

                onTriggered: {
                    Qt.quit()
                }
            }
        }

        UFO_Menu {
            topMargin: 0
            leftMargin: 0

            title: qsTr("View")

            UFO_MenuItem {
                leftPadding: 10
                rightPadding: 10

                text: qsTr("Media Player Page")

                onTriggered: {
                    stackLayout.currentIndex = ufo_Player.StackLayout.index

                    ufo_SideBar_Main.checkTabButton("Player Page")
                }
            }

            UFO_MenuItem {
                leftPadding: 10
                rightPadding: 10

                text: qsTr("Video Library Page")

                onTriggered: {
                    stackLayout.currentIndex = ufo_VideoLibrary.StackLayout.index

                    ufo_SideBar_Main.checkTabButton("Video Library Page")
                }
            }

            UFO_MenuItem {
                leftPadding: 10
                rightPadding: 10

                text: qsTr("Audio Library Page")

                onTriggered: {
                    stackLayout.currentIndex = ufo_AudioLibrary.StackLayout.index

                    ufo_SideBar_Main.checkTabButton("Audio Library Page")
                }
            }

            UFO_MenuItem {
                leftPadding: 10
                rightPadding: 10

                text: qsTr("Settings Page")

                onTriggered: {
                    stackLayout.currentIndex = ufo_Settings.StackLayout.index

                    ufo_SideBar_Main.checkTabButton("Settings Page")
                }
            }

            UFO_MenuItem {
                leftPadding: 10
                rightPadding: 10

                text: qsTr("About Page")

                onTriggered: {
                    stackLayout.currentIndex = ufo_About.StackLayout.index

                    ufo_SideBar_Main.checkTabButton("About Page")
                }
            }
        }

        UFO_Menu {
            topMargin: 0
            leftMargin: 0

            title: qsTr("Help")

            UFO_MenuItem {
                leftPadding: 10
                rightPadding: 10

                text: qsTr("About UFO_Player")

                onTriggered: {
                    stackLayout.currentIndex = ufo_About.StackLayout.index

                    ufo_SideBar_Main.checkTabButton("About Page")
                }
            }
        }
    }

    footer: UFO_StatusBar {
        id: ufo_StatusBar

        text: qsTr("Application ready...")
    }



    Connections {
        target: ufo_VideoLibrary

        function onSelected(videoUrl) {
            console.log(videoUrl)

            // TODO (Saviz): Make sure you pass url instead of string
            ufo_SideBar_Main.tabChanged("Player Page")
            ufo_SideBar_Main.checkTabButton("Player Page")
            ufo_Player.onItemSelected(videoUrl)
        }
    }

    Connections {
        target: ufo_AudioLibrary

        function onSelected(audioUrl) {
            console.log(audioUrl)

            // TODO (Saviz): Make sure you pass url instead of string
            ufo_SideBar_Main.tabChanged("Player Page")
            ufo_SideBar_Main.checkTabButton("Player Page")
            ufo_Player.onItemSelected(audioUrl)
        }
    }

    UFO_SplitView {
        anchors.fill: parent

        UFO_SideBar {
            id: ufo_SideBar_Main

            // NOTE (SAVIZ): Initial startup width for the main SideBar.
            Layout.preferredWidth: 200
            Layout.fillHeight: true
        }

        StackLayout {
            id: stackLayout

            Layout.fillWidth: true
            Layout.fillHeight: true

            UFO_Player {
                id: ufo_Player

                Layout.fillWidth: true
                Layout.fillHeight: true
            }

            UFO_VideoLibrary {
                id: ufo_VideoLibrary

                Layout.fillWidth: true
                Layout.fillHeight: true
            }

            UFO_AudioLibrary {
                id: ufo_AudioLibrary

                Layout.fillWidth: true
                Layout.fillHeight: true
            }

            UFO_Settings {
                id: ufo_Settings

                Layout.fillWidth: true
                Layout.fillHeight: true
            }

            UFO_About {
                id: ufo_About

                Layout.fillWidth: true
                Layout.fillHeight: true
            }

            Connections {
                target: ufo_SideBar_Main

                function onTabChanged(pageName) {

                    // TODO (SAVIZ): I like to replace these with an enum, but currently I don't know how in QML.
                    switch (pageName) {
                        case "Player Page":
                            stackLayout.currentIndex = ufo_Player.StackLayout.index
                            break
                        case "Video Library Page":
                            stackLayout.currentIndex = ufo_VideoLibrary.StackLayout.index
                            break
                        case "Audio Library Page":
                            stackLayout.currentIndex = ufo_AudioLibrary.StackLayout.index
                            break
                        case "Settings Page":
                            stackLayout.currentIndex = ufo_Settings.StackLayout.index
                            break
                        case "About Page":
                            stackLayout.currentIndex = ufo_About.StackLayout.index
                            break
                        default:
                            stackLayout.currentIndex = -1
                    }
                }
            }

            Component.onCompleted: {
                stackLayout.currentIndex = ufo_About.StackLayout.index
            }
        }
    }
}
