import 'package:flutter/material.dart';
import 'package:kuliner_palembang/utils/auth_guard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/models_makanan.dart';
import '../data/data_favorite.dart';    
import '../data/data_ulasan.dart';   

class DetailScreen extends StatefulWidget {
  final Makanan makanan;

  const DetailScreen({
    super.key,
    required this.makanan,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late bool _isFavorite = false;
  late List<UlasanMakanan> _reviews;
  final TextEditingController _ulasanController = TextEditingController();
  int _selectedRating = 5;
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.makanan.isFavorite;
    _reviews = getUlasanFor(widget.makanan);
    _loadLoginState();
  }

  Future<void> _loadLoginState() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isLoggedIn = prefs.getBool('is_logged_in') ?? false;
    });
  }

  @override
  void dispose() {
    _ulasanController.dispose();
    super.dispose();
  }

  Future<void> _toggleFavorite() async {
    final loggedIn = await ensureLoggedIn(context);
    if (!loggedIn) return;

    setState(() {
      _isFavorite = !_isFavorite;
      updateFavorite(widget.makanan, _isFavorite);
    });
  }

  void _addReview() {
    if (!_isLoggedIn) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Silakan login terlebih dahulu untuk menambahkan ulasan.'),
        ),
      );
      return;
    }

    final text = _ulasanController.text.trim();
    if (text.isEmpty) return;
    if (_selectedRating == 0) return;

    setState(() {
      final baru = UlasanMakanan(isi: text, rating: _selectedRating);
      _reviews.add(baru);
    });

    tambahUlasanFor(widget.makanan, text, _selectedRating);
    _ulasanController.clear();
    _selectedRating = 5;
  }

  @override
  Widget build(BuildContext context) {
    final makanan = widget.makanan;

    final double avgRating =
        _reviews.isEmpty ? 0.0 : _reviews.fold<double>(0, (sum, r) => sum + r.rating) / _reviews.length;
    final int fullStars = avgRating.floor();

    return Scaffold(
      backgroundColor: const Color(0xFFECE2D3),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE7643A),
        elevation: 0,
        title: Text(
          makanan.name,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFFDF8EE),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: makanan.borderColor,
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 6,
                offset: const Offset(0, 3),
                color: Colors.black.withOpacity(0.08),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // FOTO ATAS
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(22),
                ),
                child: Image.asset(
                  makanan.imageAsset,
                  width: double.infinity,
                  height: 220,
                  fit: BoxFit.cover,
                ),
              ),

              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // NAMA + FAVORITE
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            makanan.name,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: _toggleFavorite,
                          borderRadius: BorderRadius.circular(100),
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: _isFavorite
                                    ? Colors.red
                                    : Colors.black87,
                                width: 1.4,
                              ),
                            ),
                            child: Icon(
                              _isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              size: 22,
                              color:
                                  _isFavorite ? Colors.red : Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // INFO LOGIN
                    if (!_isLoggedIn)
                      const Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          'Silakan login untuk dapat menambahkan favorit dan ulasan.',
                          style: TextStyle(
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                            color: Colors.black87,
                          ),
                        ),
                      ),

                    // RATING RATA-RATA
                    if (avgRating == 0.0)
                      const Text(
                        'Belum ada rating',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    else
                      Row(
                        children: [
                          const Text(
                            'Rate : ',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          ...List.generate(5, (index) {
                            return Icon(
                              index < fullStars
                                  ? Icons.star
                                  : Icons.star_border,
                              size: 18,
                              color: Colors.amber[700],
                            );
                          }),
                          const SizedBox(width: 6),
                          Text(
                            avgRating.toStringAsFixed(1),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(height: 12),

                    // DESKRIPSI
                    Text(
                      makanan.description,
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 20),

                    _sectionList(
                      title: 'Bahan',
                      content: makanan.bahan,
                      numbered: false,
                    ),
                    _sectionList(
                      title: 'Cara Membuat',
                      content: makanan.caraMembuat,
                      numbered: true,
                    ),

                    _buildUlasanSection(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionList({
    required String title,
    required String content,
    required bool numbered,
  }) {
    final lines = content
      .split('\n')
      .map((e) => e.trim())
      .where((e) => e.isNotEmpty)
      .toList();
      
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.black12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(lines.length, (index) {
              // Buang bullet/nomor lama dari teks sumber
              final cleaned = lines[index]
                  .replaceFirst(RegExp(r'^[-•\d\.\s]+'), '')
                  .trim();

              return Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      numbered ? '${index + 1}.' : '•',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        cleaned,
                        style: const TextStyle(
                          fontSize: 14,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
        const SizedBox(height: 18),
      ],
    );
  }

  Widget _buildUlasanSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Ulasan',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),

        // LIST ULASAN
        if (_reviews.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.black12),
            ),
            child: const Text(
              'Belum ada ulasan. Jadilah yang pertama memberikan ulasan!',
              style: TextStyle(fontSize: 14),
            ),
          )
        else
          Column(
            children: _reviews.map((r) {
              return Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.black12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(
                          index < r.rating
                              ? Icons.star
                              : Icons.star_border,
                          size: 16,
                          color: Colors.amber[700],
                        );
                      }),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      r.isi,
                      style: const TextStyle(
                        fontSize: 14,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),

        const SizedBox(height: 12),

        // INPUT ULASAN + PILIH RATING
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.black26),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Tambah Ulasan & Rating',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  ...List.generate(5, (index) {
                    final starValue = index + 1;
                    return IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: Icon(
                        starValue <= _selectedRating
                            ? Icons.star
                            : Icons.star_border,
                        color: Colors.amber[700],
                      ),
                      onPressed: !_isLoggedIn
                          ? () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Silakan login untuk memberi rating.'),
                                ),
                              );
                            }
                          : () {
                              setState(() {
                                _selectedRating = starValue;
                              });
                            },
                    );
                  }),
                  const SizedBox(width: 8),
                  Text(
                    '$_selectedRating / 5',
                    style: const TextStyle(fontSize: 13),
                  ),
                ],
              ),
              TextField(
                controller: _ulasanController,
                enabled: _isLoggedIn,
                minLines: 1,
                maxLines: 3,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: _isLoggedIn
                      ? 'Tulis ulasanmu di sini...'
                      : 'Login untuk menulis ulasan...',
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: _addReview,
                  icon: const Icon(Icons.send),
                  color: const Color(0xFFE7643A),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}