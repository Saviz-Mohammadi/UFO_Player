import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

// Custom CPP Registered Types
import AppTheme 1.0

Rectangle {
    id: root

    signal selected(url audioUrl)

    property url audioFileUrl: ""
    property string audioFilePath: ""
    property string audioName: ""

    implicitHeight: 120
    implicitWidth: 120

    color: Qt.color(AppTheme.colors["UFO_MediaElement_Background"])

    border.width: 1
    border.color: "cornflowerblue"

    ColumnLayout {
        anchors.fill: parent

        z: 1

        IconImage {
            Layout.preferredWidth: 32
            Layout.preferredHeight: 32

            source: "./../../icons/Google icons/music_note.svg"
            color: Qt.color(AppTheme.colors["UFO_MediaElement_Icon"])
            Layout.alignment: Qt.AlignHCenter
        }

        Text {
            Layout.fillWidth: true

            Layout.margins: 10

            text: root.audioName
            color: Qt.color(AppTheme.colors["UFO_MediaElement_Text"])
            horizontalAlignment: Text.AlignHCenter
            elide: Text.ElideRight
        }
    }

    MouseArea {
        anchors.fill: parent

        z: 2

        onClicked: {
            root.selected(root.audioFileUrl)
        }
    }
}
