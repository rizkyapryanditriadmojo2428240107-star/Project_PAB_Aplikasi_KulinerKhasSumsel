import 'package:flutter/material.dart';

class Makanan {
  final String name;
  final String description;
  final String imageAsset;
  final Color borderColor;
  final String bahan;
  final String caraMembuat;
  final bool isFavorite;
  final String kategori;
  final String levelPedas;

  const Makanan({
    required this.name,
    required this.description,
    required this.imageAsset,
    required this.borderColor,
    required this.bahan,
    required this.caraMembuat,
    this.isFavorite = false,
    required this.kategori,
    required this.levelPedas,
  });

  Makanan salin({
    bool? isFavorite,
    String? kategori,
    String? levelPedas,
  }) {
    return Makanan(
      name: name,
      description: description,
      imageAsset: imageAsset,
      borderColor: borderColor,
      bahan: bahan,
      caraMembuat: caraMembuat,
      isFavorite: isFavorite ?? this.isFavorite,
      kategori: kategori ?? this.kategori,
      levelPedas: levelPedas ?? this.levelPedas,
    );
  }
}