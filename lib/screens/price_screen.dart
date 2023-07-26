import 'package:bitcoin_ticker/widgets/crypto_card.dart';
import 'package:bitcoin_ticker/service/api.dart';
import 'package:bitcoin_ticker/data/coin_data.dart';
import 'package:flutter/material.dart';
import '../widgets/android_dropdown.dart';
import '../widgets/ios_picker.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key});

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  // Определяем переменные для выбранной валюты и выбранной криптовалюты
  late Currency _selectedCurrency = _firstCurrency;
  late Crypto _selectedCrypto = _crypto;
  final _cryptos = Crypto.values;
  final _crypto = Crypto.values.first;
  final _firstCurrency = Currency.values.first;
  final _api = CoinApi();

  // Асинхронный метод для получения курса выбранной криптовалюты относительно выбранной валюты
  Future<double> _getPrice() async {
    final result = await _api.getPrice();

  // Фильтруем данные, чтобы получить информацию только по выбранной валюте
    final pricesByCurrency = result.rates
        .where(
          (element) =>
              element.assetIdQuote.toLowerCase() ==
              _selectedCurrency.name.toLowerCase(),
        )
        .toList();
        
    // Если нет данных о выбранной валюте, возвращаем 0.0
    if (pricesByCurrency.isEmpty) return 0.0;

    // Возвращаем курс выбранной криптовалюты(в нашем случае только BTC) относительно выбранной валюты
    return pricesByCurrency.first.rate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🤑 Coin Ticker'),
      ),
      body: FutureBuilder(
        // Вызываем асинхронный метод _getPrice(), чтобы получить курс
        future: _getPrice(),
        builder: (context, snapshot) {

          // Проверяем состояние FutureBuilder
          if (!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting) {

          // Если данные еще не получены или ожидаются, показываем индикатор загрузки
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // В случае возникновения ошибки возвращаем текст 'Error'
          if (snapshot.hasError) {
            return const Center(
              child: Text('Error'),
            );
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,

                // '_cryptos' - список значений перечисления Crypto
                children: _cryptos

                // Метод 'take' возвращает только первые 3 элемента 
                    .take(3)

                    // Преобразовываем данные
                    .map(

                      // Создание нового виджета 'CryptoCard' для каждого элемента 'e'
                      (e) => CryptoCard(
                        selectedCurrency:

                        // Передаем информацию о выбранной валюте, используя snapshot.data, которое содержит данные о курсах, полученные из API
                        // Метод toStringAsFixed(2) используется для округления числа к двум десятичным знакам
                            '${snapshot.data!.toStringAsFixed(2)}  ${_selectedCurrency.name.toUpperCase()}',
                        selectedCrypto: e.name.toString().toUpperCase(),
                      ),
                    )
                    .toList(),
              ),
              Container(
                height: 150.0,
                alignment: Alignment.center,
                padding: const EdgeInsets.only(bottom: 30.0),
                color: Colors.lightBlue,
                //проверка платформы
                child: Platform.isIOS
                    ? IOSPicker(
                        selectedCurrency: _selectedCurrency,
                        onChanged: _onCurrencyChanged,
                      )
                    : AndroidDropdown(
                        selectedCurrency: _selectedCurrency,
                        onChanged: _onCurrencyChanged,
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  // Метод для обновления выбранной валюты
  void _onCurrencyChanged(Currency? newCurrency) {
    setState(() {
      //проверяем является ли 'newCurrency' null ом
      _selectedCurrency = newCurrency ?? _selectedCurrency;
    });
  }
}
