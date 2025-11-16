import 'package:flutter/material.dart';
import '../models/leaderboard.dart';
import '../api/marvel_api.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  late Future<LeaderboardResponse> _leaderboardFuture;
  final MarvelApi _apiService = MarvelApi();

  @override
  void initState() {
    super.initState();
 
    _leaderboardFuture = _apiService.fetchLeaderboard();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Players Leaderboard'), 
      ),
      body: FutureBuilder<LeaderboardResponse>(
        future: _leaderboardFuture,
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Error: ${snapshot.error}', 
                  style: const TextStyle(color: Colors.amber),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }


          if (!snapshot.hasData || snapshot.data!.players.isEmpty) {
            return const Center(
              child: Text('No leaderboard data available.'), 
            );
          }


          final leaderboard = snapshot.data!;
          
          return ListView.builder(
            itemCount: leaderboard.players.length,
            itemBuilder: (context, index) {
              final player = leaderboard.players[index];
              return Card(
                color: Colors.grey[800],
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.redAccent,
                    child: Text(
                      '${index + 1}', 
                      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                  title: Text(
                    player.name,
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  subtitle: Text(
                    'Rank: ${player.rankName} | WR: ${player.winRate}', 
                    style: TextStyle(color: Colors.grey[300]),
                  ),
                  trailing: Text(
                    'Score: ${player.score}', 
                    style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.w500),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}