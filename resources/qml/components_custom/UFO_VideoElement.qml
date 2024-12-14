import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

// Custom CPP Registered Types
import AppTheme 1.0

Rectangle {
    id: root

    signal selected(url videoUrl)

    property url videoFileUrl: ""
    property string videoFilePath: ""
    property string videoName: ""

    implicitHeight: 120
    implicitWidth: 120

    color: Qt.color(AppTheme.colors["UFO_MediaElement_Background"])

    border.width: 2
    border.color: "cornflowerblue"

    ColumnLayout {
        anchors.fill: parent

        z: 1

        IconImage {
            Layout.preferredWidth: 32
            Layout.preferredHeight: 32

            source: "./../../icons/Google icons/movie.svg"
            color: Qt.color(AppTheme.colors["UFO_MediaElement_Icon"])
            Layout.alignment: Qt.AlignHCenter
        }

        Text {
            Layout.fillWidth: true

            Layout.margins: 10

            text: root.videoName
            color: Qt.color(AppTheme.colors["UFO_MediaElement_Text"])
            horizontalAlignment: Text.AlignHCenter
            elide: Text.ElideRight
        }
    }

    MouseArea {
        anchors.fill: parent

        z: 2

        onClicked: {
            root.selected(root.videoFileUrl)
        }
    }
}
