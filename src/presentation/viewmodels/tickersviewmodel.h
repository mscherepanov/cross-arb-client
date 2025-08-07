#pragma once

#include <QAbstractListModel>
#include "../../core/models/ticker.h"
#include "../../data/http/tickersfetcher.h"

/**
 * @brief ViewModel для отображения тикеров в QML
 */
class TickersViewModel : public QAbstractListModel
{
    Q_OBJECT

    Q_PROPERTY(QString statusText READ statusText NOTIFY statusTextChanged)
    Q_PROPERTY(QString currentTime READ currentTime NOTIFY currentTimeChanged)
    Q_PROPERTY(QString exchangeName READ exchangeName NOTIFY exchangeNameChanged)
    Q_PROPERTY(QString filterExchange READ filterExchange WRITE setFilterExchange NOTIFY filterExchangeChanged)
    Q_PROPERTY(QStringList availableExchanges READ availableExchanges NOTIFY availableExchangesChanged)
public:
    enum Roles {
        SymbolRole = Qt::UserRole + 1,
        ExchangeRole,
        BidPriceRole,
        BidQtyRole,
        AskPriceRole,
        AskQtyRole
    };

    explicit TickersViewModel(QObject *parent = nullptr);

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;

    QString statusText() const;
    QString currentTime() const;
    QString exchangeName() const;
    QString filterExchange() const;
    void setFilterExchange(const QString &exchange);
    QStringList availableExchanges() const;

public slots:
    void updateCurrentTime();

private slots:
    void onTickersUpdated(const QList<Ticker> &tickers);

signals:
    void statusTextChanged();
    void currentTimeChanged();
    void exchangeNameChanged();
    void filterExchangeChanged();
    void availableExchangesChanged();

private:
    QList<Ticker> m_tickers;
    TickersFetcher *m_fetcher;

    QString m_statusText = "Loading...";
    QString m_currentTime;
    QString m_exchangeName;
    QString m_filterExchange;
    QStringList m_availableExchanges;

    QTimer *m_clockTimer = nullptr;
};
