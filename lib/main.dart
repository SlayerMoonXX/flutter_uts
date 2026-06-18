import 'package:flutter/material.dart';
import 'package:flutter_uts/pages/home_page.dart';
import 'package:flutter_uts/pages/profile_page.dart';
import 'package:flutter_uts/pages/add_student_page.dart';
import 'package:flutter/services.dart';
import 'package:flutter_uts/theme/app_colors.dart';

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
      initialRoute: "/home",

      routes: {
        "/home": (context) => const StudentDirectoryPage(),
        "/profile": (context) => const ProfilePage(),
        "/add_student": (context) => const AddStudentPage(),
      },
    
    );
  }
}

