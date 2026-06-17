import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../data/app_data.dart';
import '../models/student.dart';

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
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF252542),
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF00C9A7),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
          ),
        ),
        title: const Text(
          'Tambah Mahasiswa',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 8),
                // Avatar
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF00C9A7),
                      width: 3,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF00C9A7).withOpacity(0.3),
                        blurRadius: 20,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 55,
                    backgroundColor: const Color(0xFF2E2E4E),
                    child: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: _selectedAvatar,
                        width: 110,
                        height: 110,
                        fit: BoxFit.cover,
                        placeholder: (_, __) => const Icon(
                          Icons.person,
                          color: Color(0xFF888888),
                          size: 50,
                        ),
                        errorWidget: (_, __, ___) => const Icon(
                          Icons.person,
                          color: Color(0xFF888888),
                          size: 50,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 28),

                // Nama
                _buildLabel('Nama Lengkap'),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _nameController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Contoh: Joko Widudu',
                    suffixIcon: Icon(
                      Icons.person_outline,
                      color: Colors.white.withOpacity(0.4),
                      size: 20,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Mohon masukkan nama lengkap';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Domisili
                _buildLabel('Domisili'),
                const SizedBox(height: 6),
                DropdownButtonFormField<String>(
                  value: _selectedDomisili,
                  dropdownColor: const Color(0xFF2E2E4E),
                  style: const TextStyle(color: Colors.white),
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.white.withOpacity(0.4),
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Pilih kota tempat tinggal',
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
                ),
                const SizedBox(height: 16),

                // Nomor HP
                _buildLabel('Nomor Telepon'),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _phoneController,
                  style: const TextStyle(color: Colors.white),
                  keyboardType: TextInputType.phone,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    hintText: 'Masukkan nomor telepon',
                    suffixIcon: Icon(
                      Icons.phone_outlined,
                      color: Colors.white.withOpacity(0.4),
                      size: 20,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Mohon masukkan nomor telepon';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Consent checkbox
                GestureDetector(
                  onTap: () => setState(() => _consentChecked = !_consentChecked),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Checkbox(
                        value: _consentChecked,
                        onChanged: (val) =>
                            setState(() => _consentChecked = val ?? false),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            'Saya menyatakan bahwa data yang saya masukkan adalah benar.',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Submit button
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton.icon(
                    onPressed: _consentChecked ? _submit : null,
                    icon: const Icon(Icons.person_add_rounded, size: 18),
                    label: const Text(
                      'Tambahkan Mahasiswa',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2979FF),
                      disabledBackgroundColor: const Color(0xFF2E2E4E),
                      foregroundColor: Colors.white,
                      disabledForegroundColor: Colors.white.withOpacity(0.3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
