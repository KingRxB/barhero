import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/player_profile.dart';
import '../models/leaderboard.dart';

// This class handles all network requests to the Marvel Rivals API.
class MarvelApi {
  // API Key provided by the user
  static const String _apiKey =
      '84f0b0f7643316c68d8cf31fa181916509affb885102bc4b49f3c02df9def426';

  static const String _baseUrl = 'https://marvelrivalsapi.com/api/v1/player';

  static const String _leaderboardUrl =
      'https://marvelrivalsapi.com/api/v2/players/leaderboard';

  Future<PlayerProfile> fetchProfile(String query) async {
    final url = Uri.parse('$_baseUrl/$query');

    final response = await http.get(url, headers: {'x-api-key': _apiKey});

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return PlayerProfile.fromJson(data);
    } else if (response.statusCode == 404) {
      throw Exception('Player not found (404). Check UID/Username: $query');
    } else if (response.statusCode == 401) {
      throw Exception('Unauthorized (401). Invalid API Key.');
    } else {
      throw Exception('Failed to load profile: Status ${response.statusCode}');
    }
  }

  Future<LeaderboardResponse> fetchLeaderboard() async {
    final url = Uri.parse(_leaderboardUrl);

    final response = await http.get(url, headers: {'x-api-key': _apiKey});

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return LeaderboardResponse.fromJson(data);
    } else if (response.statusCode == 401) {
      throw Exception('Failed to load leaderboard: Invalid API Key (401).');
    } else {
      throw Exception(
        'Failed to load leaderboard: Status ${response.statusCode}',
      );
    }
  }
}
