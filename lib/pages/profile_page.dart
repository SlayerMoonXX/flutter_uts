import 'package:flutter/material.dart';
import 'package:flutter_uts/data/app_data.dart';
import 'package:flutter_uts/theme/app_typography.dart';
import 'package:flutter_uts/theme/app_colors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfileState();
}

class _ProfileState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final index = ModalRoute.of(context)!.settings.arguments as int;
    final student = initialStudentsData[index];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.greenPrimary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
          ),
        ),
        centerTitle: true,
        title: Text(
          "Student Profile",
          style: AppTypography.headlineExtraBold,
          selectionColor: AppColors.textPrimary,
        ),
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.all(16),
        child: Column(
          children: [
            SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: AppColors.greenPrimary,
                shape: BoxShape.circle,
              ),
              child: CircleAvatar(
                radius: 60,
                backgroundColor: AppColors.background,
                backgroundImage: NetworkImage(student['avatar']!),
              ),
            ),
            SizedBox(height: 8),
            //Nama
            Text(
              student['name']!,
              style: AppTypography.headlineBold,
              selectionColor: AppColors.textPrimary,
            ),
            Row(
              mainAxisAlignment: .center,
              children: [
                Icon(Icons.location_on, size: 15),
                Text(
                  '${student['domisili']}, Indonesia',
                  style: AppTypography.textRegular,
                  selectionColor: AppColors.textSecondary,
                ),
              ],
            ),
            SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: .start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    //Label
                    "Domisili",
                    style: AppTypography.subHeadlineBold,
                    selectionColor: AppColors.textPrimary,
                  ),
                  const SizedBox(height: 8),
                  //Box
                  Container(
                    padding: EdgeInsets.all(16),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.gray,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      student['domisili']!,
                      style: AppTypography.textBold,
                      selectionColor: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    //Label
                    "Nomor Telepon",
                    style: AppTypography.subHeadlineBold,
                    selectionColor: AppColors.textPrimary,
                  ),
                  const SizedBox(height: 8),
                  //Box
                  Container(
                    padding: EdgeInsets.all(16),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.gray,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      student['phone']!,
                      style: AppTypography.textBold,
                      selectionColor: AppColors.textPrimary,
                    ),
                    //Label
                  ),
                  const SizedBox(height: 16),
                  Text(
                    //Label
                    "Status Akademis",
                    style: AppTypography.subHeadlineBold,
                    selectionColor: AppColors.textPrimary,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: EdgeInsetsGeometry.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.bluePrimary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "Aktif",
                      style: AppTypography.textBold,
                      selectionColor: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 69),
            //Buton Hapus
            GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).clearSnackBars();
                if (initialStudentsData.length <= 3) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Gagal menghapus. Jumlah mahasiswa telah mencapai batas minimum yang diwajibkan',
                      ),
                      backgroundColor: AppColors.redPrimary,
                      behavior: SnackBarBehavior.floating,
                      duration: Duration(seconds: 1),
                      dismissDirection: DismissDirection.horizontal,
                    ),
                  );
                  return;
                }
                initialStudentsData.removeAt(index);
                Navigator.pop(context, true);
              },
              child: Container(
                padding: EdgeInsets.all(16),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.redPrimary,
                ),
                child: Row(
                  mainAxisAlignment: .center,
                  children: [
                    Icon(Icons.delete, size: 20, color: AppColors.textPrimary),
                    const SizedBox(width: 8),
                    Text(
                      "Hapus Akun",
                      style: AppTypography.subHeadlineBold,
                      selectionColor: AppColors.textPrimary,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: .center,
              children: [
                Icon(Icons.info_outline),
                const SizedBox(width: 8),
                Text(
                  "Minimum 3 mahasiswa harus tetap ada dalam daftar.",
                  style: AppTypography.commentRegular,
                  selectionColor: AppColors.textSecondary,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
