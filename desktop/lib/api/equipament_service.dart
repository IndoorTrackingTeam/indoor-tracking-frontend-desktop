import 'dart:convert';
import 'package:http/http.dart' as http;

const String path = 'https://run-api-dev-131050301176.us-east1.run.app';

class EquipamentService {
  Future<List<dynamic>> getEquipaments() async {
    var url = Uri.parse("$path/equipment/read-all");
    var response = await http.get(url, headers: {'Accept-Charset': 'UTF-8'});

    try {
      if (response.statusCode == 200) {
        var responseBody = utf8.decode(response.bodyBytes);
        return jsonDecode(responseBody);
      } else {
        throw Exception('Failed to load Equipaments');
      }
    } catch (e) {
      return Future.error('Failed to $e');
    }
  }

  Future<Map<String, dynamic>> getOneEquipament(String register) async {
    var url = Uri.parse("$path/equipment/read-one?register_=$register");
    var response = await http.get(url, headers: {'Accept-Charset': 'UTF-8'});

    try {
      if (response.statusCode == 200) {
        var responseBody = utf8.decode(response.bodyBytes);
        return jsonDecode(responseBody);
      } else {
        throw Exception('Failed to load Equipament');
      }
    } catch (e) {
      return Future.error('Failed to $e');
    }
  }

  Future<String> updateEquipamentsLocation() async {
    final url = Uri.parse('$path/equipment/update-equipments-position');

    final headers = {
      'Content-Type': 'application/json',
      'Accept-Charset': 'UTF-8',
    };

    try {
      final response = await http.post(
        url,
        headers: headers,
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(utf8.decode(response.bodyBytes));
        return responseData['message'];
      } else {
        final errorMessage =
            jsonDecode(utf8.decode(response.bodyBytes))['message'];
        throw Exception(errorMessage);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
