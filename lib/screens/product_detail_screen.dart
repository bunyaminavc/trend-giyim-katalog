import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/cart_service.dart';
import '../services/favorites_service.dart';
import '../widgets/product_image.dart';

/// Ürün detayı ekranı.
/// Named route + Route Arguments kullanımı (ModalRoute.settings.arguments).
class ProductDetailScreen extends StatefulWidget {
  static const routeName = '/product-detail';

  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String? _selectedSize;
  String? _selectedColor;

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)!.settings.arguments as Product;
    _selectedSize ??= product.sizes.first;
    _selectedColor ??= product.colors.first;
    final isFavorite = FavoritesService.instance.isFavorite(product);

    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.redAccent : null,
            ),
            onPressed: () {
              setState(() => FavoritesService.instance.toggle(product));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 280,
              color: product.color.withValues(alpha: 0.12),
              child: ProductImage(
                product: product,
                iconSize: 110,
                fit: BoxFit.contain,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.category,
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${product.price.toStringAsFixed(2)} TL',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: product.color,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Açıklama',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 6),
                  Text(product.description),
                  const SizedBox(height: 20),
                  const Text(
                    'Beden Seç',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: product.sizes.map((size) {
                      final selected = size == _selectedSize;
                      return ChoiceChip(
                        label: Text(size),
                        selected: selected,
                        onSelected: (_) =>
                            setState(() => _selectedSize = size),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Renk Seç',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: product.colors.map((color) {
                      final selected = color == _selectedColor;
                      return ChoiceChip(
                        label: Text(color),
                        selected: selected,
                        onSelected: (_) =>
                            setState(() => _selectedColor = color),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton.icon(
            icon: const Icon(Icons.add_shopping_cart),
            label: const Text('Sepete Ekle'),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(48),
              backgroundColor: product.color,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              CartService.instance.addToCart(
                product,
                _selectedSize!,
                _selectedColor!,
              );
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${product.name} sepete eklendi')),
              );
            },
          ),
        ),
      ),
    );
  }
}
