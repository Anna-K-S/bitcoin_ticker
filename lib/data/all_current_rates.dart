import 'package:bitcoin_ticker/data/rate.dart';

// Класс AllCurrentRates представляет данные о текущих курсах валют
class AllCurrentRates {
  final String assetIdBase;
  // Список объектов Rate, представляющих курсы валют
  final List<Rate> rates;

  // Конструктор класса, принимающий обязательные параметры assetIdBase и rates
  AllCurrentRates({
    required this.assetIdBase,
    required this.rates,
  });
    // Фабричный метод fromJson для создания объекта AllCurrentRates из Map<String, dynamic>
  factory AllCurrentRates.fromJson(Map<String, dynamic> json) {
    // Получаем список курсов из JSON
    final ratesJson = json['rates'] as List<dynamic>;

    return AllCurrentRates(
      assetIdBase: json['asset_id_base'] as String,
      // Парсим каждый JSON в объект Rate и добавляем в список
      rates: ratesJson
          .map(
            (json) => Rate.fromJson(json as Map<String, dynamic>),
          )
          .toList(),
    );
  }
}
