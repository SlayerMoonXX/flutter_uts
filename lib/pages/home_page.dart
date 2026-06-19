import 'package:flutter/material.dart';
import 'package:flutter_uts/theme/app_colors.dart';
import 'package:flutter_uts/theme/app_typography.dart';
import 'package:flutter_uts/data/app_data.dart';

class StudentDirectoryPage extends StatefulWidget {
  const StudentDirectoryPage({super.key});

  @override
  State<StudentDirectoryPage> createState() => _StudentDirectoryState();
}

class _StudentDirectoryState extends State<StudentDirectoryPage> {
  @override
  Widget build(BuildContext context) {
    // Membaca data langsung dari variabel global initialStudentsData
    var students = initialStudentsData;

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
                  const Icon(
                    Icons.school,
                    color: AppColors.textPrimary,
                    size: 32,
                  ),
                  const SizedBox(width: 14),
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
                    childAspectRatio: 0.68,
                  ),
                  itemBuilder: (context, index) {
                    final student = students[index];
                    return GestureDetector(
                      onTap: () async {
                        final result = await Navigator.pushNamed(
                          context,
                          "/profile",
                          arguments: index,
                        );

                        if (!context.mounted) {
                          return;
                        } //Guard Check keaktifan widget
                        if (result == true) {
                          setState(() {
                            students = List.from(initialStudentsData);
                          });

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Profil siswa berhasil dihapus'),
                              backgroundColor: AppColors.greenPrimary,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        }
                      },
                      child: Container(
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
                                backgroundImage: NetworkImage(
                                  student['avatar']!,
                                ),
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
              bottom: BorderSide(color: AppColors.greenSecondary, width: 6),
            ),
          ),
          child: SizedBox(
            width: 64,
            height: 64,
            child: FloatingActionButton(
              onPressed: () async {
                final result = await Navigator.pushNamed(
                  context,
                  "/add_student",
                );

                if (result != null) {
                  setState(() {
                    initialStudentsData.add({
                      'name': (result as dynamic).name,
                      'avatar': (result as dynamic).avatar,
                      'domisili': (result as dynamic).domisili,
                      'phone': (result as dynamic).phone,
                    });
                  });
                }

                if (context.mounted  && result != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        '${(result as dynamic).name} berhasil ditambahkan!',
                      ),
                      backgroundColor: AppColors.greenPrimary,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              },

              backgroundColor: AppColors.greenPrimary,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.add,
                color: AppColors.textPrimary,
                size: 32,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
