import 'package:flutter/material.dart';
import '../models/player_profile.dart';
import 'history_screen.dart';
import '../widgets/section_header.dart'; 
import '../widgets/stat_row.dart'; 

// This screen shows the TabBar and hosts the Stats and History tabs.
class ProfileDetailScreen extends StatelessWidget {
  final PlayerProfile profile;
  const ProfileDetailScreen({super.key, required this.profile});
  
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(profile.nickname, style: const TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: Colors.red[900],
          bottom: const TabBar(
            indicatorColor: Colors.redAccent,
            tabs: [
              Tab(icon: Icon(Icons.bar_chart), text: 'Player Stats'), 
              Tab(icon: Icon(Icons.list_alt), text: 'Match History'), 
            ],
          ),
        ),
        body: TabBarView(
          children: [

            _PlayerStatsView(profile: profile), 
            
            
            HistoryScreen(profile: profile),
          ],
        ),
      ),
    );
  }
}


class _PlayerStatsView extends StatelessWidget {
  final PlayerProfile profile;
  const _PlayerStatsView({required this.profile});

  String _calculateWinRate(int wins, int totalMatches) {
    if (totalMatches == 0) return 'N/A';
    return '${(wins / totalMatches * 100).toStringAsFixed(1)}%';
  }


  String _calculateKDA(int kills, int deaths, int assists) {
    if (deaths == 0) return '$kills / 0 / $assists'; 
    return '${((kills + assists) / deaths).toStringAsFixed(2)}:1 KDA';
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        color: Colors.grey[850],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Header Section ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Row(
                      children: [
                        Text(
                          profile.nickname, 
                          style: const TextStyle(
                            fontSize: 26, 
                            fontWeight: FontWeight.w900, 
                            color: Colors.white
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (profile.teamTag.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              '[${profile.teamTag}]', 
                              style: const TextStyle(
                                fontSize: 22, 
                                fontWeight: FontWeight.bold, 
                                color: Colors.amber
                              )
                            ),
                          ),
                      ],
                    ),
                  ),
                  Text(
                    'LVL ${profile.level}', 
                    style: const TextStyle(
                      fontSize: 20, 
                      fontWeight: FontWeight.bold, 
                      color: Colors.redAccent
                    )
                  ),
                ],
              ),
              Text(
                profile.rankName, 
                style: TextStyle(
                  fontSize: 18, 
                  fontWeight: FontWeight.w500, 
                  color: Colors.red[300]
                )
              ),
              const Divider(color: Colors.white24, height: 30),
              
              // --- General Info Section ---
              const SectionHeader(title: 'General Info'), 
              StatRow(
                label: 'Win Rate (Overall)', 
                value: _calculateWinRate(profile.totalWins, profile.totalMatches),
                valueColor: Colors.greenAccent[400]
              ),
              StatRow(label: 'Total Wins', value: profile.totalWins.toString()),
              StatRow(label: 'Total Matches', value: profile.totalMatches.toString()),
              StatRow(label: 'Last Updated', value: profile.lastUpdated),


              const SectionHeader(title: 'Ranked Stats'), 
              StatRow(
                label: 'KDA (Ranked)', 
                value: _calculateKDA(profile.rankedKills, profile.rankedDeaths, profile.rankedAssists),
                valueColor: Colors.lightBlueAccent[100]
              ),
              StatRow(label: 'Total Kills', value: profile.rankedKills.toString()),
              StatRow(label: 'Total Deaths', value: profile.rankedDeaths.toString()),
              StatRow(label: 'Total Assists', value: profile.rankedAssists.toString()),
              StatRow(label: 'Total MVP', value: profile.rankedMvp.toString()),
            ],
          ),
        ),
      ),
    );
  }
}