import 'package:flutter/material.dart';
import '../models/food_model.dart';

class DetailMenuScreen extends StatefulWidget {
  final Food food;
  final void Function(CartItemModel) onAddToCart;

  const DetailMenuScreen({
    super.key,
    required this.food,
    required this.onAddToCart,
  });

  @override
  State<DetailMenuScreen> createState() => _DetailMenuScreenState();
}

class _DetailMenuScreenState extends State<DetailMenuScreen> {
  // Pilihan dan harga tambahannya
  final Map<String, int> sizes = {
    'Small': 0,
    'Medium': 10000,
    'Large': 20000,
  };
  final Map<String, int> toppings = {
    'No Topping': 0,
    'Cheese': 5000,
    'Mushroom': 5000,
    'Chicken': 8000,
  };
  final Map<String, int> spicyLevels = {
    'Not Spicy': 0,
    'Medium': 0,
    'Hot': 0,
  };

  String selectedSize = 'Small';
  String selectedTopping = 'No Topping';
  String selectedSpicy = 'Not Spicy';
  int quantity = 1;

  // Harga satu porsi = harga dasar + tambahan size + tambahan topping
  int get unitPrice =>
      widget.food.price + sizes[selectedSize]! + toppings[selectedTopping]!;

  // Total harga = harga satu porsi x jumlah
  int get totalPrice => unitPrice * quantity;

  void addToCart() {
    final item = CartItemModel(
      food: widget.food,
      size: selectedSize,
      topping: selectedTopping,
      spicy: selectedSpicy,
      unitPrice: unitPrice,
      quantity: quantity,
    );

    widget.onAddToCart(item);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${widget.food.name} ditambahkan ke keranjang'),
        backgroundColor: kSuccess,
        duration: const Duration(seconds: 2),
      ),
    );

    Navigator.pop(context);
  }

  // Grup pilihan (ChoiceChip) dengan judul
  Widget buildOptionGroup(
      String title,
      Map<String, int> options,
      String selected,
      void Function(String) onSelected,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: kTextDark,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: options.keys.map((key) {
            final extra = options[key]!;
            final isSelected = key == selected;
            final label = extra > 0 ? '$key (+${formatRupiah(extra)})' : key;
            return ChoiceChip(
              label: Text(label),
              selected: isSelected,
              showCheckmark: false,
              selectedColor: kPrimary,
              backgroundColor: Colors.white,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : kTextDark,
                fontSize: 13,
              ),
              onSelected: (value) => onSelected(key),
            );
          }).toList(),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget qtyButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: kPrimary, width: 1.5),
        ),
        child: Icon(icon, color: kPrimary, size: 20),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final food = widget.food;

    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        title: const Text('Detail Menu'),
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
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      food.image,
                      height: 220,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 220,
                          width: double.infinity,
                          color: Colors.grey[200],
                          child: const Icon(Icons.fastfood,
                              size: 64, color: Colors.grey),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    food.name,
                    style: const TextStyle(
                      color: kTextDark,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    formatRupiah(food.price),
                    style: const TextStyle(
                      color: kPrimary,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    food.description,
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  const SizedBox(height: 20),

                  if (food.category == 'Drinks') ...[
                    buildOptionGroup(
                      'Ukuran',
                      sizes,
                      selectedSize,
                          (value) {
                        setState(() {
                          selectedSize = value;
                        });
                      },
                    ),
                  ],

                  if (food.category == 'Foods') ...[
                    buildOptionGroup(
                      'Ukuran',
                      sizes,
                      selectedSize,
                          (value) {
                        setState(() {
                          selectedSize = value;
                        });
                      },
                    ),

                    buildOptionGroup(
                      'Topping',
                      toppings,
                      selectedTopping,
                          (value) {
                        setState(() {
                          selectedTopping = value;
                        });
                      },
                    ),

                    buildOptionGroup(
                      'Level Pedas',
                      spicyLevels,
                      selectedSpicy,
                          (value) {
                        setState(() {
                          selectedSpicy = value;
                        });
                      },
                    ),
                  ],
                ],
              ),
            ),
          ),

          // Bagian bawah: quantity + tombol Add to Cart
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
            ),
            child: SafeArea(
              top: false,
              child: Row(
                children: [
                  qtyButton(Icons.remove, () {
                    setState(() {
                      if (quantity > 1) {
                        quantity--;
                      }
                    });
                  }),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Text(
                      '$quantity',
                      style: const TextStyle(
                        color: kTextDark,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  qtyButton(Icons.add, () {
                    setState(() {
                      quantity++;
                    });
                  }),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: addToCart,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: Text(
                        'Add to Cart • ${formatRupiah(totalPrice)}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
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