import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_uts/theme/app_colors.dart';
import 'package:flutter_uts/theme/app_typography.dart';
import 'package:flutter_uts/data/app_data.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const StudentDirectoryApp());
}

class StudentDirectoryApp extends StatelessWidget {
  const StudentDirectoryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.background,
      ),
      home: const StudentDirectoryPage(),
    );
  }
}

class StudentDirectoryPage extends StatelessWidget {
  const StudentDirectoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final students = initialStudentsData;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              // Header: Icon Topi Toga + Teks Student Directory
              Row(
                children: [
                  Icon(
                    Icons.school, // Icon representasi topi toga
                    color: Colors.white,
                    size: 32,
                  ),
                  SizedBox(width: 14),
                  Text(
                    'Student Directory',
                    style: AppTypography.headlineExtraBold,
                    selectionColor: AppColors.textPrimary,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Grid Layout Komponen Kartu Mahasiswa
              Expanded(
                child: GridView.builder(
                  itemCount: students.length,
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Membagi menjadi 2 kolom vertikal
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio:
                        0.76, // Rasio dimensi kartu agar pas tanpa overflow
                  ),
                  itemBuilder: (context, index) {
                    final student = students[index];
                    return Container(
                      decoration: BoxDecoration(
                        color: const Color(
                          0xFF2C2C2E,
                        ), // Warna abu-abu gelap pembungkus kartu
                        borderRadius: BorderRadius.circular(
                          24,
                        ), // Sudut tumpul melengkung halus
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 12,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Efek Border/Ring Hijau Toska Lingkaran Foto Profil
                          Container(
                            padding: const EdgeInsets.all(3.5),
                            decoration: const BoxDecoration(
                              color: Color(
                                0xFF00C292,
                              ), // Warna hijau cerah khusus ring luar
                              shape: BoxShape.circle,
                            ),
                            child: CircleAvatar(
                              radius: 40,
                              backgroundColor: const Color(0xFF1C1C1E),
                              backgroundImage: NetworkImage(
                                student['avatar']!
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),
                          // Nama Lengkap Mahasiswa
                          Text(
                            student['name']!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          // Asal Daerah / Domisili
                          Text(
                            student['domisili'] ?? '',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Color(
                                0xFF8E8E93,
                              ), // Warna abu-abu pudar teks deskripsi
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 12),
                          // Pill Button Status Aktif
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 22,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(
                                0xFF1A80E6,
                              ), // Warna biru solid tombol "Aktif"
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Text(
                              'Aktif',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      // Floating Action Button (FAB) Kustom Hijau Toska di Pojok Kanan Bawah
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 6.0, bottom: 10.0),
        child: SizedBox(
          width: 64,
          height: 64,
          child: FloatingActionButton(
            onPressed: () {
              // Tempat menaruh fungsi aksi ketika tombol tambah diklik
            },
            backgroundColor: const Color(
              0xFF00C292,
            ), // Hijau cerah matching ring profil
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                20,
              ), // Bentuk kotak membulat persis gambar
            ),
            child: const Icon(Icons.add, color: Colors.white, size: 32),
          ),
        ),
      ),
    );
  }
}
