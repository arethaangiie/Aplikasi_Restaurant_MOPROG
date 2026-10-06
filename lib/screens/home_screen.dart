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
      {'name': 'Foods', 'icon': Icons.restaurant},
      {'name': 'Drinks', 'icon': Icons.coffee},
      {'name': 'Bakery', 'icon': Icons.bakery_dining_rounded},
      {'name': 'Dessert', 'icon': Icons.icecream},
    ];
    // 1. Filter makanan yang status isPopular-nya true
    final popularFoods = dummyFoods.where((food) => food.isPopular).toList();

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
                      'noom noom',
                      style: TextStyle(
                        color: Color(0xFF3B302A),
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Selamat Siang!',
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
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: kTextDark,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'FIRST BITE, FIRST SIP',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 15),
                      Text(
                        '20% OFF',
                        style: TextStyle(color: Colors.white70, fontSize: 19),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.local_offer, color: Colors.white, size: 55),
              ],
            ),
          ),
          const SizedBox(height: 30),

          // Kategori makanan
          const Text(
            'Explore',
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
          const SizedBox(height: 30),

          // Rekomendasi menu
          const Text(
            'Popular at noom noom',
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
              itemCount: popularFoods.length,
              // <-- Ubah jadi panjang popularFoods
              itemBuilder: (context, index) {
                final food = popularFoods[index]; // <-- Ambil dari popularFoods
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
          const SizedBox(height: 30),

          // 3. Bagian card
          const Text(
            'Special Offers',
            style: TextStyle(
              color: kTextDark,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: [
              buildPromoCard(
                imagePath: 'assets/images/banner.png',
                title: 'Temukan Suasana Favoritmu!',
                onTap: () {},
              ),
              buildPromoCard(
                imagePath: 'assets/images/banner2.png',
                title: 'Segarkan Harimu!',
                onTap: () {},
              ),
              buildPromoCard(
                imagePath: 'assets/images/banner3.png',
                title: 'Teman Santai Seharian',
                onTap: () {},
              ),
              buildPromoCard(
                imagePath: 'assets/images/banner4.png',
                title: 'Hangat dari Oven',
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Widget pembantu untuk kartu promo
  Widget buildPromoCard({
    required String imagePath,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      width: 300,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              child: Image.asset(
                imagePath,
                height: 160,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
