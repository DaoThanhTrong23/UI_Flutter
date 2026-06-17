import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';
import '../models/request_model.dart';
import '../models/notification_model.dart';
import '../models/faculty_model.dart';
import '../core/network/api_client.dart';
import '../core/utils/shared_prefs.dart';
import '../core/database/database_helper.dart';

final dataRepositoryProvider = Provider((ref) => DataRepository(ApiClient.instance));

class DataRepository {
  final Dio _dio;

  DataRepository(this._dio);

  Future<UserProfileModel> getProfile() async {
    final mssv = await SharedPrefs.getMssv() ?? '';
    try {
      final response = await _dio.get('sinhvien/$mssv/profile');
      if (response.data['success'] == true) {
        final data = response.data['data'];
        if (data['avatar'] != null) {
          data['avatar'] = data['avatar'].toString().replaceAll('localhost', '10.0.2.2').replaceAll('127.0.0.1', '10.0.2.2');
        }
        await DatabaseHelper.instance.saveProfile(mssv, data);
        return UserProfileModel.fromJson(data);
      }
      throw Exception('Server trả về lỗi: ${response.data['message'] ?? 'Không rõ'}');
    } catch (e) {
      if (e is DioException) {
        final cached = await DatabaseHelper.instance.getProfile(mssv);
        if (cached != null) {
          if (cached['avatar'] != null) {
            cached['avatar'] = cached['avatar'].toString().replaceAll('localhost', '10.0.2.2').replaceAll('127.0.0.1', '10.0.2.2');
          }
          return UserProfileModel.fromJson(cached);
        }
      }
      throw Exception('Chi tiết lỗi Profile: $e');
    }
  }

  Future<bool> updateProfile(Map<String, dynamic> data, {String? imagePath}) async {
    try {
      final mssv = await SharedPrefs.getMssv();
      
      var formData = FormData.fromMap(data);
      if (imagePath != null) {
        formData.files.add(
          MapEntry('Avatar', await MultipartFile.fromFile(imagePath)),
        );
      }

      final response = await _dio.post('sinhvien/$mssv/profile', data: formData);
      return response.data['success'] == true;
    } catch (e) {
      throw Exception('Lỗi cập nhật Profile: $e');
    }
  }

  Future<List<NotificationModel>> getNotifications() async {
    try {
      final mssv = await SharedPrefs.getMssv() ?? '';
      final response = await _dio.get('sinhvien/$mssv/notifications');
      if (response.data['success'] == true) {
        final data = response.data['data'] as List;
        return data.map((e) => NotificationModel.fromJson(e)).toList();
      }
      throw Exception('Server trả về lỗi');
    } catch (e) {
      throw Exception('Chi tiết lỗi Notifications: $e');
    }
  }

  Future<bool> deleteNotification(String id) async {
    try {
      final mssv = await SharedPrefs.getMssv() ?? '';
      final response = await _dio.delete('sinhvien/$mssv/notifications/$id');
      return response.data['success'] == true;
    } catch (e) {
      print('Error deleting notification: $e');
      return false;
    }
  }

  Future<Map<String, dynamic>> getRequests() async {
    final mssv = await SharedPrefs.getMssv() ?? '';
    try {
      final response = await _dio.get('sinhvien/$mssv/requests');
      
      if (response.data['success'] == true) {
        final data = response.data['data'] as List;
        final stats = response.data['stats'];
        
        await DatabaseHelper.instance.saveRequests(mssv, data, stats);

        return {
          'requests': data.map((e) => RequestModel.fromJson(e)).toList(),
          'stats': RequestStatsModel.fromJson(stats),
        };
      }
      throw Exception('Server trả về lỗi');
    } catch (e) {
      if (e is DioException) {
        final cached = await DatabaseHelper.instance.getRequests(mssv);
        if (cached != null) {
          final data = cached['requests'] as List;
          final stats = cached['stats'];
          return {
            'requests': data.map((e) => RequestModel.fromJson(e)).toList(),
            'stats': RequestStatsModel.fromJson(stats),
          };
        }
      }
      throw Exception('Chi tiết lỗi Requests: $e');
    }
  }

  Future<List<FacultyModel>> getFaculties() async {
    try {
      final mssv = await SharedPrefs.getMssv() ?? '';
      final response = await _dio.get('sinhvien/$mssv/faculties');
      if (response.data['success'] == true) {
        final data = response.data['data'] as List;
        return data.map((e) => FacultyModel.fromJson(e)).toList();
      }
      throw Exception('Server trả về lỗi');
    } catch (e) {
      throw Exception('Chi tiết lỗi Faculties: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getRequestTypes() async {
    try {
      final response = await _dio.get('request-types');
      if (response.data['success'] == true) {
        final data = response.data['data'] as List;
        return data.map((e) => e as Map<String, dynamic>).toList();
      }
      throw Exception('Server trả về lỗi');
    } catch (e) {
      throw Exception('Chi tiết lỗi Request Types: $e');
    }
  }

  Future<bool> createRequest(String maLoai, String noiDung, {String? filePath}) async {
    try {
      final mssv = await SharedPrefs.getMssv();
      var formData = FormData.fromMap({
        'MaLoai': maLoai,
        'NoiDung': noiDung,
      });

      if (filePath != null) {
        formData.files.add(
          MapEntry('file_dinh_kem', await MultipartFile.fromFile(filePath)),
        );
      }

      final response = await _dio.post('sinhvien/$mssv/requests', data: formData);
      return response.data['success'] == true;
    } catch (e) {
      print('Error creating request: $e');
      return false;
    }
  }

  Future<bool> cancelRequest(String id) async {
    try {
      final mssv = await SharedPrefs.getMssv() ?? '';
      final response = await _dio.put('sinhvien/$mssv/requests/$id/cancel');
      if (response.data['success'] == true) {
        return true;
      }
      return false;
    } catch (e) {
      print('Error canceling request: $e');
      return false;
    }
  }
}
