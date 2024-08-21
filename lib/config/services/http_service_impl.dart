import 'package:dio/dio.dart';
import 'package:conta/config/injection.dart';
import 'package:conta/config/services/http_service.dart';
import 'package:conta/config/settings.dart';

import 'package:conta/domain/services/auth_service.dart';

class HttpServiceImpl implements HttpService {
  late Dio _dio;

  Future<void> _refreshToken() async {
    await getIt<AuthService>().logout();
    String email = (await getIt<AuthService>().user).email;
    String password = (await getIt<AuthService>().user).password;
    await getIt<AuthService>().login(email: email, password: password);
  }

  HttpServiceImpl() {
    _dio = Dio(
      BaseOptions(
        baseUrl: Settings.baseUrl,
        headers: {'Content-Type': 'application/json'},
      ),
    );
    _dio.interceptors.add(LogInterceptor());
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async => handler.next(options),
        onResponse: (response, handler) async => handler.next(response),
        onError: (error, handler) async {
          if (error.response == null) return handler.next(error);
          if (error.response!.statusCode != 401) return handler.next(error);
          if (error.requestOptions.path == API.token) {
            return handler.next(error);
          }
          RequestOptions requestOptions = error.requestOptions;
          await _refreshToken();
          requestOptions.headers['Authorization'] =
              'Bearer ${await getIt<AuthService>().token}';
          await _dio.request(
            requestOptions.path,
            options: Options(headers: requestOptions.headers),
            cancelToken: requestOptions.cancelToken,
            onReceiveProgress: requestOptions.onReceiveProgress,
            data: requestOptions.data,
            onSendProgress: requestOptions.onSendProgress,
            queryParameters: requestOptions.queryParameters,
          );
        },
      ),
    );
  }

  Future<Map<String, dynamic>> _getAuth(
    Map<String, dynamic>? oldHeaders,
    bool isAuth,
  ) async {
    final Map<String, dynamic> headers = oldHeaders ?? {};
    if (isAuth) {
      String token = await getIt<AuthService>().token;
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }

  Map<String, dynamic> _setFileHeaders(
    Map<String, dynamic>? oldHeaders,
    bool hasFile,
  ) {
    final Map<String, dynamic> headers = oldHeaders ?? {};
    if (hasFile) headers['Content-Type'] = 'multipart/form-data';
    return headers;
  }

  @override
  Future<Response> get({
    required String path,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    bool isAuth = true,
  }) async {
    Map<String, dynamic> newHeaders = await _getAuth(headers, isAuth);
    final Options options = Options(headers: newHeaders);
    return _dio.get(path, queryParameters: queryParameters, options: options);
  }

  @override
  Future<Response> post({
    required String path,
    dynamic data,
    Map<String, dynamic>? headers,
    bool isAuth = true,
    bool hasFile = false,
  }) async {
    Map<String, dynamic> nHeaders = await _getAuth(headers, isAuth);
    Map<String, dynamic> newHeaders = _setFileHeaders(nHeaders, hasFile);

    final Options options = Options(headers: newHeaders);
    return await _dio.post(path, data: data, options: options);
  }

  @override
  Future<Response> put({
    required String path,
    dynamic data,
    Map<String, dynamic>? headers,
    bool isAuth = true,
    bool hasFile = false,
  }) async {
    Map<String, dynamic> nHeaders = await _getAuth(headers, isAuth);
    Map<String, dynamic> newHeaders = _setFileHeaders(nHeaders, hasFile);
    final Options options = Options(headers: newHeaders);
    return await _dio.put(path, data: data, options: options);
  }

  @override
  Future<Response> delete({
    required String path,
    Map<String, dynamic>? headers,
    bool isAuth = true,
  }) async {
    Map<String, dynamic> newHeaders = await _getAuth(headers, isAuth);
    final Options options = Options(headers: newHeaders);
    return await _dio.delete(path, options: options);
  }
}
