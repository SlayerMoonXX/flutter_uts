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
    return Scaffold(
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
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
          ),
        ),
        title: Text(
          'Tambah Mahasiswa',
          style: AppTypography.headlineBold.copyWith(
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Avatar
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.greenPrimary,
                      width: 3,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.greenPrimary,
                        blurRadius: 20,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: const Color(0xFF2E2E4E),
                    child: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: _selectedAvatar,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                        placeholder: (_, __) => const Icon(
                          Icons.person,
                          color: Color(0xFF888888),
                          size: 44,
                        ),
                        errorWidget: (_, __, ___) => const Icon(
                          Icons.person,
                          color: Color(0xFF888888),
                          size: 44,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 28),

                // Form Card with blue dashed border
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColors.bluePrimary.withOpacity(0.6),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.bluePrimary.withOpacity(0.08),
                        blurRadius: 20,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Nama
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

                      // Nomor HP
                      _buildLabel('Nomor Telepon'),
                      const SizedBox(height: 8),
                      _buildTextField(
                        controller: _phoneController,
                        hintText: 'Masukkan nomor telepon',
                        suffixIcon: Icons.phone_outlined,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Mohon masukkan nomor telepon';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 18),

                      // Consent checkbox
                      GestureDetector(
                        onTap: () =>
                            setState(() => _consentChecked = !_consentChecked),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 22,
                              height: 22,
                              child: Checkbox(
                                value: _consentChecked,
                                onChanged: (val) => setState(
                                    () => _consentChecked = val ?? false),
                                activeColor: const Color(0xFF2979FF),
                                checkColor: Colors.white,
                                side: const BorderSide(
                                  color: Color(0xFF2979FF),
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

                const SizedBox(height: 28),

                // Submit button
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton.icon(
                    onPressed: _consentChecked ? _submit : null,
                    icon: const Icon(Icons.person_add_rounded, size: 18),
                    label: const Text(
                      'Tambahkan Mahasiswa',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.3,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2979FF),
                      disabledBackgroundColor: const Color(0xFF2E2E4E),
                      foregroundColor: Colors.white,
                      disabledForegroundColor: Colors.white.withOpacity(0.3),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      shadowColor: const Color(0xFF2979FF).withOpacity(0.4),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: AppTypography.textSemiBold.copyWith(
        color: AppColors.textPrimary,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData suffixIcon,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      style: AppTypography.textRegular.copyWith(color: AppColors.textPrimary),
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: AppColors.textSecondary,
          fontSize: 14,
        ),
        filled: true,
        fillColor: AppColors.card,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        suffixIcon: Icon(
          suffixIcon,
          color: AppColors.textSecondary,
          size: 19,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.white.withOpacity(0.1),
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.white.withOpacity(0.1),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Color(0xFF2979FF),
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
        ),
        errorStyle: const TextStyle(color: Colors.redAccent, fontSize: 11),
      ),
      validator: validator,
    );
  }

  Widget _buildDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedDomisili,
      dropdownColor: const Color(0xFF23234A),
      style: const TextStyle(color: Colors.white, fontSize: 14),
      icon: Icon(
        Icons.keyboard_arrow_down_rounded,
        color: Colors.white.withOpacity(0.4),
      ),
      decoration: InputDecoration(
        hintText: 'Pilih kota tempat tinggal',
        hintStyle: TextStyle(
          color: Colors.white.withOpacity(0.35),
          fontSize: 14,
        ),
        filled: true,
        fillColor: const Color(0xFF23234A),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.white.withOpacity(0.1),
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.white.withOpacity(0.1),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Color(0xFF2979FF),
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1),
        ),
        errorStyle: const TextStyle(color: Colors.redAccent, fontSize: 11),
      ),
      items: domisiliList
          .map((d) => DropdownMenuItem(
                value: d,
                child: Text(d),
              ))
          .toList(),
      onChanged: (val) => setState(() => _selectedDomisili = val),
      validator: (value) {
        if (value == null) return 'Pilih domisili';
        return null;
      },
    );
  }
}