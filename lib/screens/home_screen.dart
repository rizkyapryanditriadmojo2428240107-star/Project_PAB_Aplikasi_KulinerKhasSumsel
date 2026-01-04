import 'package:flutter/material.dart';
import 'package:kuliner_palembang/utils/auth_guard.dart';
import '../data/data_makanan.dart';
import '../data/data_favorite.dart';
import '../models/models_makanan.dart';
import '../widgets/card_makanan.dart';
import 'detail_screen.dart';
import '../widgets/app_logo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _searchQuery = '';
  late List<Makanan> _foods;
  final List<String> _categories = const [
    'Semua',
    'Berkuah',
    'Goreng',
    'Camilan',
    'Berat',
    'Non Pedas',
    'Pedas',
  ];

  String _selectedCategory = 'Semua';

  @override
  void initState() {
    super.initState();
    _foods = makanan;
  }

  @override
  Widget build(BuildContext context) {
    final filteredFoods = makanan.where((f) {
      final query = _searchQuery.toLowerCase();

      final matchText =
          f.name.toLowerCase().contains(query) ||
          f.description.toLowerCase().contains(query);

      final matchCategory =
          _selectedCategory == 'Semua' || f.kategori == _selectedCategory;

      return matchText && matchCategory;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFECE2D3),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildSearchField(),
            _buildCategoryChips(),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8.0, vertical: 8.0),
                itemCount: filteredFoods.length,
                itemBuilder: (context, index) {
                  final item = filteredFoods[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailScreen(makanan: item),
                        ),
                      ).then((_) {
                        setState(() {});
                      });
                    },
                    child: MakananCard(
                      item: item,
                      onFavoriteTap: () async {
                        final loggedIn = await ensureLoggedIn(context);
                        if (!loggedIn) return;
                        setState(() {
                          updateFavorite(item, !item.isFavorite);
                        });
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.30,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/bg_kuliner.png',
            fit: BoxFit.cover,
          ),
          Container(color: Colors.black.withOpacity(0.35)),
          const Center(
            child: AppLogo(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return Container(
      color: const Color(0xFFE7643A),
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      child: Container(
        height: 42,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: TextField(
          onChanged: (value) {
            setState(() {
              _searchQuery = value;
            });
          },
          decoration: const InputDecoration(
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search),
            hintText: 'Temukan Makanan',
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryChips() {
    return SizedBox(
      height: 48,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        itemCount: _categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final cat = _categories[index];
          final bool isSelected = _selectedCategory == cat;

          return ChoiceChip(
            label: Text(cat),
            selected: isSelected,
            onSelected: (_) {
              setState(() {
                _selectedCategory = cat;
              });
            },
            selectedColor: const Color(0xFFE7643A),
            backgroundColor: Colors.white,
            labelStyle: TextStyle(
              color: isSelected ? Colors.white : Colors.black87,
              fontWeight: FontWeight.w600,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(
                color: isSelected
                    ? const Color(0xFFE7643A)
                    : Colors.grey.shade400,
              ),
            ),
          );
        },
      ),
    );
  }
}