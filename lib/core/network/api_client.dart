import 'package:dio/dio.dart';
import '../utils/shared_prefs.dart';

class ApiClient {
  // static const String baseUrl = 'http://10.0.2.2:8000/api/'; 
  static const String baseUrl = 'https://overshot-reprocess-eternal.ngrok-free.dev/api/'; 
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  )..interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await SharedPrefs.getToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
      ),
    );

  static Dio get instance => _dio;
}
