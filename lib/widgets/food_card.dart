import 'package:flutter/material.dart';
import '../models/food_model.dart';

class FoodCard extends StatelessWidget {
  final Food food;
  final VoidCallback onTap;

  const FoodCard({super.key, required this.food, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.white,
        elevation: 3,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar di bagian atas
            Expanded(
              child: Image.asset(
                food.image,
                width: double.infinity,
                fit: BoxFit.cover,
                // Jika file gambar belum ada, tampilkan placeholder
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[200],
                    child: const Center(
                      child: Icon(Icons.fastfood, size: 48, color: Colors.grey),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    food.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: kTextDark,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    formatRupiah(food.price),
                    style: const TextStyle(
                      color: kPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    height: 34,
                    child: ElevatedButton(
                      onPressed: onTap,
                      child: const Text('Detail'),
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