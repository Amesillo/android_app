import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/android_version.dart';

class AndroidService {
  static final String baseUrl = 'https://android-versions.onrender.com/api/android-versions';

  static Future<List<AndroidVersion>> getAll() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((item) => AndroidVersion.fromJson(item)).toList();
    } else {
      throw Exception('Error al conectar con Render');
    }
  }

  static Future<AndroidVersion> create(AndroidVersion version) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'nombre': version.nombre,
        'fecha': version.fecha,
        'descripcion': version.descripcion,
        'caracteristicas': version.caracteristicas,
        'urlPhoto': version.urlPhoto,
      }),
    );
    return AndroidVersion.fromJson(jsonDecode(response.body));
  }

  static Future<void> delete(int id) async {
    await http.delete(Uri.parse('$baseUrl/$id'));
  }
}
