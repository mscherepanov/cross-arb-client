#pragma once

#include <QNetworkAccessManager>
#include <QObject>
#include <QTimer>
#include "../../core/models/ticker.h"

/**
 * @brief Класс для получения котировок с локального сервера
 */
class TickersFetcher : public QObject
{
    Q_OBJECT
public:
    explicit TickersFetcher(QObject *parent = nullptr);

    /// Запускает периодическую загрузку данных
    void start();

signals:
    /// Вызывается при успешной загрузке и разборе тикеров
    void tickersUpdated(const QList<Ticker> &tickers);
    void fetchFailed(const QString &reason);
    void loadingStarted();

private slots:
    void fetch();
    void onReplyFinished(QNetworkReply *reply);

private:
    QNetworkAccessManager *m_networkManager;
    QTimer *m_timer;
};
