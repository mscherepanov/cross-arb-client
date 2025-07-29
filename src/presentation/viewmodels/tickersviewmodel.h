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

private slots:
    void onTickersUpdated(const QList<Ticker> &tickers);

private:
    QList<Ticker> m_tickers;
    TickersFetcher *m_fetcher;
};
