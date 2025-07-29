#include "tickersviewmodel.h"

TickersViewModel::TickersViewModel(QObject *parent)
    : QAbstractListModel(parent)
    , m_fetcher(new TickersFetcher(this))
    , m_clockTimer(new QTimer(this))

{
    connect(m_fetcher, &TickersFetcher::tickersUpdated, this, &TickersViewModel::onTickersUpdated);
    m_fetcher->start();

    connect(m_fetcher, &TickersFetcher::fetchFailed, this, [this](const QString &reason) {
        if (m_statusText != "Disconnected") {
            m_statusText = "Disconnected";
            emit statusTextChanged();
        }
    });

    connect(m_fetcher, &TickersFetcher::loadingStarted, this, [this]() {
        if (m_statusText != "Loading...") {
            m_statusText = "Loading...";
            emit statusTextChanged();
        }
    });

    connect(m_clockTimer, &QTimer::timeout, this, &TickersViewModel::updateCurrentTime);
    m_clockTimer->start(1000); // раз в секунду
    updateCurrentTime();
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

QString TickersViewModel::statusText() const
{
    return m_statusText;
}

QString TickersViewModel::currentTime() const
{
    return m_currentTime;
}

QString TickersViewModel::exchangeName() const
{
    return m_exchangeName;
}

void TickersViewModel::updateCurrentTime()
{
    QString now = QDateTime::currentDateTime().toString("dd.MM.yyyy hh:mm:ss");
    if (now != m_currentTime) {
        m_currentTime = now;
        emit currentTimeChanged();
    }
}

void TickersViewModel::onTickersUpdated(const QList<Ticker> &tickers)
{
    QList<Ticker> sortedTickers = tickers;

    std::sort(sortedTickers.begin(), sortedTickers.end(), [](const Ticker &a, const Ticker &b) {
        return a.symbol.toUpper() < b.symbol.toUpper();
    });

    beginResetModel();
    m_tickers = sortedTickers;
    endResetModel();

    // Обновление названия биржи
    QString newExchange = !m_tickers.isEmpty() ? m_tickers.first().exchange : "";
    if (newExchange != m_exchangeName) {
        m_exchangeName = newExchange;
        emit exchangeNameChanged();
    }

    // Обновление статуса соединения
    if (m_statusText != "Connected") {
        m_statusText = "Connected";
        emit statusTextChanged();
    }
}
