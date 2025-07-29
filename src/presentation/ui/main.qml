import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

import "components"

Window {
    id: root
    visible: true
    width: 900
    height: 310
    title: "Arbitrage Command Center"
    color: "#121212"

    // Дата и время
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
        spacing: 10
        anchors.margins: 20

        // Статус соединения
        Text {
            text: "Status: " + tickersModel.statusText
            color: tickersModel.statusText === "Connected" ? "#00FF7F" : "#FF5555"
            font.bold: true
            font.pointSize: 14
            font.family: "Monospace"
        }

        // Название биржи
        Text {
            text: tickersModel.exchangeName !== "" ? "Exchange: " + tickersModel.exchangeName : ""
            color: "#aaaaaa"
            font.family: "Monospace"
            font.pointSize: 12
        }

        // Заголовок таблицы
        PriceHeader {}

        // Список котировок
        ListView {
            id: tableView
            Layout.fillWidth: true
            Layout.fillHeight: true
            model: tickersModel
            delegate: PriceRow {}
        }
    }
}
