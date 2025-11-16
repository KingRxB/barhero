# BarHero - Aplikasi Stats Marvel Rivals

## ✨ Fitur Utama

- **Papan Peringkat Global**: Menampilkan leaderboard v2 (Top 25 pemain) dengan error handling jika API gagal.
- **Pencarian Pemain**: Mencari pemain berdasarkan Username atau UID.
- **Statistik Detail**: Menampilkan halaman profil yang rapi, mencakup:
  - Info Umum (Rank, Level, Tag Tim)
  - Kalkulasi Win Rate Keseluruhan
  - Kalkulasi KDA (Ranked)
  - Statistik Ranked (Kills, Deaths, Assists, MVP).
- **Riwayat Pertandingan**: Menampilkan daftar 10+ pertandingan terakhir, termasuk hero yang dipakai dan hasil (Menang/Kalah).

## 💻 Teknologi yang Digunakan

- **Flutter (Dart)**: Untuk framework utama aplikasi cross-platform.
- **http package**: Untuk komunikasi dan mengambil data dari REST API.
- **Marvel Rivals API**: (Menggunakan endpoint v1 dan v2).

## 📂 Struktur Kode

Untuk memastikan keterbacaan dan kemudahan pemeliharaan, kode diatur sebagai berikut:

- `/lib/api/`: Berisi kelas servis `MarvelApi` yang bertanggung jawab atas semua permintaan jaringan (network request).
- `/lib/models/`: Berisi model data (`player_profile.dart`, `leaderboard.dart`) untuk mem-parsing respons JSON.
- `/lib/screens/`: Berisi layar UI utama (misalnya `home_screen.dart`, `search_screen.dart`, `profile_detail_screen.dart`).
- `/lib/widgets/`: Berisi komponen UI yang dapat digunakan kembali (reusable) seperti `stat_row.dart` dan `section_header.dart` untuk menjaga file layar tetap bersih dan rapi.

## 🚀 Cara Menjalankan

### 1. Prasyarat

- Flutter SDK (v3.0.0 atau lebih baru)
- Code Editor (seperti VS Code)
- Emulator Android/iOS, atau perangkat fisik.

### 2. Instruksi Setup

**Clone repository:**

```bash

git clone https://github.com/KingRxB/barhero.git
cd barhero
```

**Install dependencies:**

```bash
flutter pub get
```

**Jalankan aplikasi:**

```bash
flutter run
```

### 3. Kunci API

Kunci API (API Key) untuk Marvel Rivals API sudah disertakan (hard-coded) di dalam `lib/api/marvel_api.dart`. Tidak diperlukan pengaturan tambahan untuk menjalankan aplikasi.

## 📲 Download APK (Siap Pakai)

Versi `.apk` yang sudah di-build untuk Android bisa diunduh langsung dari halaman **Releases** di repositori ini.

➡️ [**Klik di sini untuk mengunduh BarHero.apk (v1.0.0)**](#)
