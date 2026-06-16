import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xff121212), // Background utama gelap
        colorScheme: const ColorScheme.dark().copyWith(
          primary: const Color(0xff00cc99), // Hijau Toska
          secondary: const Color(0xff2979ff), // Biru Aksen
        ),
      ),
      home: const SiakadHomepage(),
    );
  }
}

class SiakadHomepage extends StatelessWidget {
  const SiakadHomepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. HEADER SECTION (Nama diubah menjadi Student Directory)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: const TextSpan(
                          text: 'Student ',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          children: [
                            TextSpan(
                              text: 'Directory',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                        'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=100'),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // 2. MY ACADEMIC OVERVIEW CARD
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xff1e1e1e),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'My academic overview',
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildOverviewStat('IPK Semester', '3.80'),
                        _buildOverviewStat('Total SKS', '65'),
                        _buildOverviewStat('Class Attendance', '92%'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // 3. MAIN ACTIONS SECTION (Menu Student Directory dihapus, kolom disesuaikan menjadi 3)
              const Text(
                'Main Actions',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3, // Diubah menjadi 3 kolom agar layout tetap seimbang
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.9, // Penyesuaian rasio kotak menu
                children: [
                  _buildActionButton(Icons.calendar_month, 'Class\nSchedule', const Color(0xff1c2d27), const Color(0xff00cc99)),
                  _buildActionButton(Icons.description, 'View\nGrades', const Color(0xff1c2d27), const Color(0xff00cc99)),
                  _buildActionButton(Icons.person, 'Profile\nManagement', const Color(0xff1c2d27), const Color(0xff00cc99)),
                ],
              ),
              const SizedBox(height: 24),

              // 4. RECENT ACTIVITY SECTION
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Recent Activity',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('See all', style: TextStyle(color: Color(0xff00cc99))),
                  ),
                ],
              ),
              _buildActivityItem(
                title: 'Grade for Mobile UX released',
                subtitle: 'Jakarta Selatan, Selatan',
                time: '20 hours ago',
                isFirst: true,
              ),
              _buildActivityItem(
                title: 'Class Cancelled: Advanced DB',
                subtitle: 'Jakarta Selatan',
                time: '17 hours ago',
                isLast: true,
              ),
              const SizedBox(height: 24),

              // 5. FACULTY NEWS SECTION
              const Text(
                'Faculty News',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Container(
                height: 100,
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xff1e1e1e),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Text(
                  'Faculty News have awesome fragment...',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),

      // FLOATING ACTION BUTTON
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xff00cc99),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: const Icon(Icons.add, color: Colors.black),
      ),

      // BOTTOM NAVIGATION BAR
      bottomNavigationBar: Theme(
        data: ThemeData(canvasColor: const Color(0xff181818)),
        child: BottomNavigationBar(
          currentIndex: 0,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color(0xff00cc99),
          unselectedItemColor: Colors.grey,
          selectedFontSize: 11,
          unselectedFontSize: 11,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
            BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Academics'),
            BottomNavigationBarItem(icon: Icon(Icons.credit_card), label: 'Payments'),
            BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'More'),
          ],
        ),
      ),
    );
  }

  // Helper Widget: Stats Ringkas (IPK, SKS, Absen)
  Widget _buildOverviewStat(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(color: Colors.grey, fontSize: 11)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
      ],
    );
  }

  // Helper Widget: Tombol Menu Grid (Main Actions)
  Widget _buildActionButton(IconData icon, String label, Color bgColor, Color iconColor) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: iconColor, size: 24),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 10, color: Colors.white, height: 1.2),
          ),
        ],
      ),
    );
  }

  // Helper Widget: Alur Aktivitas Terbaru (Timeline Style)
  Widget _buildActivityItem({required String title, required String subtitle, required String time, bool isFirst = false, bool isLast = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage('https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=100'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 40,
                color: Colors.grey[800],
              ),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
              const SizedBox(height: 2),
              Text('$subtitle • $time', style: TextStyle(fontSize: 11, color: Colors.grey[500])),
              const SizedBox(height: 16),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.more_horiz, color: Colors.grey),
          onPressed: () {},
        )
      ],
    );
  }
}
