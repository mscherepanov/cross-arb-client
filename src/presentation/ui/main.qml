import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

import "components"

Window {
    id: root
    visible: true
    width: 1100
    height: 500
    minimumWidth: 800
    minimumHeight: 400
    title: "Arbitrage Command Center"
    color: "#121212"

    // Шапка: время
    Text {
        text: tickersModel.currentTime
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.topMargin: 10
        anchors.rightMargin: 20
        color: "#aaaaaa"
        font.family: "Monospace"
        font.pointSize: 10
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 10

        // Статус
        Text {
            text: "Status: " + tickersModel.statusText
            color: tickersModel.statusText === "Connected" ? "#00FF7F" : "#FF5555"
            font.bold: true
            font.pointSize: 14
            font.family: "Monospace"
        }

        // Название биржи
        Text {
            text: {
                if (tickersModel.filterExchange === "")
                    return "Exchange: All"
                else if (tickersModel.exchangeName !== "")
                    return "Exchange: " + tickersModel.exchangeName
                else
                    return ""
            }
            color: "#aaaaaa"
            font.family: "Monospace"
            font.pointSize: 12
        }

        ExchangeSelector {
            model: tickersModel.availableExchanges
            current: tickersModel.filterExchange
            onSelect: function(value) {
                tickersModel.filterExchange = value
            }
        }

        // Заголовок таблицы
        PriceHeader {
            Layout.fillWidth: true
        }

        // Таблица тикеров
        ListView {
            id: tableView
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true
            model: tickersModel
            delegate: PriceRow {
                width: tableView.width
            }
        }
    }
}
