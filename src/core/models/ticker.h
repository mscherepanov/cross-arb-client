#pragma once

#include <QString>

/**
 * @brief Структура, представляющая котировку (тикер)
 *
 * Используется для отображения в таблице и передачи между слоями
 */
struct Ticker
{
    QString symbol;   ///< Название торговой пары
    QString exchange; ///< Название биржи
    double bidPrice;  ///< Лучшая цена покупки
    double bidQty;    ///< Количество по лучшей цене покупки
    double askPrice;  ///< Лучшая цена продажи
    double askQty;    ///< Количество по лучшей цене продажи
};
