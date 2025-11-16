import 'dart:convert';

// Detail Player Profile
class PlayerProfile {
  final int uid;
  final String nickname;
  final String level;
  final String lastUpdated;
  final String rankName;
  final String teamTag;

  // Stats
  final int totalMatches;
  final int totalWins;

  // Ranked Stats
  final int rankedKills;
  final int rankedDeaths;
  final int rankedAssists;
  final int rankedMvp;

  final List<MatchHistoryItem> matchHistory;

  PlayerProfile({
    required this.uid,
    required this.nickname,
    required this.level,
    required this.lastUpdated,
    required this.rankName,
    required this.teamTag,
    required this.totalMatches,
    required this.totalWins,
    required this.rankedKills,
    required this.rankedDeaths,
    required this.rankedAssists,
    required this.rankedMvp,
    required this.matchHistory,
  });

  factory PlayerProfile.fromJson(Map<String, dynamic> json) {
    final playerJson = json['player'] ?? {};
    final updatesJson = json['updates'] ?? {};
    final rankJson = playerJson['rank'] ?? {};
    final teamJson = playerJson['team'] ?? {};
    final overallStatsJson = json['overall_stats'] ?? {};
    final rankedStatsJson = overallStatsJson['ranked'] ?? {};

    final matchHistoryList = (json['match_history'] as List? ?? [])
        .map((item) => MatchHistoryItem.fromJson(item))
        .toList();

    return PlayerProfile(
      uid: playerJson['uid'] ?? 0,
      nickname: playerJson['name'] ?? 'Mysterious Player',
      level: playerJson['level'] ?? 'N/A',
      lastUpdated: updatesJson['info_update_time'] ?? 'N/A',
      rankName: rankJson['rank'] ?? 'Unranked',
      teamTag: teamJson['club_team_mini_name'] ?? '',

      totalMatches: overallStatsJson['total_matches'] ?? 0,
      totalWins: overallStatsJson['total_wins'] ?? 0,

      rankedKills: rankedStatsJson['total_kills'] ?? 0,
      rankedDeaths: rankedStatsJson['total_deaths'] ?? 0,
      rankedAssists: rankedStatsJson['total_assists'] ?? 0,
      rankedMvp: rankedStatsJson['total_mvp'] ?? 0,

      matchHistory: matchHistoryList,
    );
  }
}

class MatchHistoryItem {
  final String matchUid;
  final String date;
  final String result;
  final int kills;
  final int duration;
  final String heroName;

  MatchHistoryItem({
    required this.matchUid,
    required this.date,
    required this.result,
    required this.kills,
    required this.duration,
    required this.heroName,
  });

  factory MatchHistoryItem.fromJson(Map<String, dynamic> json) {
    final performance = json['player_performance'] ?? {};
    final isWinData = performance['is_win'] ?? {};
    final bool isWin = isWinData['is_win'] ?? false;

    final timestamp = json['match_time_stamp'];
    final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);

    return MatchHistoryItem(
      matchUid: json['match_uid'] ?? 'N/A',
      date:
          "${dateTime.day}/${dateTime.month} ${dateTime.hour}:${dateTime.minute}",
      result: (isWin) ? 'WIN' : 'LOSS',
      kills: performance['kills'] ?? 0,
      duration: (json['duration'] as num?)?.toInt() ?? 0,
      heroName: performance['hero_name'] ?? 'Unknown Hero',
    );
  }
}
