import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/data_favorite.dart';
import 'sign_in_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _nama = 'Pengguna';
  bool _isLoggedIn = false;
  Uint8List? _avatarBytes;

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    final savedName = prefs.getString('user_name') ?? 'Pengguna';
    final isLoggedIn = prefs.getBool('is_logged_in') ?? false;
    final avatarBase64 = prefs.getString('user_avatar_base64');

    Uint8List? avatarBytes;
    if (avatarBase64 != null && avatarBase64.isNotEmpty) {
      avatarBytes = base64Decode(avatarBase64);
    }

    setState(() {
      _isLoggedIn = isLoggedIn;
      if (isLoggedIn) {
        _nama = savedName;
        _avatarBytes = avatarBytes;
      } else {
        _nama = 'Pengguna';
        _avatarBytes = null;
      }
    });
  }

  Future<void> _pickAvatar() async {
    if (!_isLoggedIn) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Silakan login terlebih dahulu untuk mengganti foto.'),
        ),
      );
      return;
    }

    final picker = ImagePicker();
    final XFile? picked =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 70);

    if (picked == null) return;

    final bytes = await picked.readAsBytes();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_avatar_base64', base64Encode(bytes));

    setState(() {
      _avatarBytes = bytes;
    });
  }

  Future<void> _editName() async {
    if (!_isLoggedIn) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Silakan login terlebih dahulu untuk mengubah nama.'),
        ),
      );
      return;
    }

    final controller = TextEditingController(text: _nama);

    final String? newName = await showDialog<String>(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Ubah Nama'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: 'Nama baru',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                final text = controller.text.trim();
                Navigator.pop(context, text.isEmpty ? null : text);
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );

    if (newName != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_name', newName);
      setState(() {
        _nama = newName;
      });
    }
  }

  Future<void> _onAuthButtonTap() async {
    final prefs = await SharedPreferences.getInstance();

    if (_isLoggedIn) {
      await prefs.setBool('is_logged_in', false);

      setState(() {
        _isLoggedIn = false;
        _nama = 'Pengguna';
        _avatarBytes = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Berhasil Sign Out. Silakan Sign In kembali.'),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const SignInScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFECE2D3),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            const SizedBox(height: 30),

            // AVATAR (bisa diganti)
            GestureDetector(
              onTap: _pickAvatar,
              child: CircleAvatar(
                radius: 75,
                backgroundColor: Colors.black12,
                child: _avatarBytes == null
                    ? const Icon(
                        Icons.account_circle,
                        size: 140,
                        color: Colors.black54,
                      )
                    : ClipOval(
                        child: Image.memory(
                          _avatarBytes!,
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
            ),

            const SizedBox(height: 30),

            // KARTU NAMA (tap untuk edit)
            _ProfileInfoCard(
              text: _nama,
              onTap: _editName,
            ),
            const SizedBox(height: 12),

            // KARTU JUMLAH FAVORIT
            ValueListenableBuilder<int>(
              valueListenable: favoriteCountNotifier,
              builder: (context, favoriteCount, _) {
                final text =
                    _isLoggedIn ? '$favoriteCount Favorit' : '0 Favorit';
                return _ProfileInfoCard(text: text);
              },
            ),

            const Spacer(),

            // TOMBOL SIGN IN / SIGN OUT
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: GestureDetector(
                onTap: _onAuthButtonTap,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(_isLoggedIn ? Icons.logout : Icons.login),
                    const SizedBox(width: 6),
                    Text(
                      _isLoggedIn ? 'Sign Out' : 'Sign In',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: const BoxDecoration(
        color: Color(0xFFE7643A),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
      child: const Row(
        children: [
          SizedBox(width: 8),
          Text(
            'Profile',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileInfoCard extends StatelessWidget {
  final String text;
  final VoidCallback? onTap; 

  const _ProfileInfoCard({
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final card = Container(
      width: 260,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFE7643A),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );

    if (onTap == null) return card;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: card,
    );
  }
}