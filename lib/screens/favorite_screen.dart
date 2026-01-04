import 'package:flutter/material.dart';
import '../data/data_makanan.dart';
import '../data/data_favorite.dart';   
import '../widgets/card_makanan.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    final favoriteFoods =
        makanan.where((m) => m.isFavorite).toList(growable: false);

    return Scaffold(
      backgroundColor: const Color(0xFFECE2D3),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),

            Expanded(
              child: favoriteFoods.isEmpty
                  ? const Center(
                      child: Text(
                        'Belum ada makanan favorite.',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 8,
                      ),
                      itemCount: favoriteFoods.length,
                      itemBuilder: (context, index) {
                        final item = favoriteFoods[index];
                        return MakananCard(
                          item: item,
                          onFavoriteTap: () {
                            setState(() {
                              // toggle favorite lewat helper
                              updateFavorite(item, !item.isFavorite);
                            });
                          },
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
          Text(
            'Favorite',
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