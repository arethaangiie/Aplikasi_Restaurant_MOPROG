import 'package:flutter/material.dart';
import '../models/food_model.dart';

class CheckoutScreen extends StatefulWidget {
  final List<CartItemModel> cartItems;
  final int subtotal;
  final int deliveryFee;
  final int total;
  final VoidCallback onOrderPlaced;

  const CheckoutScreen({
    super.key,
    required this.cartItems,
    required this.subtotal,
    required this.deliveryFee,
    required this.total,
    required this.onOrderPlaced,
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final TextEditingController addressController =
  TextEditingController(text: 'Jl. Merdeka No. 10, Bandung');

  final List<String> paymentMethods = ['Cash', 'E-Wallet', 'Bank Transfer'];
  String selectedPayment = 'Cash';

  @override
  void dispose() {
    addressController.dispose();
    super.dispose();
  }

  IconData paymentIcon(String method) {
    if (method == 'Cash') return Icons.payments;
    if (method == 'E-Wallet') return Icons.account_balance_wallet;
    return Icons.account_balance;
  }

  Widget sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 8),
      child: Text(
        text,
        style: const TextStyle(
          color: kTextDark,
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget priceRow(String label, String value, {bool bold = false}) {
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

  Widget buildPaymentOption(String method) {
    final isSelected = method == selectedPayment;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPayment = method;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? kPrimary : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(paymentIcon(method), color: kPrimary),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                method,
                style: const TextStyle(
                  color: kTextDark,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Icon(
              isSelected ? Icons.check_circle : Icons.circle_outlined,
              color: isSelected ? kPrimary : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  void placeOrder() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),
              const Icon(Icons.check_circle, color: kSuccess, size: 80),
              const SizedBox(height: 12),
              const Text(
                'Pesanan Berhasil!',
                style: TextStyle(
                  color: kTextDark,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Total ${formatRupiah(widget.total)}\nPembayaran: $selectedPayment',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
          actions: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(ctx); // tutup dialog
                  Navigator.pop(context); // kembali dari checkout
                  widget.onOrderPlaced(); // kosongkan keranjang
                },
                child: const Text('OK'),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        title: const Text('Checkout'),
        backgroundColor: kPrimary,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Ringkasan pesanan
                  sectionTitle('Ringkasan Pesanan'),
                  Card(
                    color: Colors.white,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: widget.cartItems.map((item) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${item.quantity}x ${item.food.name}',
                                        style: const TextStyle(
                                          color: kTextDark,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        item.optionText,
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  formatRupiah(item.total),
                                  style: const TextStyle(
                                    color: kTextDark,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),

                  // Alamat pengiriman
                  sectionTitle('Alamat Pengiriman'),
                  TextField(
                    controller: addressController,
                    maxLines: 2,
                    decoration: InputDecoration(
                      prefixIcon:
                      const Icon(Icons.location_on, color: kPrimary),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  // Metode pembayaran
                  sectionTitle('Metode Pembayaran'),
                  for (final method in paymentMethods)
                    buildPaymentOption(method),
                ],
              ),
            ),
          ),

          // Total dan tombol Place Order
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
            ),
            child: SafeArea(
              top: false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  priceRow('Subtotal', formatRupiah(widget.subtotal)),
                  priceRow('Delivery Fee', formatRupiah(widget.deliveryFee)),
                  const Divider(),
                  priceRow('Total Pembayaran', formatRupiah(widget.total),
                      bold: true),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: placeOrder,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text(
                        'Place Order',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}