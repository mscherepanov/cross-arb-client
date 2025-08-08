import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

RowLayout {
    id: root
    spacing: 10

    property var model
    property string current: ""
    property var onSelect

    // Кнопка "All"
    Button {
        id: allButton
        Layout.preferredHeight: 40
        Layout.preferredWidth: 80
        checkable: true
        checked: current === ""
        onClicked: onSelect("")

        background: Rectangle {
            border.color: "#333"
            color: allButton.checked ? "#333333" : "#1e1e1e"
        }

        contentItem: Text {
            text: allButton.text
            font.bold: true
            font.family: "Monospace"
            color: "#bbbbbb"
            font.pointSize: 12
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        text: "All"
    }

    // Кнопки бирж
    Repeater {
        model: root.model
        delegate: Button {
            id: exchangeButton
            Layout.preferredHeight: 40
            Layout.preferredWidth: 120
            checkable: true
            checked: modelData === root.current
            onClicked: root.onSelect(modelData)
            text: modelData

            background: Rectangle {
                border.color: "#333"
                color: exchangeButton.checked ? "#333333" : "#1e1e1e"
            }

            contentItem: Text {
                text: exchangeButton.text
                font.bold: true
                font.family: "Monospace"
                color: "#bbbbbb"
                font.pointSize: 12
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }
    }
}
