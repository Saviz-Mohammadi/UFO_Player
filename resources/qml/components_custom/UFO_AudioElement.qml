import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

// Custom CPP Registered Types
import AppTheme 1.0

Rectangle {
    id: root

    signal selected(url audioUrl)

    // In Qt, it is usually better to pass a url instead of string as path.
    // Don't ask why, that is just how Qt perfers to do it.
    property url audioFileUrl: ""
    property string audioFilePath: ""
    property string audioName: ""

    implicitHeight: 120
    implicitWidth: 120

    color: Qt.color(AppTheme.colors["UFO_MediaElement_Background"])

    border.width: 1
    border.color: "cornflowerblue"

    ColumnLayout {
        id: columnLayout_1

        anchors.fill: parent

        z: 1

        // Icon
        IconImage {
            id: iconImage_1

            source: "./../../icons/Google icons/music_note.svg"

            color: Qt.color(AppTheme.colors["UFO_MediaElement_Icon"])

            Layout.preferredWidth: 32
            Layout.preferredHeight: 32

            Layout.alignment: Qt.AlignHCenter
        }

        Text {
            id: text_1

            text: root.audioName
            Layout.fillWidth: true

            color: Qt.color(AppTheme.colors["UFO_MediaElement_Text"])

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
            root.selected(root.audioFileUrl)
        }
    }
}
