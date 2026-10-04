import 'package:flutter/material.dart';

// ====== WARNA APLIKASI ======
const Color kPrimary = Color(0xFFD32F2F);
const Color kBackground = Color(0xFFFFF8F0);
const Color kTextDark = Color(0xFF3E2723);
const Color kSuccess = Color(0xFF43A047);

// Ongkos kirim tetap
const int deliveryFee = 10000;

// ====== MODEL MAKANAN ======
class Food {
  final int id;
  final String name;
  final String description;
  final int price;
  final String image;
  final String category;

  const Food({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.category,
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
    name: 'Pepperoni Pizza',
    description: 'Pizza dengan saus tomat, keju mozzarella, dan irisan pepperoni gurih.',
    price: 65000,
    image: 'assets/images/food1.jpg',
    category: 'Pizza',
  ),
  const Food(
    id: 2,
    name: 'Cheese Burger',
    description: 'Burger daging sapi juicy dengan keju leleh, selada, dan tomat segar.',
    price: 45000,
    image: 'assets/images/food2.jpg',
    category: 'Burger',
  ),
  const Food(
    id: 3,
    name: 'Crispy Chicken',
    description: 'Ayam goreng tepung renyah di luar dan lembut di dalam.',
    price: 40000,
    image: 'assets/images/food3.jpg',
    category: 'Chicken',
  ),
  const Food(
    id: 4,
    name: 'Spaghetti Carbonara',
    description: 'Spaghetti dengan saus krim, keju parmesan, dan potongan daging asap.',
    price: 50000,
    image: 'assets/images/food4.jpg',
    category: 'Pasta',
  ),
  const Food(
    id: 5,
    name: 'Iced Lemon Tea',
    description: 'Teh dingin segar dengan perasan lemon asli.',
    price: 18000,
    image: 'assets/images/food5.jpg',
    category: 'Drinks',
  ),
  const Food(
    id: 6,
    name: 'Chocolate Lava Cake',
    description: 'Kue cokelat hangat dengan lelehan cokelat di dalamnya.',
    price: 28000,
    image: 'assets/images/food6.jpg',
    category: 'Dessert',
  ),
];