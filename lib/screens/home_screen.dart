import 'package:flutter/material.dart';
import '../models/food_model.dart';
import '../widgets/category_card.dart';
import '../widgets/food_card.dart';
import 'detail_menu_screen.dart';

class HomeScreen extends StatelessWidget {
  final void Function(String) onCategoryTap;
  final void Function(CartItemModel) onAddToCart;

  const HomeScreen({
    super.key,
    required this.onCategoryTap,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    final categories = [
      {'name': 'Pizza', 'icon': Icons.local_pizza},
      {'name': 'Burger', 'icon': Icons.lunch_dining},
      {'name': 'Chicken', 'icon': Icons.set_meal},
      {'name': 'Pasta', 'icon': Icons.ramen_dining},
      {'name': 'Drinks', 'icon': Icons.local_cafe},
      {'name': 'Dessert', 'icon': Icons.icecream},
    ];

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Nama aplikasi
          Row(
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Belom tau namanya apa',
                      style: TextStyle(
                        color: kPrimary,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Pesan makanan favoritmu',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.notifications_none, color: kPrimary),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Banner promo
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: kPrimary,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Diskon 20%',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Untuk pemesanan pertama kamu',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.local_offer, color: Colors.white70, size: 60),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Kategori makanan
          const Text(
            'Kategori',
            style: TextStyle(
              color: kTextDark,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return CategoryCard(
                  name: category['name'] as String,
                  icon: category['icon'] as IconData,
                  onTap: () => onCategoryTap(category['name'] as String),
                );
              },
            ),
          ),
          const SizedBox(height: 16),

          // Rekomendasi makanan
          const Text(
            'Rekomendasi Untukmu',
            style: TextStyle(
              color: kTextDark,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 250,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: dummyFoods.length,
              itemBuilder: (context, index) {
                final food = dummyFoods[index];
                return SizedBox(
                  width: 170,
                  child: FoodCard(
                    food: food,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailMenuScreen(
                            food: food,
                            onAddToCart: onAddToCart,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}