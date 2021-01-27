import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:do_core/api/profile/profile_api.dart';
import 'package:do_core/exceptions/server_error_exception.dart';
import 'package:do_core/models/base_response.dart';
import 'package:do_core/models/profile_dto.dart';
import 'package:do_core/services/auth_service.dart';
import 'package:do_core/services/core_locator.dart';
import 'package:do_core/services/shared_preferences_service.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:retrofit/retrofit.dart';
import 'package:path_provider/path_provider.dart';

class ProfileService {
  ProfileService({@required AuthService authService})
      : assert(authService != null),
        _authService = authService;

  final String pathImage = '/Images/profile';
  final logger = Logger();
  final AuthService _authService;
  final SharedPreferencesService _sharedPreferences =
      coreLocator<SharedPreferencesService>();

  Future<ProfileDto> getProfile() async {
    final ProfileAPI _profileAPI = ProfileAPI(Dio(), _authService);
    final ProfileDto response =
        await _profileAPI.getProfile().catchError((Object obj) {
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

  Future<BaseResponse> putProfile(ProfileDto profile) async {
    final ProfileAPI _profileAPI = ProfileAPI(Dio(), _authService);
    final BaseResponse response =
        await _profileAPI.putProfile(profile).catchError((Object obj) {
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

  Future<String> getPhotoProfile() async {
    final String imageUrlUUID = _sharedPreferences.getString('image');
    final String username = _sharedPreferences.getString('username');
    final String provider = _sharedPreferences.getString('provider');
    final Directory srcDir = await getApplicationSupportDirectory();
    final Directory dirProfile = Directory('${srcDir.path}$pathImage');
    if (imageUrlUUID == null) {
      return null;
    }
    if (!await dirProfile.exists()) {
      await dirProfile.create(recursive: true);
    }
    final Dio _dio = Dio();
    _dio.options.responseType = ResponseType.bytes;
    if (provider == 'local') {
      final File image = File('${dirProfile.path}/$imageUrlUUID');
      if (!image.existsSync()) {
        final ProfileAPI _profileAPI = ProfileAPI(_dio, _authService);
        final HttpResponse response = await _profileAPI
            .getPhotoProfile(imageUrlUUID)
            .catchError((Object obj) {
          switch (obj.runtimeType) {
            case DioError:
              final error = ServerError.withError(error: obj as DioError);
              throw error;
              break;
            default:
          }
        });
        await image.writeAsBytes(response.data);
      }
      return '${dirProfile.path}/$imageUrlUUID';
    } else {
      final String paddingImage =
          imageUrlUUID.substring(imageUrlUUID.length - 11);
      final File image = File('${dirProfile.path}/$username$paddingImage');
      if (!image.existsSync()) {
        await _dio.download(
            imageUrlUUID, '${dirProfile.path}/$username$paddingImage');
      }
      return '${dirProfile.path}/$username$paddingImage';
    }
  }

  Future<BaseResponse> putPhotoProfile(File photo) async {
    final Dio _dio = Dio();
    _dio.options.extra = {'path': photo.path};
    final ProfileAPI _profileAPI = ProfileAPI(_dio, _authService);
    final BaseResponse response =
        await _profileAPI.putPhotoProfile(photo).catchError((Object obj) {
      switch (obj.runtimeType) {
        case DioError:
          final error = ServerError.withError(error: obj as DioError);
          throw error;
          break;
        default:
      }
    });
    await _sharedPreferences.putString(
        'image', response.respStatusMessage['checksum']);
    return response;
  }
}
