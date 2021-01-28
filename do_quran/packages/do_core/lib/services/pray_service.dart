import 'dart:async';

import 'package:dio/dio.dart';
import 'package:do_core/api/pray/pray_api.dart';
import 'package:do_core/exceptions/server_error_exception.dart';
import 'package:do_core/models.dart';
import 'package:logger/logger.dart';

class PrayMethod {
  static const today = 'today';
  static const week = 'this_week';
  static const month = 'this_month';
}

class PrayService {
  final logger = Logger();
  final String city = 'jakarta';

  Future<Pray> getJadwalSalahPosition(
      String method, String latitude, String longitude) async {
    final PrayAPI _prayAPI = PrayAPI(Dio());
    if (latitude == null || longitude == null) {
      final Pray response = await _prayAPI
          .getJadwalSalahCity(method, city)
          .catchError((Object obj) {
        switch (obj.runtimeType) {
          case DioError:
            final error = ServerError.withError(error: obj as DioError);
            throw error;
            break;
          default:
        }
      });
      return response;
    } else {
      final Pray response = await _prayAPI
          .getJadwalSalahPosition(method, latitude, longitude)
          .catchError((Object obj) {
        switch (obj.runtimeType) {
          case DioError:
            final error = ServerError.withError(error: obj as DioError);
            throw error;
            break;
          default:
        }
      });
      return response;
    }
  }

  Future<Pray> getJadwalSalahCity(String method, String city) async {
    final PrayAPI _prayAPI = PrayAPI(Dio());
    final Pray response = await _prayAPI
        .getJadwalSalahCity(method, city)
        .catchError((Object obj) {
      switch (obj.runtimeType) {
        case DioError:
          final error = ServerError.withError(error: obj as DioError);
          throw error;
          break;
        default:
      }
    });
    return response;
  }
}
