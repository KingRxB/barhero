import 'package:flutter/material.dart';
import '../api/marvel_api.dart';
import 'profile_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final ApiService _apiService = ApiService();
  final TextEditingController _queryController = TextEditingController();
  bool _isLoading = false;
  String? _error;

  Future<void> _fetchProfileAndNavigate(String query) async {
    if (query.isEmpty) {
      setState(() => _error = "Masukkan Username atau UID pemain.");
      return;
    }

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final profile = await _apiService.fetchProfile(query.trim());
      
      if (mounted) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProfileDetailScreen(profile: profile),
          ),
        );
      }

    } catch (e) {
      setState(() => _error = e.toString().replaceFirst('Exception: ', ''));
    } finally {
      if(mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BarHero Search', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Header
            Center(
              child: Text(
                'MARVEL RIVALS STATS', 
                style: TextStyle(
                  fontSize: 28, 
                  fontWeight: FontWeight.w900, 
                  color: Colors.redAccent[100]
                )
              ),
            ),
            const SizedBox(height: 40),

            // Input Nickname / UID
            TextField(
              controller: _queryController,
              decoration: const InputDecoration(
                labelText: 'Username atau UID',
                hintText: 'Cth: player1234',
                prefixIcon: Icon(Icons.person_search, color: Colors.redAccent),
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 20),

            // Tombol Cari
            ElevatedButton.icon(
              icon: _isLoading ? const SizedBox(
                width: 20, height: 20, 
                child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
              ) : const Icon(Icons.search),
              label: Text(
                _isLoading ? 'Mencari...' : 'Cari BarHero',
                style: const TextStyle(fontSize: 18),
              ),
              onPressed: _isLoading ? null : () => _fetchProfileAndNavigate(_queryController.text),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 20),
            
            // Error Message
            if (_error != null)
              Center(
                child: Text(
                  'Error: $_error',
                  style: const TextStyle(color: Colors.amber, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }
}