import 'package:flutter/material.dart';
import '../models/product.dart';

/// Ürün görselini gösterir. `imagePath` tanımlıysa Image.asset ile gösterir;
/// dosya bulunamazsa veya `imagePath` yoksa otomatik olarak ürünün ikonuna
/// (Product.icon) geri döner. Böylece görsel eksik/hatalı olsa bile uygulama
/// çökmez, sadece ikon gösterilir.
class ProductImage extends StatelessWidget {
  final Product product;
  final double? iconSize;
  final BoxFit fit;

  const ProductImage({
    super.key,
    required this.product,
    this.iconSize,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    final path = product.imagePath;

    if (path == null || path.isEmpty) {
      return Center(
        child: Icon(product.icon, size: iconSize ?? 56, color: product.color),
      );
    }

    return Image.asset(
      path,
      fit: fit,
      width: double.infinity,
      height: double.infinity,
      errorBuilder: (context, error, stackTrace) {
        // Görsel dosyası assets/images/ altında bulunamadıysa ikona düş.
        return Center(
          child:
              Icon(product.icon, size: iconSize ?? 56, color: product.color),
        );
      },
    );
  }
}
