import 'package:flutter/material.dart';
import '../models/models_makanan.dart';

class MakananCard extends StatelessWidget {
  final Makanan item;
  final VoidCallback onFavoriteTap;

  const MakananCard({
    super.key,
    required this.item,
    required this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: item.borderColor, width: 2),
        boxShadow: [
          BoxShadow(
            blurRadius: 3,
            offset: const Offset(0, 2),
            color: Colors.black.withOpacity(0.08),
          ),
        ],
      ),

      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(18),
              ),
              child: SizedBox(
                width: 110, 
                child: Image.asset(
                  item.imageAsset,
                  fit: BoxFit.cover, 
                ),
              ),
            ),

            const SizedBox(width: 10),

            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            item.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: onFavoriteTap,
                          child: Icon(
                            item.isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: item.isFavorite ? Colors.red : Colors.black,
                            size: 22,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),

                    Row(
                      children: [
                        _buildTag(item.kategori),
                        const SizedBox(width: 6),
                        _buildTag(item.levelPedas, isSpicy: true),
                      ],
                    ),
                    const SizedBox(height: 6),

                    Text(
                      item.description,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        height: 1.4,
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

  Widget _buildTag(String text, {bool isSpicy = false}) {
    Color bg;
    Color fg;

    if (isSpicy) {
      if (text == 'Pedas') {
        bg = const Color(0xFFFFEBEE);
        fg = const Color(0xFFD32F2F);
      } else if (text == 'Sedang') {
        bg = const Color(0xFFFFF3E0);
        fg = const Color(0xFFF57C00);
      } else {
        bg = const Color(0xFFE8F5E9); 
        fg = const Color(0xFF388E3C);
      }
    } else {
      bg = const Color(0xFFE3F2FD);
      fg = const Color(0xFF1565C0);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: fg,
        ),
      ),
    );
  }
}
