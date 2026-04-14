import 'package:dio/dio.dart';

class ApiService {
  final Dio dio = Dio();

  final String baseUrl = "https://69ddee44410caa3d47ba4218.mockapi.io";

  Future<void> send(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await dio.post('$baseUrl/$endpoint', data: data);
      print('$response');
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<Response> signUp(Map<String, dynamic> data) async {
    try {
      final response = await dio.post('$baseUrl/user', data: data);
      print('$response');
      return response;
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to sign up');
    }
  }

  Future<Response> login(String email, String pass) async {
    try {
      final response = await dio.get(
        '$baseUrl/user?email=$email&password=$pass',
      );
      print('$response');
      return response;
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to login');
    }
  }

  Future<Response> resetPassword(String email, String pass) async {
    try {
      Response? response;
      try {
        response = await dio.get('$baseUrl/user?email=$email');
      } catch (e) {
        print('Error: $e');
        throw Exception('Failed to find user with email: $email');
      }

      final userId = response.data[0]['id'];
      final updateResponse = await dio.put(
        '$baseUrl/user/$userId',
        data: {'password': pass},
      );

      print('$updateResponse');

      return updateResponse;
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to reset password');
    }
  }
}
