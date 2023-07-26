import 'package:bitcoin_ticker/data/all_current_rates.dart';
import 'package:dio/dio.dart';

// Указываем базовый путь для API и ключ авторизации
const _basePath = 'https://rest.coinapi.io';
const _key = '6586015C-0671-4ABB-A824-E718E4AE72BF';


// Класс CoinApi для работы с API для получения курсов валют
class CoinApi {
    // Создаем экземпляр Dio для отправки GET запроса
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: _basePath,
      headers: {'X-CoinAPI-Key': _key},
    ),
  );
    // Метод getPrice для получения курсов валют
  Future<AllCurrentRates> getPrice({
    bool invert = false,
  }) async {
        // Отправляем GET-запрос на указанный путь с параметрами
    final response = await _dio.get(
      '/v1/exchangerate/BTC',
      queryParameters: {'invert': invert},
     
    );
    // Проверяем статус код ответа, если не 200, выбрасываем исключение
    if (response.statusCode != 200) {
      throw Exception('error status code is ${response.statusCode}');
    }

    // Парсим данные JSON-ответа в объект AllCurrentRates с помощью фабричного метода fromJson
    final json = response.data as Map<String, dynamic>;
    final result = AllCurrentRates.fromJson(json);

    // Возвращаем полученный результат
    return result;
  }
}
