// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pray_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _PrayAPI implements PrayAPI {
  _PrayAPI(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<Pray> getJadwalSalahPosition(method, latitude, longitude) async {
    ArgumentError.checkNotNull(method, 'method');
    ArgumentError.checkNotNull(latitude, 'latitude');
    ArgumentError.checkNotNull(longitude, 'longitude');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/v2/times/$method.json?latitude=$latitude&longitude=$longitude',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'content-type': 'application/json'},
            extra: _extra,
            contentType: 'application/json',
            baseUrl: baseUrl),
        data: _data);
    final value = Pray.fromJson(_result.data);
    return value;
  }

  @override
  Future<Pray> getJadwalSalahCity(method, city) async {
    ArgumentError.checkNotNull(method, 'method');
    ArgumentError.checkNotNull(city, 'city');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/v2/times/$method.json?city=$city',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'content-type': 'application/json'},
            extra: _extra,
            contentType: 'application/json',
            baseUrl: baseUrl),
        data: _data);
    final value = Pray.fromJson(_result.data);
    return value;
  }
}
