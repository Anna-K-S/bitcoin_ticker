import 'package:flutter/cupertino.dart';
import 'package:bitcoin_ticker/data/coin_data.dart';

//виджет представляющий собой выбор валюты в ios ом стиле
class IOSPicker extends StatelessWidget {
  final Currency selectedCurrency;
  final void Function(Currency) onChanged;

  const IOSPicker({
    required this.selectedCurrency,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<Text> pickerItems = [];
    //'for..in' перебирает все значения перечисления в Currency
    for (Currency currency in Currency.values) {
      pickerItems.add(
        Text(
          currency.name.toUpperCase(),
        ),
      );
    }

    return CupertinoPicker(
      itemExtent: 35.0,
      onSelectedItemChanged: (selectedIndex) {
        onChanged(Currency.values[selectedIndex]);
      },
      children: pickerItems,
    );
  }
}
