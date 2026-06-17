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

              Row(
                children: [
                  Icon(Icons.school, color:AppColors.textPrimary, size: 32),
                  SizedBox(width: 14),
                  Text(
                    'Student Directory',
                    style: AppTypography.headlineExtraBold,
                    selectionColor: AppColors.textPrimary,
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
                        color: AppColors.card,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 12,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: AppColors.greenPrimary,
                              shape: BoxShape.circle,
                            ),
                            child: CircleAvatar(
                              radius: 40,
                              backgroundColor: AppColors.background,
                              backgroundImage: NetworkImage(student['avatar']!),
                            ),
                          ),
                          const SizedBox(height: 12),

                          Text(
                            student['name']!,
                            textAlign: TextAlign.center,
                            style: AppTypography.subHeadlineExtraBold,
                            selectionColor: AppColors.textPrimary,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),

                          Text(
                            student['domisili'] ?? '',
                            textAlign: TextAlign.center,
                            style: AppTypography.textRegular,
                            selectionColor: AppColors.text,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 12),

                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 22,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.bluePrimary,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'Aktif',
                              style: AppTypography.textSemiBold,
                              selectionColor: AppColors.textPrimary,
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
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: const Border(
              bottom: BorderSide(
                color: AppColors.greenSecondary,
                width: 6,
              ),
            ),
          ),
          child: SizedBox(
            width: 64,
            height: 64,
            child: FloatingActionButton(
              onPressed: () {},
              backgroundColor: AppColors.greenPrimary,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(Icons.add, color: AppColors.textPrimary, size: 32),
            ),
          ),
        ),
      ),
    );
  }
}
