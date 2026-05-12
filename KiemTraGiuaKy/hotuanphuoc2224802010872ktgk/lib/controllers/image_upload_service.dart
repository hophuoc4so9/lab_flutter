import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ImageUploadService {


  
  static const String _cloudinaryCloudName = 'dmkagnuep'; 
  static const String _cloudinaryUploadPreset = 'ml_default';


  static Future<String> uploadImageToCloudinary(File imageFile) async {
    try {
      final uri = Uri.parse('https://api.cloudinary.com/v1_1/$_cloudinaryCloudName/image/upload');
      final request = http.MultipartRequest('POST', uri);
      
      request.files.add(
        await http.MultipartFile.fromPath('file', imageFile.path),
      );
      request.fields['upload_preset'] = _cloudinaryUploadPreset;

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData['secure_url'];
      } else {
        throw Exception('Cloudinary Upload Error: Code ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to upload image to Cloudinary: $e');
    }
  }



  static Future<String> uploadImage(File imageFile) async {
    return await uploadImageToCloudinary(imageFile);
    
  }
}
