import 'package:flutter/material.dart';
import '../models/player_profile.dart';

class HistoryScreen extends StatelessWidget {
  final PlayerProfile profile;
  const HistoryScreen({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    if (profile.matchHistory.isEmpty) {
      return Center(
        child: Text(
          'Tidak ada riwayat pertandingan yang tersedia.',
          style: TextStyle(color: Colors.grey[500]),
        ),
      );
    }
    
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: profile.matchHistory.length,
      itemBuilder: (context, index) {
        final match = profile.matchHistory[index];
        final isWin = match.result == 'WIN';
        
        return Card(
          color: isWin ? Colors.green[800]!.withOpacity(0.3) : Colors.red[800]!.withOpacity(0.3),
          margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          child: ListTile(
            leading: Icon(
              isWin ? Icons.emoji_events : Icons.close,
              color: isWin ? Colors.greenAccent : Colors.redAccent,
              size: 30,
            ),
            title: Text(
              match.result,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isWin ? Colors.greenAccent : Colors.redAccent,
              ),
            ),
            subtitle: Text('Kills: ${match.kills} | Durasi: ${match.duration}s',
              style: TextStyle(color: Colors.grey[300]),
            ),
            trailing: Text(match.date, style: TextStyle(color: Colors.grey[400])),
          ),
        );
      },
    );
  }
}