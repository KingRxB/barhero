import 'package:flutter_test/flutter_test.dart';
import 'dart:convert';
import 'package:barhero/models/player_profile.dart'; 


const String mockPlayerResponse = """
{
    "uid": 1651337303,
    "name": "Finnsi",
    "updates": {
        "info_update_time": "12/22/2024, 9:33:14 AM"
    },
    "player": {
        "uid": 1651337303,
        "level": "81",
        "name": "Finnsi",
        "rank": {
            "rank": "One Above All"
        },
        "team": {
            "club_team_mini_name": ".VP"
        }
    },
    "overall_stats": {
        "total_matches": 35,
        "total_wins": 26,
        "ranked": {
            "total_assists": 156,
            "total_deaths": 190,
            "total_kills": 780,
            "total_mvp": 6
        }
    },
    "match_history": [
        {
            "match_uid": "6711506_1763247996_1292231_11001_22",
            "duration": 931.889999628067,
            "match_time_stamp": 1763249195,
            "player_performance": {
                "player_uid": 1651337303,
                "hero_name": "emma frost",
                "kills": 20,
                "is_win": {
                    "is_win": false
                }
            }
        },
        {
            "match_uid": "506016_1763246693_1291465_11001_21",
            "duration": 777.3276207447052,
            "match_time_stamp": 1763247738,
            "player_performance": {
                "player_uid": 1651337303,
                "hero_name": "angela",
                "kills": 31,
                "is_win": {
                    "is_win": true
                }
            }
        }
    ]
}
""";

void main() {
  // Grup tes untuk 'PlayerProfile Model'
  group('PlayerProfile Model', () {
    
   
    test('berhasil mem-parsing JSON lengkap', () {
      // 1. Ubah string JSON jadi Map
      final Map<String, dynamic> jsonMap = jsonDecode(mockPlayerResponse);
      
      // 2. Panggil factory constructor .fromJson
      final profile = PlayerProfile.fromJson(jsonMap);
      
      // 3. expect
      // Cek info dasar
      expect(profile.nickname, 'Finnsi');
      expect(profile.uid, 1651337303);
      expect(profile.level, '81');
      expect(profile.rankName, 'One Above All');
      expect(profile.teamTag, '.VP');
      
      // Cek stats keseluruhan
      expect(profile.totalMatches, 35);
      expect(profile.totalWins, 26);
      
      // Cek stats ranked
      expect(profile.rankedKills, 780);
      expect(profile.rankedDeaths, 190);
      expect(profile.rankedAssists, 156);
      expect(profile.rankedMvp, 6);
      
      // Cek riwayat pertandingan
      expect(profile.matchHistory.length, 2); 
      expect(profile.matchHistory[0].heroName, 'emma frost'); 
      expect(profile.matchHistory[0].result, 'LOSS'); 
      expect(profile.matchHistory[1].heroName, 'angela'); 
      expect(profile.matchHistory[1].result, 'WIN'); 
    });

  });
}