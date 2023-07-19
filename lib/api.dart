import 'package:bitcoin_ticker/all_current_rates.dart';
import 'package:dio/dio.dart';

const _basePath = 'https://rest.coinapi.io';
const _key = '6586015C-0671-4ABB-A824-E718E4AE72BF';

class CoinApi {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: _basePath,
    ),
  );
  Future<AllCurrentRates> getPrice(
    String assetIdBase,
  ) async {
    final response = await _dio.get(
      '/v1/exchangerate/$assetIdBase/?invert=false',
      options: Options(
        headers: <String, String>{'X-CoinAPI-Key': '$_key'},
      ),
    );

    if (response.statusCode != 200)
      throw Exception('error status code is ${response.statusCode}');

    final json = response.data as Map<String, dynamic>;
    final result = AllCurrentRates.fromJson(json);
    return result;
  }
}
