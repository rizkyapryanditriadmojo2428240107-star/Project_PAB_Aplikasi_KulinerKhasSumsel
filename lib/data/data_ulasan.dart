import '../models/models_makanan.dart';

class UlasanMakanan {
  final String isi;
  final int rating; 

  UlasanMakanan({
    required this.isi,
    required this.rating,
  });
}

final Map<String, List<UlasanMakanan>> ulasanMakanan = {};

List<UlasanMakanan> getUlasanFor(Makanan makanan) {
  return List<UlasanMakanan>.from(
    ulasanMakanan[makanan.name] ?? const [],
  );
}

void tambahUlasanFor(
  Makanan makanan,
  String ulasanBaru,
  int rating,
) {
  final list = ulasanMakanan[makanan.name] ?? <UlasanMakanan>[];
  list.add(UlasanMakanan(isi: ulasanBaru, rating: rating));
  ulasanMakanan[makanan.name] = list;
}

double getRataRataRating(Makanan makanan) {
  final list = ulasanMakanan[makanan.name];
  if (list == null || list.isEmpty) return 0.0;

  final total = list.fold<int>(0, (sum, r) => sum + r.rating);
  return total / list.length;
}