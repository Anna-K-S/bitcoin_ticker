import 'package:bitcoin_ticker/crypto_card.dart';

import 'api.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'android_dropdown.dart';
import 'ios_picker.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key});

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  late Currency _selectedCurrency;
  final  _selectedCrypto = Crypto.values;
  // final _crypto = Crypto.values;
  final _firstCurrency = Currency.values.first;
  // final _api = CoinApi();

  @override
  void initState() {
    super.initState();
    // установка начального значения для выбранной валюты
    _selectedCurrency = _firstCurrency;
    // _selectedCrypto = _crypto as Crypto;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              CryptoCard(
                selectedCurrency: _selectedCurrency.name.toUpperCase(),
                selectedCrypto: _selectedCrypto[0].name.toUpperCase(),
              ),
              CryptoCard(
                selectedCurrency: _selectedCurrency.name.toUpperCase(),
                selectedCrypto: _selectedCrypto[1].name.toUpperCase(),
              ),
              CryptoCard(
                selectedCurrency: _selectedCurrency.name.toUpperCase(),
                 selectedCrypto:_selectedCrypto[2].name.toUpperCase(), ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 15.0, horizontal: 28.0),
            child: FutureBuilder(
              // future: _api.getPrice(_selectedCrypto.name),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final price = snapshot.data;

                  return Text(
                    '1 ${_selectedCrypto} = ${price.toString()}  ${_selectedCurrency.name.toUpperCase()}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  );
                }
                return Text('error');
              },
            ),
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
      ),
    );
  }

  void _onCurrencyChanged(Currency? newCurrency) {
    setState(() {
      //проверяем является ли 'newCurrency' null ом
      _selectedCurrency = newCurrency ?? _selectedCurrency;
    });
  }
}
