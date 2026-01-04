import 'package:flutter/material.dart';
import '../models/models_makanan.dart';
import 'data_makanan.dart';

final ValueNotifier<int> favoriteCountNotifier = ValueNotifier<int>(
  makanan.where((m) => m.isFavorite).length,
);

void updateFavorite(Makanan target, bool isFavorite) {
  final index = makanan.indexWhere((m) => m.name == target.name);
  if (index != -1) {
    makanan[index] = makanan[index].salin(isFavorite: isFavorite);
  }

  favoriteCountNotifier.value =
      makanan.where((m) => m.isFavorite).length;
}