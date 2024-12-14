import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

// Custom CPP Registered Types
import AppTheme 1.0

Slider {
    id: root

    value: 0.5

    background: Rectangle {
        x: root.leftPadding
        y: root.topPadding + root.availableHeight / 2 - height / 2

        implicitWidth: 200
        implicitHeight: 4

        width: root.availableWidth
        height: implicitHeight

        radius: 2
        color: "#bdbebf"

        Rectangle {
            width: root.visualPosition * parent.width
            height: parent.height

            color: Qt.color(AppTheme.colors["UFO_Slider_Background_Filled"])
            radius: 2
        }
    }

    handle: Rectangle {
        x: root.leftPadding + root.visualPosition * (root.availableWidth - width)
        y: root.topPadding + root.availableHeight / 2 - height / 2

        implicitWidth: 16
        implicitHeight: 16

        radius: 13
        color: root.pressed ? "#f0f0f0" : "#f6f6f6"
        border.color: "#bdbebf"
    }
}
