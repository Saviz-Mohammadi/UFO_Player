import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts
import QtCore // this is the new standardpaths location make sure to change all to fit this the lab.platform one is deprecated

// Custom QML Files
import "./../components_ufo"
import "./../components_custom"

// Custom CPP Registered Types
import AppTheme 1.0
import LibraryManager 1.0

UFO_Page {
    id: root

    signal selected(url audioUrl)

    title: qsTr("Audio Library")
    contentSpacing: 20

    Component.onCompleted: {
        LibraryManager.obtainAudiosUnderDirectory(StandardPaths.writableLocation(StandardPaths.MusicLocation))
    }

    // Interface
    // [[ ---------------------------------------------------------------------- ]]
    // [[ ---------------------------------------------------------------------- ]]
    RowLayout {
        id: ufo_GroupBox_1

        Layout.fillWidth: true

        UFO_Button {
            text: "Refresh"

            svg: "./../../icons/Google icons/refresh.svg"

            // TODO (Saviz): call "LibraryManager.obtainVideosUnderDirectory()" to refresh.
        }
    }
    // [[ ---------------------------------------------------------------------- ]]
    // [[ ---------------------------------------------------------------------- ]]





    // Library view
    // [[ ---------------------------------------------------------------------- ]]
    // [[ ---------------------------------------------------------------------- ]]
    Flow {
        Layout.fillWidth: true

        spacing: 10

        Repeater {
            model: LibraryManager.audioFilePaths

            delegate: UFO_AudioElement {

                // Binding data to "UFO_AudioElement"
                audioFileUrl: LibraryManager.urlFromPath(modelData)
                audioFilePath: modelData
                audioName: LibraryManager.fileNameFromPath(modelData)

                // Emit signal.
                onSelected: function (audioUrl) {
                    root.selected(audioUrl)
                }
            }
        }
    }
    // [[ ---------------------------------------------------------------------- ]]
    // [[ ---------------------------------------------------------------------- ]]
}
