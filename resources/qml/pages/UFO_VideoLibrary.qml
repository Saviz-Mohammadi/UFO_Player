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

    signal selected(url videoUrl)

    title: qsTr("Video Library")
    contentSpacing: 20

    Component.onCompleted: {
        LibraryManager.obtainVideosUnderDirectory(StandardPaths.writableLocation(StandardPaths.MoviesLocation))
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
            model: LibraryManager.videoFilePaths

            delegate: UFO_VideoElement {

                // Binding data to "UFO_VideoElement"
                videoFileUrl: LibraryManager.urlFromPath(modelData)
                videoFilePath: modelData
                videoName: LibraryManager.fileNameFromPath(modelData)

                // Emit signal.
                onSelected: function (videoUrl) {
                    root.selected(videoUrl)
                }
            }
        }
    }
    // [[ ---------------------------------------------------------------------- ]]
    // [[ ---------------------------------------------------------------------- ]]
}
