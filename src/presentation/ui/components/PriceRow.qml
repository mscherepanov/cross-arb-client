import QtQuick 2.12
import QtQuick.Layouts 1.12

Rectangle {
    id: rowRect
    height: 40
    width: parent.width
    color: hovered ? "#2a2a2a" : (index % 2 === 0 ? "#181818" : "#202020")
    border.color: "#2a2a2a"
    border.width: 1

    property bool hovered: false

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: rowRect.hovered = true
        onExited: rowRect.hovered = false
    }

    RowLayout {
        anchors.fill: parent
        anchors.margins: 8
        spacing: 16

        // Символ
        Text {
            text: {
                if (!symbol) return ""
                return symbol.toUpperCase().replace(/(.*)(USDT)$/, "$1/$2")
            }
            Layout.preferredWidth: 150
            color: "#ffffff"
            font.family: "Monospace"
            font.pointSize: 12
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
        }

        // Цены и объёмы
        Text {
            text: bidPrice || ""
            Layout.preferredWidth: 150
            color: "#00ff7f"
            font.family: "Monospace"
            font.pointSize: 12
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter
        }

        Text {
            text: bidQty || ""
            Layout.preferredWidth: 150
            color: "#00ff7f"
            font.family: "Monospace"
            font.pointSize: 12
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter
        }

        Text {
            text: askPrice || ""
            Layout.preferredWidth: 150
            color: "#ff5555"
            font.family: "Monospace"
            font.pointSize: 12
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter
        }

        Text {
            text: askQty || ""
            Layout.preferredWidth: 150
            color: "#ff5555"
            font.family: "Monospace"
            font.pointSize: 12
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter
        }
    }
}
