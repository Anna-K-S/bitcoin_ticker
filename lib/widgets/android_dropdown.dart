import 'package:flutter/material.dart';
import '../data/coin_data.dart';

//создаем виджет, который представляет собой выпадающий список валют для Android
class AndroidDropdown extends StatelessWidget {
  final Currency selectedCurrency;
  //callback, который будет вызываться при изменении выбранной валюты 
  final void Function(Currency?) onChanged;

  const AndroidDropdown({
    required this.selectedCurrency,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //создание пустого списка,где будут элементы выпадающего списка 
    List<DropdownMenuItem<Currency>> dropdownItems = [];
    for (Currency currency in Currency.values) {
      final newItem = DropdownMenuItem<Currency>(
        value: currency,
        child: Text(currency.name.toUpperCase()),
      );
      dropdownItems.add(newItem);
    }

    return DropdownButton<Currency>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: onChanged,
    );
  }
}
