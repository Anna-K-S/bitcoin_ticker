class Rate {
  final DateTime time;
  final String assetIdQuote;
  final double rate;
  

  Rate({
    required this.time,
    required this.assetIdQuote,
    required this.rate,
    
  });
    // Фабричный метод fromJson для создания объекта Rate из Map<String, dynamic>
  factory Rate.fromJson(Map<String, dynamic> json) {
    
    return Rate(
      // Парсим значения из JSON и передаем их в конструктор класса Rate
      time: DateTime.parse(json['time'] as String),
      assetIdQuote: json['asset_id_quote'] as String,
      rate: json['rate'] as double,
    );
  }
}
  