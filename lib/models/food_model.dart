import 'package:flutter/material.dart';

// ====== WARNA APLIKASI ======
const Color kPrimary = Color(0xFFB86F52);
const Color kBackground = Color(0xFFF5EEE5);
const Color kTextDark = Color(0xFF3B302A);
const Color kSuccess = Color(0xFF7A8063);

// Ongkos kirim tetap
const int deliveryFee = 10000;
// Takeaway charge
const int takeawayCharge = 2000;

// ====== DAFTAR CABANG ======
const List<String> branches = [
  'noom noom - Tanjung Duren',
  'noom noom - Untar',
  'noom noom - Mal Ciputra',
];

// ====== MODEL MAKANAN ======
class Food {
  final int id;
  final String name;
  final String description;
  final int price;
  final String image;
  final String category;
  final bool isPopular;

  const Food({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.category,
    this.isPopular = false,
  });
}

// ====== MODEL ITEM KERANJANG ======
class CartItemModel {
  final Food food;
  final String size;
  final String topping;
  final String spicy;
  final int unitPrice; // harga satu porsi (sudah termasuk pilihan)
  int quantity;

  CartItemModel({
    required this.food,
    required this.size,
    required this.topping,
    required this.spicy,
    required this.unitPrice,
    this.quantity = 1,
  });

  int get total => unitPrice * quantity;

  String get optionText => '$size • $topping • $spicy';
}


// ====== FORMAT RUPIAH: 65000 -> Rp 65.000 ======
String formatRupiah(int number) {
  final s = number.toString();
  final buffer = StringBuffer();
  for (int i = 0; i < s.length; i++) {
    if (i > 0 && (s.length - i) % 3 == 0) {
      buffer.write('.');
    }
    buffer.write(s[i]);
  }
  return 'Rp $buffer';
}

