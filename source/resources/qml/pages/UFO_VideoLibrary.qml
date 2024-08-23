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

    signal selected(string filePath)

    title: qsTr("Video Library")
    contentSpacing: 20

    Component.onCompleted: {
        LibraryManager.obtainVideosUnderDirectory(StandardPaths.writableLocation(StandardPaths.MoviesLocation))
    }

    // [[ ---------------------------------------------------------------------- ]]
    // [[ ---------------------------------------------------------------------- ]]
    RowLayout {
        id: ufo_GroupBox_1

        Layout.fillWidth: true

        UFO_Button {
            text: "Open Folder"
        }

        UFO_Button {
            text: "Refresh"
        }
    }
    // [[ ---------------------------------------------------------------------- ]]
    // [[ ---------------------------------------------------------------------- ]]





    // Library
    // [[ ---------------------------------------------------------------------- ]]
    // [[ ---------------------------------------------------------------------- ]]
    Flow {
        Layout.fillWidth: true

        Repeater {
            model: LibraryManager.videoFilePaths

            delegate: UFO_VideoElement {

                filePath: modelData

                videoName: LibraryManager.fileNameFromPath(modelData)

                onSelected: function (path) {
                    root.selected(path)
                }
            }
        }
    }
    // [[ ---------------------------------------------------------------------- ]]
    // [[ ---------------------------------------------------------------------- ]]
}
