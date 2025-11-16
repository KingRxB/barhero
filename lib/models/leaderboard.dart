import 'dart:convert';

// Model to hold the entire API response for the leaderboard
class LeaderboardResponse {
  final int currentPage;
  final int totalPages;
  final List<LeaderboardPlayer> players;

  LeaderboardResponse({
    required this.currentPage,
    required this.totalPages,
    required this.players,
  });

  factory LeaderboardResponse.fromJson(Map<String, dynamic> json) {
    var playerList = (json['players'] as List? ?? [])
        .map((playerJson) => LeaderboardPlayer.fromJson(playerJson))
        .toList();

    return LeaderboardResponse(
      currentPage: json['page'] ?? 1,
      totalPages: json['total_pages'] ?? 1,
      players: playerList,
    );
  }
}

// Model for a single player entry in the leaderboard
class LeaderboardPlayer {
  final String uid;
  final String name;
  final int score;
  final String rankName;
  final String winRate;

  LeaderboardPlayer({
    required this.uid,
    required this.name,
    required this.score,
    required this.rankName,
    required this.winRate,
  });

  factory LeaderboardPlayer.fromJson(Map<String, dynamic> json) {
    final rankData = json['rank'] ?? {};
    final rankInfo = rankData['rank'] ?? {};

    return LeaderboardPlayer(
      uid: json['uid'] ?? 'N/A',
      name: json['name'] ?? 'Unknown Player', // English text
      score: (json['score'] as num?)?.toInt() ?? 0,
      rankName: rankInfo['rank'] ?? 'Unranked',
      winRate: rankData['win_rate'] ?? '0.0%',
    );
  }
}
