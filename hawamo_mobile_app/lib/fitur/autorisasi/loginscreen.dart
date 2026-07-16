import 'package:flutter/material.dart';
import 'controllerautorisasi.dart'; // Panggil file otak-nya

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // 1. Controller bawaan Flutter untuk menangkap ketikan di kolom teks
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // 2. Memanggil otak logika (AuthController) yang sudah kita buat tadi
  final AuthController _auth = AuthController();

  // 3. Best Practice: Membersihkan memori saat halaman ditutup
  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // 4. Fungsi yang dipanggil saat tombol diklik
  void _prosesLogin() {
    // Ambil teks yang diketik pengguna
    final username = _usernameController.text;
    final password = _passwordController.text;

    // Suruh otak memproses datanya
    _auth.login(username, password);

    // 5. Cek role dan arahkan
    if (_auth.userRole == 'supir') {
      // (Nanti diganti dengan kode pindah halaman ke Peta GPS)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Berhasil masuk sebagai Supir! Siap kirim barang.')),
      );
    } else if (_auth.userRole == 'admin') {
      // (Nanti diganti dengan kode pindah halaman ke Dashboard)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Berhasil masuk sebagai Pemilik Bisnis!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal: Username atau Password salah!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login Sistem Logistik')),
      // Padding agar tampilan tidak mepet ke pinggir layar HP
      body: Padding(
        padding: const EdgeInsets.all(16.0), 
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Bikin posisi di tengah
          children: [
            // Kolom input Username
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            const SizedBox(height: 16), // Jarak antar elemen
            
            // Kolom input Password
            TextField(
              controller: _passwordController,
              obscureText: true, // Menyamarkan teks menjadi titik-titik (*)
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 32),
            
            // Tombol Masuk
            ElevatedButton(
              onPressed: _prosesLogin, // Panggil fungsi di atas saat diklik
              child: const Text('Masuk'),
            ),
          ],
        ),
      ),
    );
  }
}