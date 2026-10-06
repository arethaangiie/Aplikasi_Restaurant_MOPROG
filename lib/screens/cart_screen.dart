import 'package:flutter/material.dart';
import '../models/food_model.dart';
import '../widgets/cart_item.dart';
import 'checkout_screen.dart';

class CartScreen extends StatelessWidget {
  final List<CartItemModel> cartItems;
  final void Function(CartItemModel) onIncrease;
  final void Function(CartItemModel) onDecrease;
  final void Function(CartItemModel) onRemove;
  final VoidCallback onOrderPlaced;
  final String orderType;

  const CartScreen({
    super.key,
    required this.cartItems,
    required this.onIncrease,
    required this.onDecrease,
    required this.onRemove,
    required this.onOrderPlaced,
    this.orderType = 'delivery',
  });

  int get subtotal =>
      cartItems.fold<int>(0, (sum, item) => sum + item.total);

  int get fee {
    if (cartItems.isEmpty) return 0;
    if (orderType == 'delivery') return deliveryFee;
    if (orderType == 'takeaway') return takeawayCharge;
    return 0; // dine-in
  }

  int get total => subtotal + fee;

  String get feeLabel {
    if (orderType == 'delivery') return 'Delivery Fee';
    if (orderType == 'takeaway') return 'Takeaway Charge';
    return 'Service Charge';
  }

  Widget summaryRow(String label, String value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: bold ? kTextDark : Colors.grey,
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
              fontSize: bold ? 18 : 14,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: bold ? kPrimary : kTextDark,
              fontWeight: bold ? FontWeight.bold : FontWeight.w600,
              fontSize: bold ? 18 : 14,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Keranjang Pesanan',
                style: TextStyle(
                  color: kTextDark,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Daftar item keranjang
          Expanded(
            child: cartItems.isEmpty
                ? const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.shopping_cart_outlined,
                      size: 80, color: Colors.grey),
                  SizedBox(height: 8),
                  Text(
                    'Keranjang masih kosong',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return CartItem(
                  item: item,
                  onIncrease: () => onIncrease(item),
                  onDecrease: () => onDecrease(item),
                  onRemove: () => onRemove(item),
                );
              },
            ),
          ),

          // Ringkasan harga
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
            ),
            child: Column(
              children: [
                summaryRow('Subtotal', formatRupiah(subtotal)),
                summaryRow(feeLabel, formatRupiah(fee)),
                const Divider(),
                summaryRow('Total', formatRupiah(total), bold: true),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: cartItems.isEmpty
                        ? null
                        : () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CheckoutScreen(
                            cartItems:
                            List<CartItemModel>.from(cartItems),
                            subtotal: subtotal,
                            deliveryFee: fee,
                            total: total,
                            onOrderPlaced: onOrderPlaced,
                            orderType: orderType,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text(
                      'Checkout',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}