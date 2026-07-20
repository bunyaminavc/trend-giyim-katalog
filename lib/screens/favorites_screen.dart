import 'package:flutter/material.dart';
import '../data/products_data.dart';
import '../models/product.dart';
import '../services/favorites_service.dart';
import '../widgets/product_card.dart';
import 'product_detail_screen.dart';

/// Favori (beğenilen) ürünlerin listelendiği ekran.
/// FavoritesService bir ChangeNotifier olduğu için AnimatedBuilder ile
/// dinlenir; ürün detayından veya kartlardan favori eklense/çıkarılsa bile
/// bu ekran otomatik güncellenir.
class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  Future<void> _openDetail(BuildContext context, Product product) async {
    await Navigator.pushNamed(
      context,
      ProductDetailScreen.routeName,
      arguments: product,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorilerim')),
      body: AnimatedBuilder(
        animation: FavoritesService.instance,
        builder: (context, _) {
          final favorites =
              FavoritesService.instance.filterFavorites(loadProducts());

          if (favorites.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.favorite_border,
                      size: 72, color: Colors.grey.shade400),
                  const SizedBox(height: 12),
                  const Text('Henüz favori ürününüz yok'),
                  const SizedBox(height: 4),
                  Text(
                    'Ürün kartındaki kalp ikonuna dokunarak ekleyebilirsiniz',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ],
              ),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 14,
              crossAxisSpacing: 14,
              childAspectRatio: 0.72,
            ),
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final product = favorites[index];
              return ProductCard(
                product: product,
                onTap: () => _openDetail(context, product),
              );
            },
          );
        },
      ),
    );
  }
}
