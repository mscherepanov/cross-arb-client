import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Rectangle {
    height: 40
    color: "#1e1e1e"
    border.color: "#333"

    RowLayout {
        anchors.fill: parent
        anchors.margins: 8
        spacing: 16

        Text {
            text: "Symbol"
            Layout.preferredWidth: 150
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            font.bold: true
            font.family: "Monospace"
            font.pointSize: 12
            color: "#bbbbbb"
        }

        Repeater {
            model: ["Bid Price", "Bid Qty", "Ask Price", "Ask Qty"]

            delegate: Text {
                text: modelData
                Layout.preferredWidth: 150
                horizontalAlignment: Text.AlignRight
                verticalAlignment: Text.AlignVCenter
                font.bold: true
                font.family: "Monospace"
                font.pointSize: 12
                color: "#bbbbbb"
            }
        }
    }
}
