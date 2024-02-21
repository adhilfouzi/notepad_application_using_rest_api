import 'dart:convert';

import 'package:http/http.dart' as http;

import '../secret/secret_key.dart';

class NotepadDataProvider {
  static Future<int> deleteNotepadData(String id) async {
    final response = await http.delete(Uri.parse('$openApiKey/$id'));
    return response.statusCode;
  }

  static Future<List?> getNotepad() async {
    final response = await http.get(Uri.parse('$openApiKey?page=1&limit=20'));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final result = json['items'] as List;
      return result;
    } else {
      return null;
    }
  }

  static Future<int> patchNotepad(String id, Map body) async {
    final responce = await http.patch(Uri.parse('$openApiKey/$id'),
        body: jsonEncode(body), headers: {'Content-Type': 'application/json'});

    return responce.statusCode;
  }

  static Future<int> putNotepadData(String id, Map body) async {
    final responce = await http.put(Uri.parse('$openApiKey/$id'),
        body: jsonEncode(body), headers: {'Content-Type': 'application/json'});
    return responce.statusCode;
  }

  static Future<int> postNotepadData(Map body) async {
    final responce = await http.post(Uri.parse(openApiKey),
        body: jsonEncode(body), headers: {'Content-Type': 'application/json'});
    return responce.statusCode;
  }
}
