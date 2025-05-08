import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl = 'http://172.16.205.63:8000/api/login/';

  Future<Map<String, dynamic>?> login(String username, String password) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: json.encode({"username": username, "password": password}),
    );

    if (response.statusCode == 200) {
      // Aquí se asume que la respuesta contiene un token
      final data = json.decode(response.body);
      return data; // Devuelve el token
    } else {
      return null; // Devuelve null si la autenticación falla
    }
  }
}
