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
          'No match history available.',
          style: TextStyle(color: Colors.grey[500]),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(12.0),
      itemCount: profile.matchHistory.length,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final match = profile.matchHistory[index];
        return _HistoryCard(match: match);
      },
    );
  }
}

class _HistoryCard extends StatelessWidget {
  const _HistoryCard({required this.match});

  final MatchHistoryItem match;

  @override
  Widget build(BuildContext context) {
    final bool isWin = match.result == 'WIN';
    final Color resultColor = isWin ? Colors.greenAccent : Colors.redAccent;

    return Card(
      color: isWin
          ? Colors.green[800]!.withOpacity(0.3)
          : Colors.red[800]!.withOpacity(0.3),
      elevation: 2,
      child: ListTile(
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isWin ? Icons.check_circle : Icons.cancel,
              color: resultColor,
              size: 24,
            ),
            Text(
              match.result,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: resultColor,
              ),
            ),
          ],
        ),

        title: Text(
          match.heroName.toUpperCase(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 0.5,
          ),
        ),

        subtitle: Text(
          'Kills: ${match.kills} | Duration: ${match.duration}s',
          style: TextStyle(color: Colors.grey[300]),
        ),
        trailing: Text(match.date, style: TextStyle(color: Colors.grey[400])),
      ),
    );
  }
}
