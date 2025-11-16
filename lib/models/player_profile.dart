import 'dart:convert';

// Model utama untuk menyimpan data profil pemain.
class PlayerProfile {
  final int uid;
  final String nickname;
  final String level;
  final int totalMatches;
  final String lastUpdated;
  final List<MatchHistoryItem> matchHistory;

  PlayerProfile({
    required this.uid,
    required this.nickname,
    required this.level,
    required this.totalMatches,
    required this.lastUpdated,
    required this.matchHistory,
  });

  factory PlayerProfile.fromJson(Map<String, dynamic> json) {
    final playerJson = json['player'] ?? {};
    final overallStatsJson = json['overall_stats'] ?? {};
    final updatesJson = json['updates'] ?? {};
    
    final matchHistoryList = (json['match_history'] as List? ?? [])
        .map((item) => MatchHistoryItem.fromJson(item))
        .toList();

    return PlayerProfile(
      uid: playerJson['uid'] ?? 0,
      nickname: playerJson['name'] ?? 'Pemain Misterius',
      level: playerJson['level'] ?? 'N/A',
      totalMatches: overallStatsJson['total_matches'] ?? 0,
      lastUpdated: updatesJson['info_update_time'] ?? 'N/A',
      matchHistory: matchHistoryList,
    );
  }
}

// Model untuk item tunggal dalam riwayat pertandingan.
class MatchHistoryItem {
  final String matchUid;
  final String date;
  final String result;
  final int kills;
  final int duration;

  MatchHistoryItem({
    required this.matchUid,
    required this.date,
    required this.result,
    required this.kills,
    required this.duration,
  });

  factory MatchHistoryItem.fromJson(Map<String, dynamic> json) {
    // Logika sederhana untuk menentukan hasil (Win/Loss).
    final winnerSide = json['winner_side'];
    String result = (winnerSide == 1) ? 'WIN' : 'LOSS';
    
    // Konversi timestamp (detik) ke format tanggal/waktu yang mudah dibaca.
    final timestamp = json['match_time_stamp'];
    final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);

    return MatchHistoryItem(
      matchUid: json['match_uid'] ?? 'N/A',
      date: "${dateTime.day}/${dateTime.month} ${dateTime.hour}:${dateTime.minute}",
      result: result,
      kills: json['player_performance']?['kills'] ?? 0,
      duration: (json['duration'] as num?)?.toInt() ?? 0,
    );
  }
}