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
    id: root

    width: 800
    height: 600

    visible: true
    title: qsTr("UFO_QML")

    menuBar: UFO_MenuBar {
        id: ufo_MenuBar_1

        spacing: 0

        // File
        // [[ ---------------------------------------------------------------------- ]]
        // [[ ---------------------------------------------------------------------- ]]
        UFO_Menu {
            id: ufo_Menu_1

            title: qsTr("File")
            topMargin: 0
            leftMargin: 0

            UFO_MenuItem {
                id: ufo_MenuItem_1

                leftPadding: 10
                rightPadding: 10
                text: qsTr("Quit")

                onTriggered: {
                    Qt.quit()
                }
            }
        }
        // [[ ---------------------------------------------------------------------- ]]
        // [[ ---------------------------------------------------------------------- ]]
        // File

        // View
        // [[ ---------------------------------------------------------------------- ]]
        // [[ ---------------------------------------------------------------------- ]]
        UFO_Menu {
            id: ufo_Menu_2

            title: qsTr("View")
            topMargin: 0
            leftMargin: 0

            // TODO (Saviz): The problem with this is that the checked state of sidebar does not change
            // Make sure to invoke signal from sidebar dircetly instead.
            UFO_MenuItem {
                id: ufo_MenuItem_2

                leftPadding: 10
                rightPadding: 10
                text: qsTr("Settings page")

                onTriggered: {
                    stackLayout_1.currentIndex = ufo_Settings.StackLayout.index
                }
            }

            UFO_MenuItem {
                id: ufo_MenuItem_3

                leftPadding: 10
                rightPadding: 10
                text: qsTr("About page")

                onTriggered: {
                    stackLayout_1.currentIndex = ufo_About.StackLayout.index
                }
            }
        }
        // [[ ---------------------------------------------------------------------- ]]
        // [[ ---------------------------------------------------------------------- ]]
        // View

        // Help
        // [[ ---------------------------------------------------------------------- ]]
        // [[ ---------------------------------------------------------------------- ]]
        UFO_Menu {
            id: ufo_Menu_3

            title: qsTr("Help")
            topMargin: 0
            leftMargin: 0

            UFO_MenuItem {
                id: ufo_MenuItem_6

                leftPadding: 10
                rightPadding: 10
                text: qsTr("About UFO_QML")

                onTriggered: {
                    stackLayout_1.currentIndex = ufo_About.StackLayout.index
                }
            }
        }
        // [[ ---------------------------------------------------------------------- ]]
        // [[ ---------------------------------------------------------------------- ]]
        // Help
    }

    footer: UFO_StatusBar {
        id: ufo_StatusBar_1

        text: qsTr("Status Bar")
    }

    SplitView {
        id: splitView_1

        anchors.fill: parent

        UFO_SideBar {
            id: ufo_SideBar_1

            Layout.preferredWidth: 200 // This will give an initial startup width to the SideBar.
            Layout.fillHeight: true
        }

        // TODO (Saviz): I think the best way to deal with this, is to have a function in StackLayout that can be connected to signals
        // and is in charge of changing the page. This is the cleanest architecuter since StackLayout is the actual element that manages the pages
        // So, it sohuld be responsible for changing them. Others can tell it to change the page by calling its funciton.
        StackLayout {
            id: stackLayout_1

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
                target: ufo_SideBar_1

                function onTabChanged(pageName) {
                    switch (pageName) {

                    case "MediaPlayer page":
                        stackLayout_1.currentIndex = ufo_Player.StackLayout.index
                        break
                    case "VideoLibrary page":
                        stackLayout_1.currentIndex = ufo_VideoLibrary.StackLayout.index
                        break
                    case "Settings page":
                        stackLayout_1.currentIndex = ufo_Settings.StackLayout.index
                        break
                    case "About page":
                        stackLayout_1.currentIndex = ufo_About.StackLayout.index
                        break
                    default:
                        stackLayout_1.currentIndex = -1
                    }
                }
            }

            Connections {
                target: ufo_VideoLibrary

                function onSelected(videoUrl) {
                    console.log(videoUrl)

                    // TODO (Saviz): This somehow works. I guess the conversion between string and qurl is automatic.
                    // Still... make sure to change it to pass around qurl instead just to be safe.
                    ufo_SideBar_1.tabChanged("MediaPlayer page")
                    ufo_SideBar_1.btn_Player.checked = true
                    ufo_Player.onItemSelected(videoUrl)
                }
            }

            Component.onCompleted: {
                stackLayout_1.currentIndex = ufo_About.StackLayout.index
            }
        }
    }
}
