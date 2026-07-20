import 'package:flutter/material.dart';
import '../services/cart_service.dart';
import '../widgets/product_image.dart';

/// Sepet ekranı: sepetteki ürünleri listeler, adet arttırma/azaltma,
/// ürün çıkarma ve "sipariş tamamlama" (simülasyon) işlemini yönetir.
///
/// CartService bir ChangeNotifier olduğu için ekran, AnimatedBuilder ile
/// dinleniyor: sepet başka bir ekrandan (ör. ürün detayından) değişse bile
/// bu ekran otomatik güncellenir.
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  void _checkout(BuildContext context) {
    CartService.instance.clear();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Siparişiniz alındı (simülasyon)')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sepetim')),
      body: AnimatedBuilder(
        animation: CartService.instance,
        builder: (context, _) {
          final items = CartService.instance.items;

          if (items.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.shopping_bag_outlined,
                      size: 72, color: Colors.grey.shade400),
                  const SizedBox(height: 12),
                  const Text('Sepetiniz boş'),
                  const SizedBox(height: 4),
                  Text(
                    'Ürün eklemek için Mağaza sekmesine dönün',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(28),
                        child: Container(
                          width: 48,
                          height: 48,
                          color: item.product.color.withOpacity(0.15),
                          child: ProductImage(
                            product: item.product,
                            iconSize: 24,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.product.name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Beden: ${item.selectedSize}  ·  Renk: ${item.selectedColor}',
                              style: TextStyle(
                                  fontSize: 12, color: Colors.grey.shade600),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              '${item.totalPrice.toStringAsFixed(2)} TL',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                visualDensity: VisualDensity.compact,
                                icon:
                                    const Icon(Icons.remove_circle_outline),
                                onPressed: () =>
                                    CartService.instance.decrementQuantity(index),
                              ),
                              Text('${item.quantity}'),
                              IconButton(
                                visualDensity: VisualDensity.compact,
                                icon: const Icon(Icons.add_circle_outline),
                                onPressed: () =>
                                    CartService.instance.incrementQuantity(index),
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () =>
                                CartService.instance.removeAt(index),
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.redAccent,
                              visualDensity: VisualDensity.compact,
                            ),
                            child: const Text('Kaldır'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: AnimatedBuilder(
        animation: CartService.instance,
        builder: (context, _) {
          if (CartService.instance.items.isEmpty) {
            return const SizedBox.shrink();
          }
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Toplam',
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      Text(
                        '${CartService.instance.totalPrice.toStringAsFixed(2)} TL',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(48),
                    ),
                    onPressed: () => _checkout(context),
                    child: const Text('Siparişi Tamamla'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
