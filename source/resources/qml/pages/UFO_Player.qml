import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

// Custom QML Files
import "./../components_ufo"

// Custom CPP Registered Types
import AppTheme 1.0

UFO_Page {
    id: root

    title: qsTr("Player")
    contentSpacing: 20

    UFO_Button {
        text: "Open File"

        Layout.preferredHeight: 35
        Layout.preferredWidth: 120
    }

    // Put media player here
}
