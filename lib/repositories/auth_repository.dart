import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';
import '../core/utils/shared_prefs.dart';

import 'package:dio/dio.dart';
import '../core/network/api_client.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository(ApiClient.instance));

class AuthRepository {
  final Dio _dio;

  AuthRepository(this._dio);

  Future<UserModel> login(String mssv, String password) async {
    try {
      final response = await _dio.post(
        '/sinhvien/login',
        data: {
          'MSSV': mssv,
          'Password': password,
        },
      );
      
      // Thành công (HTTP 200)
      if (response.statusCode == 200) {
        final data = response.data;
        final userJson = data['user'] as Map<String, dynamic>;
        
        // Backend trả về: { "MSSV": "...", "HoTen": "..." }
        // Cần map thành UserModel của Flutter: { "mssv": "...", "name": "..." }
        final mappedUserJson = {
          'mssv': userJson['MSSV'],
          'name': userJson['HoTen'],
        };
        
        // Lưu MSSV để giữ phiên (Do API hiện tại không có token)
        await SharedPrefs.saveMssv(userJson['MSSV']);
        
        return UserModel.fromJson(mappedUserJson);
      } else {
        throw Exception("Đăng nhập thất bại");
      }
    } on DioException catch (e) {
      if (e.response != null && e.response?.data != null) {
        throw Exception(e.response?.data['message'] ?? "Sai tài khoản hoặc mật khẩu");
      }
      throw Exception("Không thể kết nối đến máy chủ.");
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    await SharedPrefs.clearAll();
  }
}
