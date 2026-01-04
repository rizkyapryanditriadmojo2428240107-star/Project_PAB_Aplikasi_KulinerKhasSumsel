import '../models/models_makanan.dart';
import 'package:flutter/material.dart';

final List<Makanan> makanan = [
  Makanan(
    name: 'Pempek',
    description: '''
      Pempek merupakan makanan khas Palembang yang paling terkenal, terbuat dari campuran daging ikan giling dan tepung sagu. Teksturnya kenyal dan gurih, biasanya disajikan bersama kuah cuko berwarna hitam kecokelatan dengan rasa asam, manis, dan pedas.''',
    imageAsset: 'assets/images/pempek.jpg',
    borderColor: Colors.orange,
    isFavorite: false,
    bahan: '''
      - Daging ikan giling
      - Tepung sagu
      - Air es
      - Garam
      - Gula
    ''',
    caraMembuat: '''
      1. Campurkan ikan giling dengan air es, garam, dan gula, aduk hingga halus.
      2. Masukkan tepung sagu sedikit demi sedikit sampai adonan kalis.
      3. Bentuk adonan sesuai selera (lenjer, kapal selam, dan lain-lain).
      4. Rebus dalam air mendidih hingga mengapung, angkat. Bisa digoreng sebelum disajikan.
      5. Kuah cuko: rebus gula aren, air, asam jawa, cabai rawit, dan bawang putih hingga mendidih dan sedikit mengental, lalu saring.
    ''',
    kategori: 'Goreng',
    levelPedas: 'Sedang',
  ),

  Makanan(
    name: 'Laksan',
    description: '''
      Laksan adalah hidangan berbahan dasar pempek lenjer yang diiris dan disajikan dengan kuah santan merah yang gurih dan sedikit pedas. Biasanya disantap sebagai menu sarapan atau makan siang.
    ''',
    imageAsset: 'assets/images/laksan.jpg',
    borderColor: Colors.red,
    isFavorite: false,
    bahan: '''
      - Pempek lenjer
      - Santan
      - Cabai merah
      - Bawang merah
      - Bawang putih
      - Ebi
      - Garam
    ''',
    caraMembuat: '''
      1. Iris pempek lenjer sesuai selera, sisihkan.
      2. Haluskan cabai merah, bawang merah, bawang putih, dan ebi.
      3. Tumis bumbu halus hingga harum.
      4. Masukkan santan dan garam, masak sambil diaduk hingga mendidih.
      5. Sajikan irisan pempek dengan kuah santan panas.
    ''',
    kategori: 'Berkuah',
    levelPedas: 'Pedas',
  ),

  Makanan(
    name: 'Celimpungan',
    description: '''
      Celimpungan merupakan makanan khas Palembang yang mirip dengan laksan, tetapi menggunakan bulatan kecil dari adonan ikan dan sagu. Disajikan dengan kuah santan kuning yang gurih dan kaya rempah, dengan tekstur pempek yang lembut dan rasa ikan yang kuat.
    ''',
    imageAsset: 'assets/images/celimpungan.jpg',
    borderColor: Colors.green,
    isFavorite: false,
    bahan: '''
      - Ikan giling
      - Tepung sagu
      - Santan
      - Kunyit
      - Bawang merah
      - Bawang putih
      - Garam
    ''',
    caraMembuat: '''
      1. Campur ikan giling dan tepung sagu, bentuk bulat-bulat kecil.
      2. Rebus bulatan adonan hingga matang dan mengapung, tiriskan.
      3. Haluskan bawang merah, bawang putih, dan kunyit, kemudian tumis hingga harum.
      4. Masukkan santan dan garam, masak hingga mendidih.
      5. Masukkan celimpungan ke dalam kuah, masak sebentar, lalu sajikan hangat.
    ''',
    kategori: 'Berkuah',
    levelPedas: 'Tidak Pedas',
  ),

  Makanan(
    name: 'Tekwan',
    description: '''
      Tekwan adalah sup khas Palembang yang berisi bakso ikan kecil-kecil dengan kuah kaldu udang bening. Biasanya disajikan dengan soun, jamur, serta taburan bawang goreng sehingga rasanya gurih dan segar.
    ''',
    imageAsset: 'assets/images/tekwan.jpg',
    borderColor: Colors.blue,
    isFavorite: false,
    bahan: '''
      - Ikan giling
      - Tepung sagu
      - Udang untuk kaldu
      - Jamur kuping
      - Soun
      - Bawang putih
      - Garam dan merica
    ''',
    caraMembuat: '''
      1. Buat adonan dari ikan giling dan tepung sagu, bentuk kecil-kecil seperti bakso.
      2. Rebus kepala/kulit udang untuk membuat kaldu, saring.
      3. Masukkan bakso ikan ke dalam kaldu, masak hingga mengapung.
      4. Tambahkan jamur kuping dan soun.
      5. Bumbui dengan bawang putih goreng, garam, dan merica, lalu sajikan selagi hangat.
    ''',
    kategori: 'Berkuah',
    levelPedas: 'Tidak Pedas',
  ),

  Makanan(
    name: 'Model',
    description: '''
      Model merupakan variasi dari tekwan dengan bakso ikan yang berukuran lebih besar dan biasanya berisi tahu. Hidangan ini disajikan dengan kuah bening gurih dari kaldu udang dan pelengkap sayuran.
    ''',
    imageAsset: 'assets/images/model.jpg',
    borderColor: Colors.purple,
    isFavorite: false,
    bahan: '''
      - Ikan giling
      - Tepung sagu
      - Tahu (untuk isian)
      - Udang (untuk kaldu)
      - Jamur dan soun (opsional)
      - Bawang putih
      - Garam dan merica
    ''',
    caraMembuat: '''
      1. Campur ikan giling dan tepung sagu hingga menjadi adonan yang bisa dibentuk.
      2. Isi tahu dengan adonan ikan, bentuk sesuai selera.
      3. Rebus udang untuk membuat kaldu, lalu saring.
      4. Masukkan model (tahu isi ikan) ke dalam kaldu dan masak hingga matang.
      5. Tambahkan pelengkap seperti jamur dan soun bila diinginkan, bumbui dan sajikan hangat.
    ''',
    kategori: 'Berkuah',
    levelPedas: 'Tidak Pedas',
  ),

  Makanan(
    name: 'Lakso',
    description: '''
      Lakso adalah makanan khas Palembang berupa mi tebal dari campuran tepung beras dan sagu, disajikan dengan kuah santan kuning yang gurih. Cita rasanya mirip laksan namun menggunakan mi lakso sebagai pengganti pempek.
    ''',
    imageAsset: 'assets/images/lakso.jpg',
    borderColor: Colors.teal,
    isFavorite: false,
    bahan: '''
      - Tepung beras
      - Tepung sagu
      - Udang (untuk kaldu)
      - Santan
      - Kunyit
      - Bawang merah
      - Bawang putih
    ''',
    caraMembuat: '''
      1. Campur tepung beras dan tepung sagu dengan air hingga menjadi adonan, lalu cetak menjadi mi dan kukus hingga matang.
      2. Rebus udang untuk membuat kaldu, saring.
      3. Haluskan bawang merah, bawang putih, dan kunyit, kemudian tumis hingga harum.
      4. Masukkan kaldu dan santan, masak hingga mendidih sambil diaduk.
      5. Sajikan mi lakso dalam mangkuk, siram dengan kuah santan udang panas.
    ''',
    kategori: 'Berkuah',
    levelPedas: 'Tidak Pedas',
  ),
  

  Makanan(
    name: 'Mie Celor',
    description: '''
      Mie celor adalah mi kuning tebal khas Palembang yang disajikan dengan kuah santan udang yang kental. Biasanya dilengkapi telur rebus, tauge, dan taburan bawang goreng sehingga rasanya gurih dan creamy.''',
    imageAsset: 'assets/images/mie_celor.jpg',
    borderColor: Colors.brown,
    isFavorite: false,
    bahan: '''
      - Mi kuning
      - Udang
      - Santan
      - Telur
      - Tauge
      - Bawang putih
      - Garam dan merica
    ''',
    caraMembuat: '''
      1. Rebus udang untuk mendapatkan kaldu, angkat udangnya dan sisihkan.
      2. Tumis bawang putih, lalu masukkan kaldu udang dan santan, bumbui dengan garam dan merica.
      3. Masak kuah hingga sedikit mengental.
      4. Rebus mi kuning dan tauge sampai matang, tiriskan.
      5. Sajikan mi dalam mangkuk, siram dengan kuah santan udang, tambahkan udang, telur rebus, tauge, dan bawang goreng.
    ''',
    kategori: 'Berat',
    levelPedas: 'Sedang',
  ),

  Makanan(
    name: 'Pindang Patin',
    description: '''
      Pindang patin adalah masakan ikan patin berkuah dengan cita rasa asam pedas yang segar. Kuahnya kaya rempah dan sering diberi tambahan nanas sehingga menambah kesegaran.
    ''',
    imageAsset: 'assets/images/pindang_patin.jpg',
    borderColor: Colors.indigo,
    isFavorite: false,
    bahan: '''
      - Ikan patin
      - Nanas
      - Cabai
      - Bawang merah
      - Bawang putih
      - Kunyit
      - Serai
      - Garam
    ''',
    caraMembuat: '''
      1. Haluskan bawang merah, bawang putih, cabai, dan kunyit.
      2. Tumis bumbu halus hingga harum.
      3. Masukkan air, irisan nanas, dan serai, masak hingga mendidih.
      4. Masukkan potongan ikan patin, bumbui dengan garam.
      5. Masak hingga ikan matang dan bumbu meresap, sajikan selagi panas.
    ''',
    kategori: 'Berkuah',
    levelPedas: 'Pedas',
  ),

  Makanan(
    name: 'Es Kacang Merah',
    description: '''
      Es kacang merah adalah minuman penutup khas Palembang yang menyegarkan, berisi kacang merah rebus yang empuk dengan sirup manis, susu, dan es batu. Cocok dinikmati saat cuaca panas.
    ''',
    imageAsset: 'assets/images/es_kacang_merah.jpg',
    borderColor: Colors.pink,
    isFavorite: false,
    bahan: '''
      - Kacang merah
      - Gula
      - Sirup merah
      - Susu kental manis
      - Es batu
    ''',
    caraMembuat: '''
      1. Rebus kacang merah hingga empuk, tiriskan.
      2. Siapkan gelas, masukkan kacang merah.
      3. Tambahkan sirup merah dan susu kental manis.
      4. Tambahkan es batu sesuai selera, aduk sebelum disajikan.
    ''',
    kategori: 'Non Pedas',
    levelPedas: 'Tidak Pedas',
  ),

  Makanan(
    name: 'Bolu Kojo',
    description: '''
      Bolu kojo adalah kue tradisional Palembang berwarna hijau karena menggunakan daun pandan atau suji. Teksturnya lembut dan aromanya harum, sering disajikan pada acara adat dan perayaan keluarga.
    ''',
    imageAsset: 'assets/images/bolu_kojo.jpg',
    borderColor: Colors.cyan,
    isFavorite: false,
    bahan: '''
      - Telur
      - Gula
      - Santan
      - Tepung terigu
      - Daun pandan / suji
    ''',
    caraMembuat: '''
      1. Kocok telur dan gula hingga mengembang.
      2. Masukkan santan dan sari daun pandan/suji, aduk rata.
      3. Tambahkan tepung terigu, aduk hingga tidak bergerindil.
      4. Tuang adonan ke loyang yang sudah dioles, panggang hingga matang.
    ''',
    kategori: 'Camilan',
    levelPedas: 'Tidak Pedas',
  ),

  Makanan(
    name: 'Maksuba',
    description: '''
      Maksuba merupakan kue lapis khas Palembang yang terkenal mewah karena menggunakan banyak telur dan mentega. Teksturnya sangat legit dan manis, biasanya disajikan pada acara besar dan pernikahan adat.
    ''',
    imageAsset: 'assets/images/maksuba.jpg',
    borderColor: Colors.deepOrange,
    isFavorite: false,
    bahan: '''
      - Telur bebek
      - Gula
      - Mentega
    ''',
    caraMembuat: '''
      1. Kocok telur dan gula hingga kental.
      2. Tuang sedikit adonan ke loyang, panggang tipis hingga matang.
      3. Oles permukaan dengan mentega, tuang adonan lagi di atasnya.
      4. Ulangi proses hingga adonan habis dan membentuk lapisan-lapisan.
      5. Dinginkan lalu potong dan sajikan.
    ''',
    kategori: 'Camilan',
    levelPedas: 'Tidak Pedas',
  ),
];