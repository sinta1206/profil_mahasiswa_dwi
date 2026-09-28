import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Profile',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFD88C9A)),
        fontFamily: 'Arial',
      ),
      home: const FormMahasiswa(),
    );
  }
}

class FormMahasiswa extends StatefulWidget {
  const FormMahasiswa({super.key});

  @override
  State<FormMahasiswa> createState() => _FormMahasiswaState();
}

class _FormMahasiswaState extends State<FormMahasiswa> {
  final TextEditingController namaController = TextEditingController(
    text: 'Dwi Sasta Cecilia Saragih',
  );

  final TextEditingController npmController = TextEditingController(
    text: '2408007010003',
  );

  final TextEditingController jurusanController = TextEditingController();

  final ImagePicker picker = ImagePicker();

  File? fotoProfil;

  // =========================
  // PILIH FOTO
  // =========================

  Future<void> pilihFoto() async {
    final XFile? foto = await picker.pickImage(source: ImageSource.gallery);

    if (foto != null) {
      setState(() {
        fotoProfil = File(foto.path);
      });
    }
  }

  // =========================
  // SIMPAN DATA
  // =========================

  void simpanData() {
    if (namaController.text.isEmpty ||
        npmController.text.isEmpty ||
        jurusanController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Silakan lengkapi semua data terlebih dahulu!'),
          backgroundColor: const Color(0xFFD88C9A),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );

      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          backgroundColor: Colors.white,
          icon: Container(
            padding: const EdgeInsets.all(15),
            decoration: const BoxDecoration(
              color: Color(0xFFE5F0E5),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_rounded,
              color: Color(0xFF789C78),
              size: 45,
            ),
          ),
          title: const Text(
            'Berhasil Disimpan!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF4F6250),
            ),
          ),
          content: const Text(
            'Data mahasiswa berhasil disimpan.\nSilakan lanjut melihat profil.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey, height: 1.5),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            SizedBox(
              width: 130,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(dialogContext);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilMahasiswa(
                        nama: namaController.text,
                        npm: npmController.text,
                        jurusan: jurusanController.text,
                        foto: fotoProfil,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD88C9A),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  'OK',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    namaController.dispose();
    npmController.dispose();
    jurusanController.dispose();
    super.dispose();
  }

  // =========================
  // INPUT FIELD
  // =========================

  Widget inputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: const Color(0xFFD88C9A)),
        filled: true,
        fillColor: const Color(0xFFFFFBFC),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 18,
          horizontal: 15,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFE8D4D8)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFD88C9A), width: 2),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F3F4),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFD88C9A),
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Student Profile',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.5),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            // =========================
            // HEADER
            // =========================

            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(25, 30, 25, 40),
              decoration: const BoxDecoration(
                color: Color(0xFFD88C9A),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(45),
                  bottomRight: Radius.circular(45),
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello, Mahasiswa! 👋',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Lengkapi profilmu agar data mahasiswa\ntersimpan dengan rapi.',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 15,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            // =========================
            // FORM CARD
            // =========================
            Transform.translate(
              offset: const Offset(0, -20),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Data Diri',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4F6250),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // =========================
                    // FOTO
                    // =========================
                    GestureDetector(
                      onTap: pilihFoto,
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 65,
                            backgroundColor: const Color(0xFFE5F0E5),
                            backgroundImage: fotoProfil != null
                                ? FileImage(fotoProfil!)
                                : null,
                            child: fotoProfil == null
                                ? const Icon(
                                    Icons.person_rounded,
                                    size: 70,
                                    color: Color(0xFF789C78),
                                  )
                                : null,
                          ),

                          Positioned(
                            right: 0,
                            bottom: 5,
                            child: Container(
                              padding: const EdgeInsets.all(11),
                              decoration: const BoxDecoration(
                                color: Color(0xFFD88C9A),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.camera_alt_rounded,
                                color: Colors.white,
                                size: 22,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      'Tap untuk memilih foto profil',
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),

                    const SizedBox(height: 25),

                    inputField(
                      controller: namaController,
                      label: 'Nama Lengkap',
                      hint: 'Masukkan nama lengkap',
                      icon: Icons.person_outline_rounded,
                    ),

                    const SizedBox(height: 15),

                    inputField(
                      controller: npmController,
                      label: 'NPM',
                      hint: 'Masukkan NPM',
                      icon: Icons.badge_outlined,
                    ),

                    const SizedBox(height: 15),

                    inputField(
                      controller: jurusanController,
                      label: 'Jurusan',
                      hint: 'Masukkan jurusan',
                      icon: Icons.school_outlined,
                    ),

                    const SizedBox(height: 25),

                    // =========================
                    // SAVE BUTTON
                    // =========================
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton.icon(
                        onPressed: simpanData,
                        icon: const Icon(Icons.check_circle_outline),
                        label: const Text(
                          'SIMPAN DATA',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF789C78),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================================================
// HALAMAN PROFIL
// ==================================================

class ProfilMahasiswa extends StatelessWidget {
  final String nama;
  final String npm;
  final String jurusan;
  final File? foto;

  const ProfilMahasiswa({
    super.key,
    required this.nama,
    required this.npm,
    required this.jurusan,
    this.foto,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F3F4),

      appBar: AppBar(
        backgroundColor: const Color(0xFFD88C9A),
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'My Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // FOTO PROFIL
            Container(
              padding: const EdgeInsets.all(7),
              decoration: const BoxDecoration(
                color: Color(0xFFE5F0E5),
                shape: BoxShape.circle,
              ),
              child: CircleAvatar(
                radius: 75,
                backgroundColor: Colors.white,
                backgroundImage: foto != null ? FileImage(foto!) : null,
                child: foto == null
                    ? const Icon(
                        Icons.person_rounded,
                        size: 80,
                        color: Color(0xFF789C78),
                      )
                    : null,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              nama,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4F6250),
              ),
            ),

            const SizedBox(height: 5),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
              decoration: BoxDecoration(
                color: const Color(0xFFF3DDE1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'STUDENT PROFILE',
                style: TextStyle(
                  color: Color(0xFFD88C9A),
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  letterSpacing: 1,
                ),
              ),
            ),

            const SizedBox(height: 30),

            // CARD IDENTITAS
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.07),
                    blurRadius: 15,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Identitas Mahasiswa',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4F6250),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // NPM
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE5F0E5),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          backgroundColor: Color(0xFF789C78),
                          child: Icon(
                            Icons.badge_outlined,
                            color: Colors.white,
                          ),
                        ),

                        const SizedBox(width: 15),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'NPM',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              npm,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  // JURUSAN
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8E6E9),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          backgroundColor: Color(0xFFD88C9A),
                          child: Icon(
                            Icons.school_outlined,
                            color: Colors.white,
                          ),
                        ),

                        const SizedBox(width: 15),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Jurusan',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                jurusan,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              '✨ Keep learning, keep growing! ✨',
              style: TextStyle(
                color: Color(0xFF789C78),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
