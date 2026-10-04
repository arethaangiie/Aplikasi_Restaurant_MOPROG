import 'package:flutter/material.dart';

import 'models/food_model.dart';
import 'screens/home_screen.dart';
import 'screens/menu_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/profile_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: kPrimary),
        scaffoldBackgroundColor: kBackground,
        // Semua ElevatedButton otomatis merah dan rounded
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kPrimary,
            foregroundColor: Color(0xFFF4EBDD),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  String menuCategory = 'All';

  // Data keranjang disimpan di sini
  final List<CartItemModel> cartItems = [];

  // Tambah ke keranjang (jika item sama, jumlahnya ditambah)
  void addToCart(CartItemModel newItem) {
    setState(() {
      final index = cartItems.indexWhere(
        (item) =>
            item.food.id == newItem.food.id &&
            item.size == newItem.size &&
            item.topping == newItem.topping &&
            item.spicy == newItem.spicy,
      );

      if (index >= 0) {
        cartItems[index].quantity += newItem.quantity;
      } else {
        cartItems.add(newItem);
      }
    });
  }

  void increaseQuantity(CartItemModel item) {
    setState(() {
      item.quantity++;
    });
  }

  void decreaseQuantity(CartItemModel item) {
    setState(() {
      if (item.quantity > 1) {
        item.quantity--;
      }
    });
  }

  void removeItem(CartItemModel item) {
    setState(() {
      cartItems.remove(item);
    });
  }

  void clearCart() {
    setState(() {
      cartItems.clear();
    });
  }

  // Dipanggil saat kategori di Home ditekan -> pindah ke tab Menu
  void openMenuWithCategory(String category) {
    setState(() {
      menuCategory = category;
      currentIndex = 1;
    });
  }

  Widget getPage() {
    switch (currentIndex) {
      case 0:
        return HomeScreen(
          onCategoryTap: openMenuWithCategory,
          onAddToCart: addToCart,
        );
      case 1:
        return MenuScreen(
          initialCategory: menuCategory,
          onAddToCart: addToCart,
        );
      case 2:
        return CartScreen(
          cartItems: cartItems,
          onIncrease: increaseQuantity,
          onDecrease: decreaseQuantity,
          onRemove: removeItem,
          onOrderPlaced: clearCart,
        );
      default:
        return const ProfileScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    // 1. Hitung total item & total harga secara dinamis
    bool hasItems = cartItems.isNotEmpty;
    double totalPrice = cartItems.fold(
      0,
      (sum, item) => sum + (item.food.price * item.quantity),
    );
    int totalQuantity = cartItems.fold(0, (sum, item) => sum + item.quantity);

    // 2. Tentukan apakah keranjang melayang muncul (Hanya di tab Home [0] & Menu [1] jika ada isinya)
    bool showFloatingCart =
        (currentIndex == 0 || currentIndex == 1) && hasItems;
    return Scaffold(
      body: getPage(),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 3. Widget Floating Cart Bar di atas BottomNavigationBar
          if (showFloatingCart)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: kPrimary,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.shopping_bag,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '$totalQuantity item di keranjang',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            'Rp ${totalPrice.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: kPrimary,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        currentIndex = 2; // Pindah otomatis ke tab Cart
                      });
                    },
                    child: const Text(
                      'Lihat Cart',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),

          // 4. Bottom Navigation Bar Bawaan
          BottomNavigationBar(
            currentIndex: currentIndex,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: kPrimary,
            unselectedItemColor: Colors.grey,
            onTap: (index) {
              setState(() {
                currentIndex = index;
                if (index == 1) {
                  menuCategory = 'All';
                }
              });
            },
            items: [
              const BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.restaurant_menu),
                label: 'Menu',
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.shopping_cart),
                label: 'Cart (${cartItems.length})',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
