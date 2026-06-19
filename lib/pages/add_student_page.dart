import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../data/app_data.dart';
import '../models/student.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

class AddStudentPage extends StatefulWidget {
  const AddStudentPage({super.key});

  @override
  State<AddStudentPage> createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  late String _selectedAvatar;
  String? _selectedDomisili;
  bool _consentChecked = false;
  // ignore: unused_field
  bool _submitted = false;

  @override
  void initState() {
    super.initState();
    _selectedAvatar = avatarList[Random().nextInt(avatarList.length)];
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _submit() {
    setState(() {
      _submitted = true;
    });
    if (_formKey.currentState!.validate()) {
      final newStudent = Student(
        name: _nameController.text.trim(),
        avatar: _selectedAvatar,
        domisili: _selectedDomisili ?? domisiliList[0],
        phone: _phoneController.text.trim(),
      );
      Navigator.pop(context, newStudent);
    }
  }

  @override
  Widget build(BuildContext context) {
    // GestureDetector untuk menghilangkan fokus keyboard saat tap di luar area input
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.background,
          elevation: 0,
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.greenPrimary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
          title: Text(
            'Tambah Mahasiswa',
            style: AppTypography.headlineBold.copyWith(color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // Avatar (Tanpa Glow, Border Hijau Solid)
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.greenPrimary,
                        width: 3,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: AppColors.card,
                      child: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: _selectedAvatar,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                          placeholder: (_, __) => const Icon(
                            Icons.person,
                            color: AppColors.textSecondary,
                            size: 44,
                          ),
                          errorWidget: (_, __, ___) => const Icon(
                            Icons.person,
                            color: AppColors.textSecondary,
                            size: 44,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Form Card (Tanpa Border Card & Tanpa Shadow)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.card,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Nama Lengkap
                        _buildLabel('Nama Lengkap'),
                        const SizedBox(height: 8),
                        _buildTextField(
                          controller: _nameController,
                          hintText: 'Contoh: Joko Widudu',
                          suffixIcon: Icons.person_outline,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Mohon masukkan nama lengkap';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 18),

                        // Domisili
                        _buildLabel('Domisili'),
                        const SizedBox(height: 8),
                        _buildDropdown(),
                        const SizedBox(height: 18),

                        // Nomor Telepon
                        _buildLabel('Nomor Telepon'),
                        const SizedBox(height: 8),
                        _buildTextField(
                          controller: _phoneController,
                          hintText: 'Masukkan nomor telepon',
                          suffixIcon: Icons.phone_outlined,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Mohon masukkan nomor telepon';
                            }
                            if (value.length < 11) {
                              return 'Nomor Telepon Tidak Valid';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 18),

                        // Consent checkbox
                        GestureDetector(
                          onTap: () => setState(
                            () => _consentChecked = !_consentChecked,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 22,
                                height: 22,
                                child: Checkbox(
                                  value: _consentChecked,
                                  onChanged: (val) => setState(
                                    () => _consentChecked = val ?? false,
                                  ),
                                  activeColor: AppColors.bluePrimary,
                                  checkColor: Colors.white,
                                  side: const BorderSide(
                                    color: AppColors.bluePrimary,
                                    width: 1.5,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  'Saya menyatakan bahwa data yang saya masukkan adalah benar.',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.75),
                                    fontSize: 12.5,
                                    height: 1.4,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 90),

                  // Submit button
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton.icon(
                      // Tombol hanya bisa diklik jika consentChecked bernilai true
                      onPressed: _consentChecked ? _submit : null,
                      icon: const Icon(Icons.person_add_alt_1, size: 20),
                      label: const Text(
                        'Tambahkan Mahasiswa',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.3,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.bluePrimary,
                        disabledBackgroundColor: const Color(0xFF2E2E4E),
                        foregroundColor: Colors.white,
                        disabledForegroundColor: Colors.white.withOpacity(0.3),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: AppTypography.textSemiBold.copyWith(color: AppColors.textPrimary),
    );
  }

  // Fungsi TextField yang sudah dimodifikasi dengan icon error dan border biru
  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData suffixIcon,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
  }) {
    return FormField<String>(
      initialValue: controller.text,
      validator: validator,
      builder: (FormFieldState<String> state) {
        return TextField(
          controller: controller,
          style: AppTypography.textRegular.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          onChanged: (val) {
            state.didChange(val);
          },
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              color: AppColors.textSecondary, // Warna Hint yang bisa dibaca
              fontSize: 14,
            ),
            filled: true,
            fillColor: AppColors.background,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            suffixIcon: Icon(
              suffixIcon,
              color: AppColors.textSecondary,
              size: 19,
            ),

            // Icon Tanda Seru Merah saat Error
            // Icon Tanda Seru Merah saat Error
            error: state.hasError
                ? Transform.translate(
                    // 👇 Offset(X, Y)
                    // X = Geser kiri/kanan (Minus = Kiri, Positif = Kanan)
                    // Y = Geser atas/bawah (Minus = Atas, Positif = Bawah)
                    offset: const Offset(
                      -16.0,
                      0,
                    ), // Contoh: Geser paksa 8 pixel ke kiri
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.info_outline_rounded,
                          color: AppColors.redPrimary,
                          size: 16,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          state.errorText ?? '',
                          style: const TextStyle(
                            color: AppColors.redPrimary,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  )
                : null,

            // Semua border diatur menjadi warna BIRU
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: AppColors.bluePrimary,
                width: 1.5,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.gray, width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: AppColors.bluePrimary,
                width: 1.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: AppColors.redPrimary,
                width: 1.5,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: AppColors.redPrimary,
                width: 1.5,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedDomisili,
      dropdownColor: AppColors.card,
      style: AppTypography.textRegular.copyWith(color: AppColors.textPrimary),
      icon: const Icon(
        Icons.keyboard_arrow_down_rounded,
        color: AppColors.textSecondary,
      ),

      // Menggunakan properti hint agar warnanya pasti berubah
      hint: const Text(
        'Pilih kota tempat tinggal',
        style: TextStyle(
          color: AppColors.textSecondary, // Warna Hint yang bisa dibaca
          fontSize: 14,
        ),
      ),

      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.background,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),

        // Semua border diatur menjadi warna BIRU
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.gray, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.gray, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: AppColors.bluePrimary,
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.redPrimary, width: 1.5),
        ),
        errorStyle: const TextStyle(color: AppColors.redPrimary, fontSize: 11),
      ),
      items: domisiliList
          .map((d) => DropdownMenuItem(value: d, child: Text(d)))
          .toList(),
      onChanged: (val) => setState(() => _selectedDomisili = val),
      validator: (value) {
        if (value == null) return 'Pilih domisili';
        return null;
      },
    );
  }
}
