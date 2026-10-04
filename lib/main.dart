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
            foregroundColor: Colors.white,
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
      final index = cartItems.indexWhere((item) =>
      item.food.id == newItem.food.id &&
          item.size == newItem.size &&
          item.topping == newItem.topping &&
          item.spicy == newItem.spicy);

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
    return Scaffold(
      body: getPage(),
      bottomNavigationBar: BottomNavigationBar(
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
    );
  }
}