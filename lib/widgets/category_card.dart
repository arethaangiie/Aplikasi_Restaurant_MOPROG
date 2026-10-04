import 'package:flutter/material.dart';
import '../models/food_model.dart';

class CategoryCard extends StatelessWidget {
  final String name;
  final IconData icon;
  final VoidCallback onTap;

  const CategoryCard({
    super.key,
    required this.name,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80,
        margin: const EdgeInsets.only(right: 12),
        child: Column(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 6),
                ],
              ),
              child: Icon(icon, color: kPrimary, size: 32),
            ),
            const SizedBox(height: 8),
            Text(
              name,
              style: const TextStyle(
                color: kTextDark,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}