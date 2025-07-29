#include "tickersviewmodel.h"

TickersViewModel::TickersViewModel(QObject *parent)
    : QAbstractListModel(parent)
    , m_fetcher(new TickersFetcher(this))
{
    connect(m_fetcher, &TickersFetcher::tickersUpdated, this, &TickersViewModel::onTickersUpdated);
    m_fetcher->start();
}

int TickersViewModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return m_tickers.size();
}

QVariant TickersViewModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() >= m_tickers.size())
        return {};

    const Ticker &t = m_tickers.at(index.row());

    switch (role) {
    case SymbolRole:
        return t.symbol;
    case ExchangeRole:
        return t.exchange;
    case BidPriceRole:
        return t.bidPrice;
    case BidQtyRole:
        return t.bidQty;
    case AskPriceRole:
        return t.askPrice;
    case AskQtyRole:
        return t.askQty;
    default:
        return {};
    }
}

QHash<int, QByteArray> TickersViewModel::roleNames() const
{
    return {{SymbolRole, "symbol"},
            {ExchangeRole, "exchange"},
            {BidPriceRole, "bidPrice"},
            {BidQtyRole, "bidQty"},
            {AskPriceRole, "askPrice"},
            {AskQtyRole, "askQty"}};
}

void TickersViewModel::onTickersUpdated(const QList<Ticker> &tickers)
{
    beginResetModel();
    m_tickers = tickers;
    endResetModel();
}
