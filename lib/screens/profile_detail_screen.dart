import 'package:flutter/material.dart';
import '../models/player_profile.dart';
import 'history_screen.dart';

class ProfileDetailScreen extends StatelessWidget {
  final PlayerProfile profile;
  const ProfileDetailScreen({super.key, required this.profile});
  
  // Baris Statistik Kustom
  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 16, color: Colors.grey[400])),
          Text(value,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Dua tab: Profile dan History
      child: Scaffold(
        appBar: AppBar(
          title: Text(profile.nickname, style: const TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: Colors.red[900],
          bottom: const TabBar(
            indicatorColor: Colors.redAccent,
            tabs: [
              Tab(icon: Icon(Icons.bar_chart), text: 'Stats Umum'),
              Tab(icon: Icon(Icons.list_alt), text: 'Riwayat Match'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Tab 1: Profile (Stats Umum)
            SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                color: Colors.grey[800],
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('LEVEL ${profile.level}', 
                        style: const TextStyle(
                          fontSize: 32, 
                          fontWeight: FontWeight.w900, 
                          color: Colors.redAccent
                        )
                      ),
                      const Divider(color: Colors.white24, height: 30),
                      _buildStatRow('UID Pemain', profile.uid.toString()),
                      _buildStatRow('Total Pertandingan', profile.totalMatches.toString()),
                      _buildStatRow('Status Rank', 'Belum Diimplementasi'), 
                      _buildStatRow('Terakhir Diperbarui', profile.lastUpdated),
                      const SizedBox(height: 10),
                      Text('Data Rank/Hero Matchup akan ditambahkan di sini.', style: TextStyle(color: Colors.grey[500])),
                    ],
                  ),
                ),
              ),
            ),
            
            // Tab 2: Match History (Menggunakan HistoryScreen)
            HistoryScreen(profile: profile),
          ],
        ),
      ),
    );
  }
}