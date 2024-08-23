import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

// Custom CPP Registered Types
import AppTheme 1.0

Button {
    id: root

    property alias svg: iconImage_1.source
    property int svgWidth: 24
    property int svgHeight: 24
    property int borderRadius: 0

    implicitWidth: 120
    implicitHeight: 35

    opacity: enabled ? 1.0 : 0.5
    hoverEnabled: enabled ? true : false

    contentItem: RowLayout {
        id: rowLayout_1

        IconImage {
            id: iconImage_1

            Layout.preferredWidth: svgWidth
            Layout.preferredHeight: svgHeight

            source: ""
            Layout.leftMargin: 0
            Layout.rightMargin: 0
            Layout.alignment: Qt.AlignHCenter

            verticalAlignment: Image.AlignVCenter

            color: {
                if (root.checked) {
                    Qt.color(AppTheme.colors["UFO_Button_Icon_Checked"])
                } else if (root.hovered) {
                    Qt.color(AppTheme.colors["UFO_Button_Icon_Hovered"])
                } else {
                    Qt.color(AppTheme.colors["UFO_Button_Icon_Normal"])
                }
            }
        }
    }

    background: Rectangle {
        id: rectangle_1

        radius: borderRadius

        color: {
            if (root.checked) {
                Qt.color(AppTheme.colors["UFO_Button_Background_Checked"])
            } else if (root.hovered) {
                Qt.color(AppTheme.colors["UFO_Button_Background_Hovered"])
            } else {
                Qt.color(AppTheme.colors["UFO_Button_Background_Normal"])
            }
        }
    }
}
