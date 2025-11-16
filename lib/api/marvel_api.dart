import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/player_profile.dart';

class ApiService {
  // API Key yang sudah Anda berikan dimasukkan di sini.
  static const String _apiKey =
      '84f0b0f7643316c68d8cf31fa181916509affb885102bc4b49f3c02df9def426';
  static const String _baseUrl = 'https://marvelrivalsapi.com/api/v1/player';

  Future<PlayerProfile> fetchProfile(String query) async {
    final url = Uri.parse('$_baseUrl/$query');

    final response = await http.get(url, headers: {'x-api-key': _apiKey});

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return PlayerProfile.fromJson(data);
    } else if (response.statusCode == 404) {
      throw Exception('Pemain tidak ditemukan (404). Cek UID/Username: $query');
    } else if (response.statusCode == 401) {
      throw Exception('Unauthorized (401). API Key salah atau tidak valid.');
    } else {
      throw Exception('Gagal memuat profil: Status ${response.statusCode}');
    }
  }
}
