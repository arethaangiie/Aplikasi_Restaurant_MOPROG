import 'package:flutter/material.dart';
import '../models/food_model.dart';
import '../widgets/food_card.dart';
import 'detail_menu_screen.dart';

class MenuScreen extends StatefulWidget {
  final String initialCategory;
  final void Function(CartItemModel) onAddToCart;

  const MenuScreen({
    super.key,
    required this.initialCategory,
    required this.onAddToCart,
  });

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  late String selectedCategory;
  String searchText = '';

  final List<String> categoryList = [
    'All',
    'Foods',
    'Drinks',
    'Bakery',
    'Dessert',
  ];

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.initialCategory;
  }

  @override
  Widget build(BuildContext context) {
    // Filter makanan berdasarkan kategori dan teks pencarian
    final foods = dummyFoods.where((food) {
      final matchCategory =
          selectedCategory == 'All' || food.category == selectedCategory;
      final matchName =
      food.name.toLowerCase().contains(searchText.toLowerCase());
      return matchCategory && matchName;
    }).toList();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Menu Restoran',
              style: TextStyle(
                color: kTextDark,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            // Kolom pencarian
            TextField(
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Cari makanan...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Filter kategori
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categoryList.length,
                itemBuilder: (context, index) {
                  final category = categoryList[index];
                  final isSelected = category == selectedCategory;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(category),
                      selected: isSelected,
                      showCheckmark: false,
                      selectedColor: kPrimary,
                      backgroundColor: Colors.white,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : kTextDark,
                      ),
                      onSelected: (value) {
                        setState(() {
                          selectedCategory = category;
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),

            // Daftar makanan
            Expanded(
              child: foods.isEmpty
                  ? const Center(
                child: Text(
                  'Menu tidak ditemukan',
                  style: TextStyle(color: Colors.grey),
                ),
              )
                  : GridView.builder(
                itemCount: foods.length,
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (context, index) {
                  final food = foods[index];
                  return FoodCard(
                    food: food,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailMenuScreen(
                            food: food,
                            onAddToCart: widget.onAddToCart,
                          ),
                        ),
                      );
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
}