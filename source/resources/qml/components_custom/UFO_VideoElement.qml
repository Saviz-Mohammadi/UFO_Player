import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

// Custom CPP Registered Types
import AppTheme 1.0

Rectangle {
    id: root

    signal selected(string path)

    // This will store the path to the local file
    property string filePath: ""
    property string videoName: ""

    implicitHeight: 200
    implicitWidth: 200

    border.width: 2
    border.color: "cornflowerblue"

    ColumnLayout {
        anchors.fill: parent

        z: 1

        // Icon
        IconImage {
            source: "./../../icons/Google icons/movie.svg"

            Layout.preferredWidth: 32
            Layout.preferredHeight: 32

            Layout.alignment: Qt.AlignHCenter
        }

        Text {
            text: root.videoName

            Layout.alignment: Qt.AlignHCenter
        }
    }

    MouseArea {
        anchors.fill: parent

        z: 2

        // Emit selected() signal and pass in filePath
        onClicked: {
            root.selected(root.filePath)
        }
    }
}
