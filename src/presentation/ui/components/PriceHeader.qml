import QtQuick 2.12
import QtQuick.Controls 2.12

Rectangle {
    width: parent.width
    height: 40
    color: "#1e1e1e"
    border.color: "#333"

    Row {
        anchors.fill: parent
        anchors.margins: 8
        spacing: 16

        Text {
            width: 150
            text: "Symbol"
            horizontalAlignment: Text.AlignLeft
            font.bold: true
            font.family: "Monospace"
            font.pointSize: 12
            color: "#bbbbbb"
        }

        Text { width: 150; text: "Bid Price"; horizontalAlignment: Text.AlignRight; font.bold: true; font.family: "Monospace"; font.pointSize: 12; color: "#bbbbbb" }
        Text { width: 150; text: "Bid Qty";   horizontalAlignment: Text.AlignRight; font.bold: true; font.family: "Monospace"; font.pointSize: 12; color: "#bbbbbb" }
        Text { width: 150; text: "Ask Price"; horizontalAlignment: Text.AlignRight; font.bold: true; font.family: "Monospace"; font.pointSize: 12; color: "#bbbbbb" }
        Text { width: 150; text: "Ask Qty";   horizontalAlignment: Text.AlignRight; font.bold: true; font.family: "Monospace"; font.pointSize: 12; color: "#bbbbbb" }
    }
}
