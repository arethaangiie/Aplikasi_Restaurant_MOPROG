import 'package:flutter/material.dart';
import '../models/food_model.dart';

class CheckoutScreen extends StatefulWidget {
  final List<CartItemModel> cartItems;
  final int subtotal;
  final int deliveryFee;
  final int total;
  final VoidCallback onOrderPlaced;
  final String orderType;

  const CheckoutScreen({
    super.key,
    required this.cartItems,
    required this.subtotal,
    required this.deliveryFee,
    required this.total,
    required this.onOrderPlaced,
    this.orderType = 'delivery',
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final TextEditingController addressController =
  TextEditingController(text: 'Jl. Merdeka No. 10, Bandung');

  final TextEditingController tableController = TextEditingController();

  String selectedBranch = branches[0];

  late String selectedOrderType;

  final List<String> paymentMethods = ['Cash', 'E-Wallet', 'Bank Transfer'];
  String selectedPayment = 'Cash';

  @override
  void initState() {
    super.initState();
    selectedOrderType = widget.orderType;
  }

  @override
  void dispose() {
    addressController.dispose();
    tableController.dispose();
    super.dispose();
  }

  IconData paymentIcon(String method) {
    if (method == 'Cash') return Icons.payments;
    if (method == 'E-Wallet') return Icons.account_balance_wallet;
    return Icons.account_balance;
  }

  IconData orderTypeIcon(String type) {
    switch (type) {
      case 'dine-in':
        return Icons.restaurant;
      case 'takeaway':
        return Icons.shopping_bag;
      case 'delivery':
      default:
        return Icons.delivery_dining;
    }
  }

  String orderTypeLabel(String type) {
    switch (type) {
      case 'dine-in':
        return 'Dine-In';
      case 'takeaway':
        return 'Takeaway';
      case 'delivery':
      default:
        return 'Delivery';
    }
  }

  String orderTypeDescription(String type) {
    switch (type) {
      case 'dine-in':
        return 'Makan di tempat • Pilih cabang & nomor meja';
      case 'takeaway':
        return 'Bawa pulang • Pilih cabang • +Rp 2.000';
      case 'delivery':
      default:
        return 'Diantar ke alamat • +Rp 10.000';
    }
  }

  int get currentFee {
    switch (selectedOrderType) {
      case 'dine-in':
        return 0;
      case 'takeaway':
        return takeawayCharge;
      case 'delivery':
      default:
        return deliveryFee;
    }
  }

  String get feeLabel {
    switch (selectedOrderType) {
      case 'dine-in':
        return 'Service Charge';
      case 'takeaway':
        return 'Takeaway Charge';
      case 'delivery':
      default:
        return 'Delivery Fee';
    }
  }

  int get currentTotal => widget.subtotal + currentFee;

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

  Widget buildOrderTypeOption(String type) {
    final isSelected = type == selectedOrderType;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedOrderType = type;
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
            Icon(orderTypeIcon(type), color: kPrimary),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    orderTypeLabel(type),
                    style: const TextStyle(
                      color: kTextDark,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    orderTypeDescription(type),
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
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

  Widget buildBranchSelector() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedBranch,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down, color: kPrimary),
          items: branches.map((branch) {
            return DropdownMenuItem<String>(
              value: branch,
              child: Row(
                children: [
                  const Icon(Icons.store, color: kPrimary, size: 20),
                  const SizedBox(width: 10),
                  Text(branch),
                ],
              ),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              selectedBranch = value!;
            });
          },
        ),
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
    // Validasi nomor meja untuk dine-in
    if (selectedOrderType == 'dine-in' && tableController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Mohon isi nomor meja terlebih dahulu'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Validasi alamat untuk delivery
    if (selectedOrderType == 'delivery' &&
        addressController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Mohon isi alamat pengiriman'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Info tambahan untuk dialog
    String extraInfo = '';
    if (selectedOrderType == 'dine-in') {
      extraInfo = 'Cabang: $selectedBranch\nMeja: ${tableController.text}';
    } else if (selectedOrderType == 'takeaway') {
      extraInfo = 'Cabang: $selectedBranch';
    } else {
      extraInfo = 'Alamat: ${addressController.text}';
    }

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
                'Tipe: ${orderTypeLabel(selectedOrderType)}\n'
                    '$extraInfo\n'
                    'Total: ${formatRupiah(currentTotal)}\n'
                    'Pembayaran: $selectedPayment',
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
                  Navigator.pop(ctx);
                  Navigator.pop(context);
                  widget.onOrderPlaced();
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
                  // ===== 1. TIPE PESANAN =====
                  sectionTitle('Tipe Pesanan'),
                  buildOrderTypeOption('dine-in'),
                  buildOrderTypeOption('takeaway'),
                  buildOrderTypeOption('delivery'),

                  // ===== 2. CABANG (dine-in & takeaway) =====
                  if (selectedOrderType == 'dine-in' ||
                      selectedOrderType == 'takeaway') ...[
                    sectionTitle('Pilih Cabang'),
                    buildBranchSelector(),
                  ],

                  // ===== 3. NOMOR MEJA (dine-in only) =====
                  if (selectedOrderType == 'dine-in') ...[
                    sectionTitle('Nomor Meja'),
                    TextField(
                      controller: tableController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.table_restaurant,
                            color: kPrimary),
                        hintText: 'Contoh: 12',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ],

                  // ===== 4. ALAMAT (delivery only) =====
                  if (selectedOrderType == 'delivery') ...[
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
                  ],

                  // ===== 5. RINGKASAN PESANAN =====
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

                  // ===== 6. METODE PEMBAYARAN =====
                  sectionTitle('Metode Pembayaran'),
                  for (final method in paymentMethods)
                    buildPaymentOption(method),
                ],
              ),
            ),
          ),

          // ===== Total & Place Order =====
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
                  priceRow(feeLabel, formatRupiah(currentFee)),
                  const Divider(),
                  priceRow('Total Pembayaran', formatRupiah(currentTotal),
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