#include "tickersfetcher.h"
#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonObject>
#include <QNetworkReply>

TickersFetcher::TickersFetcher(QObject *parent)
    : QObject(parent)
    , m_networkManager(new QNetworkAccessManager(this))
    , m_timer(new QTimer(this))
{
    connect(m_timer, &QTimer::timeout, this, &TickersFetcher::fetch);
    connect(m_networkManager,
            &QNetworkAccessManager::finished,
            this,
            &TickersFetcher::onReplyFinished);
}

void TickersFetcher::start()
{
    m_timer->start(1000); // раз в 1 секунду
    fetch();              // сразу первая попытка
}

void TickersFetcher::fetch()
{
    emit loadingStarted(); // перед отправкой
    QUrl url("http://localhost:8080/tickers");
    QNetworkRequest request(url);
    m_networkManager->get(request);
}

void TickersFetcher::onReplyFinished(QNetworkReply *reply)
{
    QList<Ticker> result;

    if (reply->error() == QNetworkReply::NoError) {
        const QByteArray data = reply->readAll();
        const QJsonDocument doc = QJsonDocument::fromJson(data);

        if (doc.isArray()) {
            for (const QJsonValue &val : doc.array()) {
                const QJsonObject obj = val.toObject();
                Ticker t;
                t.symbol = obj["symbol"].toString();
                t.exchange = obj["exchange"].toString();
                t.bidPrice = obj["bidPrice"].toDouble();
                t.bidQty = obj["bidQty"].toDouble();
                t.askPrice = obj["askPrice"].toDouble();
                t.askQty = obj["askQty"].toDouble();
                result.append(t);
            }
        }

        emit tickersUpdated(result);
    } else {
        emit fetchFailed(reply->errorString());
    }

    reply->deleteLater();
}
