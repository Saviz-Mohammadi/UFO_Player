import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

// Custom CPP Registered Types
import AppTheme 1.0

Rectangle {
    id: root

    signal selected(url videoUrl)

    // In Qt, it is usually better to pass a url instead of string as path.
    // Don't ask why, that is just how Qt perfers to do it.
    property url videoFileUrl: ""
    property string videoFilePath: ""
    property string videoName: ""

    implicitHeight: 120
    implicitWidth: 120

    border.width: 2
    border.color: "cornflowerblue"

    ColumnLayout {
        id: columnLayout_1

        anchors.fill: parent

        z: 1

        // Icon
        IconImage {
            id: iconImage_1

            source: "./../../icons/Google icons/movie.svg"

            Layout.preferredWidth: 32
            Layout.preferredHeight: 32

            Layout.alignment: Qt.AlignHCenter
        }

        Text {
            id: text_1

            text: root.videoName
            Layout.fillWidth: true

            Layout.margins: 10
            horizontalAlignment: Text.AlignHCenter
            elide: Text.ElideRight
        }
    }

    MouseArea {
        id: mouseArea_1

        anchors.fill: parent

        z: 2

        // Emit signal.
        onClicked: {
            root.selected(root.videoFileUrl)
        }
    }
}
