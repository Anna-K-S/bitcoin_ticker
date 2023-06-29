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
  final _firstCurrency = Currency.values.first;
  final List<Currency> _currenciesList = Currency.values.toList();

  @override
  void initState() {
    super.initState();
    // установка начального значения для выбранной валюты
    _selectedCurrency =
        _firstCurrency; 
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
          Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = ? ${_selectedCurrency.name.toUpperCase()}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
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
