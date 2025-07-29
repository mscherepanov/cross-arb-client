# cross-arb-client

CrossArb Client — интерактивный клиент для визуального контроля и управления системой [кросс-биржевого арбитража](https://github.com/dimryb/cross-arb)

Приложение реализовано на **C++ с использованием Qt 5 (QML)**. Архитектура проекта следует принципам MVVM и чистого разделения ответственности между слоями.

---

## ⚙️  Сборка и запуск

### Linux

**Предварительные зависимости:**

- Qt 5.12+ (`qt5-default`, `qtdeclarative5-dev`)
- CMake 3.14+
- Компилятор C++ с поддержкой стандарта C++17

**Инструкция по сборке:**

```bash
sudo apt install qt5-default qtdeclarative5-dev cmake g++
git clone https://github.com/mscherepanov/cross-arb-client.git
cd cross-arb-client
mkdir build && cd build
cmake ..
make
./cross-arb-client
```

### Windows

Для сборки и запуска рекомендуется использовать Qt Creator:

1. Установите Qt 5.12+ и соответствующий компилятор (например, MinGW).
2. Откройте `CMakeLists.txt` в Qt Creator.
3. Выполните сборку и запуск через интерфейс среды.

---

## 📡 Интерфейс взаимодействия

Приложение осуществляет запросы к HTTP-эндпоинту `http://localhost:8080/tickers`. 

Ожидаемый формат ответа:

```json
[
  {
    "symbol": "BTCUSDT",
    "exchange": "mexc",
    "bidPrice": 118869.58,
    "bidQty": 11.92,
    "askPrice": 118870.01,
    "askQty": 6.11
  }
]
```

---

## 🗂 Структура проекта

```text
src/
├── app/              # Точка входа в приложение
├── core/models/      # Базовые модели данных (Ticker)
├── data/http/        # Работа с HTTP API (TickersFetcher)
├── presentation/
│   ├── viewmodels/   # ViewModel-слой (TickersViewModel)
│   └── ui/           # Пользовательский интерфейс на QML
```
