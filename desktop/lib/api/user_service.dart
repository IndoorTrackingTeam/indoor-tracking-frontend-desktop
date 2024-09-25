import 'dart:convert';
import 'package:http/http.dart' as http;

const String path = 'https://run-api-dev-131050301176.us-east1.run.app';

class UserService {
  Future<String> signInEmailPassword(String email, String password) async {
    final url = Uri.parse('$path/user/login');

    final headers = {
      'Content-Type': 'application/json',
      'Accept-Charset': 'UTF-8',
    };

    final body = jsonEncode({
      "email": email,
      "password": password,
    });

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(utf8.decode(response.bodyBytes));
        final id = responseData['_id'];
        return id;
      } else {
        final errorMessage =
            jsonDecode(utf8.decode(response.bodyBytes))['param'];
        throw Exception(errorMessage);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<String> signUpEmailPassword(
      String name, String password, String email) async {
    final url = Uri.parse('$path/user/create');

    final headers = {
      'Content-Type': 'application/json',
      'Accept-Charset': 'UTF-8',
    };

    final body = jsonEncode({
      "name": name,
      "email": email,
      "password": password,
    });

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 201) {
        return 'Success';
      } else {
        final errorMessage =
            jsonDecode(utf8.decode(response.bodyBytes))['detail'];
        throw Exception(errorMessage);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Map<String, dynamic>> getUser(String token) async {
    final url = Uri.parse('$path/user/get-user?id=$token');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        var responseBody = utf8.decode(response.bodyBytes);
        return jsonDecode(responseBody);
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<String> updateUserPhoto(String id, String photo) async {
    final url = Uri.parse('$path/user/update-photo');

    final headers = {
      'Content-Type': 'application/json',
      'Accept-Charset': 'UTF-8',
    };

    final body = jsonEncode({
      "_id": id,
      "photo": photo,
    });

    try {
      final response = await http.put(
        url,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        return 'Success';
      } else {
        final errorMessage =
            jsonDecode(utf8.decode(response.bodyBytes))['detail'];
        throw Exception(errorMessage);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
