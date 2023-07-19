import 'package:bitcoin_ticker/rates.dart';

class AllCurrentRates {
  final String assetIdBase;
  final List<Rates> rates;

  AllCurrentRates({
    required this.assetIdBase,
    required this.rates,
  });
  factory AllCurrentRates.fromJson(Map<String, dynamic> json) {
    final ratesJson = json['rates'] as List<dynamic>;

    return AllCurrentRates(
      assetIdBase: json['asset_id_base'] as String,
      rates: ratesJson.map((json) => Rates.fromJson(json as Map<String, dynamic>)).toList(),
    );
  }
}
