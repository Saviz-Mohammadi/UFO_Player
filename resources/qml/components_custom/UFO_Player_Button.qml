import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

// Custom CPP Registered Types
import AppTheme 1.0

Button {
    id: root

    property alias svg: iconImage.source
    property int svgWidth: 24
    property int svgHeight: 24
    property int borderRadius: 0

    implicitWidth: 120
    implicitHeight: 35

    opacity: enabled ? 1.0 : 0.5
    hoverEnabled: enabled ? true : false

    contentItem: RowLayout {

        IconImage {
            id: iconImage

            Layout.preferredWidth: svgWidth
            Layout.preferredHeight: svgHeight

            Layout.leftMargin: 0
            Layout.rightMargin: 0

            source: ""
            Layout.alignment: Qt.AlignHCenter
            verticalAlignment: Image.AlignVCenter

            color: {
                if (root.checked) {
                    Qt.color(AppTheme.colors["UFO_Button_Icon_Checked"])
                }

                else if (root.hovered) {
                    Qt.color(AppTheme.colors["UFO_Button_Icon_Hovered"])
                }

                else {
                    Qt.color(AppTheme.colors["UFO_Button_Icon_Normal"])
                }
            }
        }
    }

    background: Rectangle {
        radius: borderRadius

        color: {
            if (root.checked) {
                Qt.color(AppTheme.colors["UFO_Button_Background_Checked"])
            }

            else if (root.hovered) {
                Qt.color(AppTheme.colors["UFO_Button_Background_Hovered"])
            }

            else {
                Qt.color(AppTheme.colors["UFO_Button_Background_Normal"])
            }
        }
    }
}
