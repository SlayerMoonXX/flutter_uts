import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));
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
        
        scaffoldBackgroundColor: const Color(0xFF1C1C1E), 
      ),
      home: const StudentDirectoryPage(),
    );
  }
}

class StudentDirectoryPage extends StatelessWidget {
  const StudentDirectoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    
    final List<Map<String, String>> students = [
      {
        'name': 'Budi Santoso',
        'region': 'Jakarta Selatan',
        'gender': 'male',
      },
      {
        'name': 'Sari Dewi',
        'region': 'Bekasi',
        'gender': 'female',
      },
      {
        'name': 'Ahmad Fauzi',
        'region': 'Tangerang Selatan',
        'gender': 'male',
      },
      {
        'name': 'Rina Kusuma',
        'region': 'Depok',
        'gender': 'female',
      },
      {
        'name': 'Dian Pratama',
        'region': 'Bogor',
        'gender': 'male',
      },
    ];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              
              Row(
                children: const [
                  Icon(
                    Icons.school, 
                    color: Colors.white,
                    size: 32,
                  ),
                  SizedBox(width: 14),
                  Text(
                    'Student Directory',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              
              Expanded(
                child: GridView.builder(
                  itemCount: students.length,
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, 
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.76, 
                  ),
                  itemBuilder: (context, index) {
                    final student = students[index];
                    return Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF2C2C2E), 
                        borderRadius: BorderRadius.circular(24), 
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          
                          Container(
                            padding: const EdgeInsets.all(3.5), 
                            decoration: const BoxDecoration(
                              color: Color(0xFF00C292), 
                              shape: BoxShape.circle,
                            ),
                            child: CircleAvatar(
                              radius: 40,
                              backgroundColor: const Color(0xFF1C1C1E),
                            
                            ),
                          ),
                          const SizedBox(height: 14),
                          
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
                          
                          Text(
                            student['region']!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Color(0xFF8E8E93), 
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 12),
                          
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 6),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1A80E6), 
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
      
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 6.0, bottom: 10.0),
        child: SizedBox(
          width: 64,
          height: 64,
          child: FloatingActionButton(
            onPressed: () {
              
            },
            backgroundColor: const Color(0xFF00C292), 
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20), 
            ),
            child: const Icon(
              Icons.add,
              color: Colors.white,
              size: 32,
            ),
          ),
        ),
      ),
    );
  }
}
 