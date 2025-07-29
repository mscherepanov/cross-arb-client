import QtQuick 2.12

Rectangle {
    id: rowRect
    width: parent.width
    height: 40
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

    Row {
        anchors.fill: parent
        anchors.margins: 8
        spacing: 16

        Text {
            width: 150
            text: {
                if (!symbol)
                    return ""
                var s = symbol.toUpperCase()
                return s.replace(/(.*)(USDT)$/, "$1/$2")
            }
            color: "#ffffff"
            font.family: "Monospace"
            font.pointSize: 12
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
        }

        Text {
            width: 150
            text: bidPrice || ""
            color: "#00ff7f"
            font.family: "Monospace"
            font.pointSize: 12
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter
        }

        Text {
            width: 150
            text: bidQty || ""
            color: "#00ff7f"
            font.family: "Monospace"
            font.pointSize: 12
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter
        }

        Text {
            width: 150
            text: askPrice || ""
            color: "#ff5555"
            font.family: "Monospace"
            font.pointSize: 12
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter
        }

        Text {
            width: 150
            text: askQty || ""
            color: "#ff5555"
            font.family: "Monospace"
            font.pointSize: 12
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter
        }
    }
}
