class Rates {
  final DateTime time;
  // final String assetIdBase;
  final List<dynamic> rates;

  Rates({
    required this.time,
    // required this.assetIdBase,
    required this.rates,
  });
  factory Rates.fromJson(Map<String, dynamic> json) {
    final ratesJson = json['rates'] as List<dynamic>;
    return Rates(
      time: DateTime.parse(json['time'] as String),
      // assetIdBase: json['asset_id_base'] as String,
      rates: ratesJson.map((json) => json as List<dynamic>).toList(),
    );
  }
}
