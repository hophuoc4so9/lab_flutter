import 'package:dio/dio.dart';

class ApiService {
  final Dio dio = Dio();

  final String baseUrl = "https://69ddcc1a410caa3d47b9fdad.mockapi.io";

  Future<void> send(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await dio.post('$baseUrl/$endpoint', data: data);
      print('$response');
    } catch (e) {
      print('Error: $e');
    }
  }
}