// ====== DATA DUMMY (silakan ganti nama, harga, gambar) ======
final List<Food> dummyFoods = [
  const Food(
    id: 1,
    name: 'Truffle Mushroom Pasta',
    description: 'Pasta creamy dengan jamur tumis, keju parmesan, dan sentuhan minyak truffle.',
    price: 65000,
    image: 'assets/images/truffle.jpeg',
    category: 'Foods',
    isPopular: true,
  ),
  const Food(
    id: 2,
    name: 'Cheese Burger',
    description: 'Burger daging sapi juicy dengan keju leleh, selada, dan tomat segar.',
    price: 45000,
    image: 'assets/images/burgercheese.jpeg',
    category: 'Foods',
    isPopular: true,
  ),
  const Food(
    id: 3,
    name: 'Creamy Chicken Pasta',
    description:
    'Pasta dengan potongan ayam panggang dalam saus creamy dan keju parmesan.',
    price: 55000,
    image: 'assets/images/chickenpasta.jpg',
    category: 'Foods',
    isPopular: false,
  ),
  const Food(
    id: 4,
    name: 'Spaghetti Carbonara',
    description: 'Spaghetti dengan saus krim, keju parmesan, dan potongan daging asap.',
    price: 50000,
    image: 'assets/images/spagetii.jpg',
    category: 'Pasta',
    isPopular: false,
  ),
  const Food(
    id: 5,
    name: 'Air Mineral',
    description: 'Air mineral kemasan.',
    price: 10000,
    image: 'assets/images/mineral.jpeg',
    category: 'Drinks',
    isPopular: false,
  ),
  const Food(
    id: 6,
    name: 'Chocolate Lava Cake',
    description: 'Kue cokelat hangat dengan lelehan cokelat di dalamnya.',
    price: 28000,
    image: 'assets/images/lavacake.jpeg',
    category: 'Dessert',
    isPopular: false,
  ),
  const Food(
    id: 7,
    name: 'Chicken Katsu Rice',
    description:
    'Nasi hangat dengan chicken katsu renyah, salad segar, dan saus khas.',
    price: 48000,
    image: 'assets/images/katsu.jpeg',
    category: 'Foods',
    isPopular: true,
  ),

  const Food(
    id: 8,
    name: 'Beef Yakiniku Bowl',
    description:
    'Daging sapi panggang dengan saus yakiniku manis gurih yang disajikan bersama nasi.',
    price: 55000,
    image: 'assets/images/yakiniku.jpeg',
    category: 'Foods',
    isPopular: false,
  ),

  const Food(
    id: 9,
    name: 'Chicken Rice Bowl',
    description:
    'Ayam panggang juicy dengan nasi, sayuran segar, dan saus khas restoran.',
    price: 45000,
    image: 'assets/images/ricebowl.jpg',
    category: 'Foods',
    isPopular: false,
  ),

  const Food(
    id: 10,
    name: 'French Fries',
    description:
    'Kentang goreng renyah yang disajikan hangat dengan saus pilihan.',
    price: 25000,
    image: 'assets/images/ff.jpeg',
    category: 'Foods',
    isPopular: false,
  ),

  const Food(
    id: 11,
    name: 'Chicken Wings',
    description:
    'Potongan sayap ayam berbumbu yang gurih dan renyah dengan saus pilihan.',
    price: 35000,
    image: 'assets/images/wings.jpg',
    category: 'Foods',
    isPopular: false,
  ),

  const Food(
    id: 12,
    name: 'Gyoza',
    description:
    'Pangsit khas Jepang berisi ayam dan sayuran yang dimasak hingga renyah.',
    price: 30000,
    image: 'assets/images/gyoza.jpeg',
    category: 'Foods',
    isPopular: false,
  ),

  // DRINKS
  const Food(
    id: 13,
    name: 'Iced Latte',
    description:
    'Perpaduan espresso dan susu creamy yang disajikan dingin dengan es.',
    price: 28000,
    image: 'assets/images/icedlatte.jpg',
    category: 'Drinks',
    isPopular: true,
  ),

  const Food(
    id: 14,
    name: 'Spanish Latte',
    description:
    'Espresso dengan susu creamy dan susu kental manis yang menghasilkan rasa manis dan lembut.',
    price: 32000,
    image: 'assets/images/spanishlatte.jpeg',
    category: 'Drinks',
    isPopular: true,
  ),

  const Food(
    id: 15,
    name: 'Caramel Macchiato',
    description:
    'Espresso dan susu dengan sentuhan saus karamel yang manis dan aromatik.',
    price: 35000,
    image: 'assets/images/caramelmacchiato.jpeg',
    category: 'Drinks',
    isPopular: false,
  ),

  const Food(
    id: 16,
    name: 'Classic Matcha Latte',
    description:
    'Matcha premium yang dipadukan dengan susu segar untuk rasa yang lembut dan creamy.',
    price: 30000,
    image: 'assets/images/classicmatcha.jpeg',
    category: 'Drinks',
    isPopular: true,
  ),

  const Food(
    id: 17,
    name: 'Strawberry Matcha',
    description:
    'Perpaduan matcha premium dan susu stroberi dengan rasa manis dan segar.',
    price: 35000,
    image: 'assets/images/strawberrymatcha.jpeg',
    category: 'Drinks',
    isPopular: true,
  ),

  const Food(
    id: 18,
    name: 'Coconut Matcha',
    description:
    'Matcha lembut yang dipadukan dengan susu kelapa untuk rasa segar dengan sentuhan tropis.',
    price: 34000,
    image: 'assets/images/coconutmatcha.jpeg',
    category: 'Drinks',
    isPopular: false,
  ),

  const Food(
    id: 19,
    name: 'Chocolate',
    description:
    'Minuman cokelat creamy dengan rasa manis yang lembut dan cocok dinikmati dingin maupun hangat.',
    price: 28000,
    image: 'assets/images/chocolate.jpeg',
    category: 'Drinks',
    isPopular: false,
  ),

  // BAKERY
  const Food(
    id: 20,
    name: 'Butter Croissant',
    description:
    'Croissant klasik dengan tekstur renyah di luar, lembut di dalam, dan aroma mentega yang harum.',
    price: 22000,
    image: 'assets/images/croissant.jpeg',
    category: 'Bakery',
    isPopular: true,
  ),

  const Food(
    id: 21,
    name: 'Pistachio Croissant',
    description:
    'Croissant renyah berisi krim pistachio dan diberi taburan pistachio di atasnya.',
    price: 32000,
    image: 'assets/images/pistachiocroissant.jpeg',
    category: 'Bakery',
    isPopular: false,
  ),

  const Food(
    id: 22,
    name: 'Cinnamon Roll',
    description:
    'Roti lembut dengan isian kayu manis dan lapisan glaze manis di atasnya.',
    price: 26000,
    image: 'assets/images/cinnamonroll.jpeg',
    category: 'Bakery',
    isPopular: false,
  ),

  const Food(
    id: 23,
    name: 'Chocolate Croffle',
    description:
    'Croffle renyah yang disajikan hangat dengan saus cokelat dan taburan gula.',
    price: 29000,
    image: 'assets/images/chocolatecroffle.jpeg',
    category: 'Bakery',
    isPopular: false,
  ),

  // DESSERT
  const Food(
    id: 24,
    name: 'Matcha Tiramisu',
    description:
    'Tiramisu lembut dengan lapisan krim mascarpone dan taburan matcha premium.',
    price: 34000,
    image: 'assets/images/matchatiramisu.jpeg',
    category: 'Dessert',
    isPopular: true,
  ),

  const Food(
    id: 25,
    name: 'Basque Cheesecake',
    description:
    'Cheesecake lembut dengan bagian atas caramelized dan tekstur creamy di dalam.',
    price: 32000,
    image: 'assets/images/basquecheesecake.jpeg',
    category: 'Dessert',
    isPopular: false,
  ),

  const Food(
    id: 26,
    name: 'Croffle & Ice Cream',
    description:
    'Croffle hangat dan renyah yang disajikan bersama es krim vanilla dan topping pilihan.',
    price: 35000,
    image: 'assets/images/croffleicecream.jpeg',
    category: 'Dessert',
    isPopular: false,
  ),
];