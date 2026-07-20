import 'package:flutter/material.dart';
import '../services/cart_service.dart';
import 'cart_screen.dart';
import 'favorites_screen.dart';
import 'home_screen.dart';

/// Uygulamanın ana iskeleti: alttaki "Mağaza / Favoriler / Sepet"
/// navigasyon çubuğu ile üç ana ekran arasında geçiş sağlar.
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomeScreen(),
    FavoritesScreen(),
    CartScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: AnimatedBuilder(
        // CartService bir ChangeNotifier'dır; sepet her değiştiğinde
        // (başka bir ekrandan eklense bile) rozet sayısı burada güncellenir.
        animation: CartService.instance,
        builder: (context, _) {
          final cartCount = CartService.instance.totalItemCount;
          return BottomNavigationBar(
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,
            onTap: (index) => setState(() => _currentIndex = index),
            items: [
              const BottomNavigationBarItem(
                icon: Icon(Icons.storefront_outlined),
                activeIcon: Icon(Icons.storefront),
                label: 'Mağaza',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border),
                activeIcon: Icon(Icons.favorite),
                label: 'Favoriler',
              ),
              BottomNavigationBarItem(
                icon: _CartIcon(count: cartCount, filled: false),
                activeIcon: _CartIcon(count: cartCount, filled: true),
                label: 'Sepet',
              ),
            ],
          );
        },
      ),
    );
  }
}

/// Sepet sekmesi ikonu; üzerinde ürün adedini gösteren küçük bir rozet içerir.
class _CartIcon extends StatelessWidget {
  final int count;
  final bool filled;

  const _CartIcon({required this.count, required this.filled});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Icon(filled ? Icons.shopping_bag : Icons.shopping_bag_outlined),
        if (count > 0)
          Positioned(
            right: -6,
            top: -4,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: const BoxDecoration(
                color: Colors.redAccent,
                shape: BoxShape.circle,
              ),
              constraints: const BoxConstraints(minWidth: 14, minHeight: 14),
              child: Text(
                '$count',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 9),
              ),
            ),
          ),
      ],
    );
  }
}
