import 'package:flutter/material.dart';
import '../models/food_model.dart';

class CartItem extends StatelessWidget {
  final CartItemModel item;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;
  final VoidCallback onRemove;

  const CartItem({
    super.key,
    required this.item,
    required this.onIncrease,
    required this.onDecrease,
    required this.onRemove,
  });

  // Tombol bulat kecil untuk + dan -
  Widget qtyButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: kPrimary),
        ),
        child: Icon(icon, size: 16, color: kPrimary),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                item.food.image,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 80,
                    height: 80,
                    color: Colors.grey[200],
                    child: const Icon(Icons.fastfood, color: Colors.grey),
                  );
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.food.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: kTextDark,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: onRemove,
                        child: const Icon(Icons.delete_outline,
                            color: Colors.grey, size: 22),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    item.optionText,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          formatRupiah(item.total),
                          style: const TextStyle(
                            color: kPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      qtyButton(Icons.remove, onDecrease),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          '${item.quantity}',
                          style: const TextStyle(
                            color: kTextDark,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      qtyButton(Icons.add, onIncrease),
                    ],
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