import 'package:flutter/material.dart';

/// Kıyafet ürününü temsil eden model sınıfı.
/// Eğitimdeki "JSON mantığı ve model sınıfı oluşturma" hedefine uygun olarak
/// fromJson / toJson metodları içerir.
class Product {
  final int id;
  final String name;
  final String category;
  final double price;
  final String description;
  final IconData icon;
  final Color color;
  final List<String> sizes;
  final List<String> colors;

  /// Assets klasöründeki ürün görselinin yolu (ör. 'assets/images/beyaztisort.webp').
  /// Görsel bulunamazsa arayüz otomatik olarak [icon]'a geri döner.
  final String? imagePath;

  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.description,
    required this.icon,
    required this.color,
    required this.sizes,
    required this.colors,
    this.imagePath,
  });

  /// JSON (Map) verisinden Product nesnesi oluşturur.
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      name: json['name'] as String,
      category: json['category'] as String,
      price: (json['price'] as num).toDouble(),
      description: json['description'] as String,
      icon: _iconFromKey(json['iconKey'] as String),
      color: _colorFromKey(json['colorKey'] as String),
      sizes: List<String>.from(json['sizes'] as List),
      colors: List<String>.from(json['colors'] as List),
      imagePath: json['imagePath'] as String?,
    );
  }

  /// Product nesnesini JSON (Map) formatına çevirir.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'price': price,
      'description': description,
      'iconKey': _iconKey(icon),
      'colorKey': _colorKey(color),
      'sizes': sizes,
      'colors': colors,
      'imagePath': imagePath,
    };
  }

  static IconData _iconFromKey(String key) {
    switch (key) {
      case 'tshirt':
        return Icons.checkroom;
      case 'jacket':
        return Icons.dry_cleaning;
      case 'pants':
        return Icons.line_style;
      case 'dress':
        return Icons.woman;
      case 'shoes':
        return Icons.hiking;
      case 'bag':
        return Icons.shopping_bag;
      default:
        return Icons.checkroom;
    }
  }

  static String _iconKey(IconData icon) {
    if (icon == Icons.checkroom) return 'tshirt';
    if (icon == Icons.dry_cleaning) return 'jacket';
    if (icon == Icons.line_style) return 'pants';
    if (icon == Icons.woman) return 'dress';
    if (icon == Icons.hiking) return 'shoes';
    if (icon == Icons.shopping_bag) return 'bag';
    return 'tshirt';
  }

  static Color _colorFromKey(String key) {
    switch (key) {
      case 'blue':
        return Colors.indigo;
      case 'orange':
        return Colors.deepOrange;
      case 'green':
        return Colors.teal;
      case 'pink':
        return Colors.pink;
      case 'brown':
        return Colors.brown;
      case 'purple':
        return Colors.deepPurple;
      default:
        return Colors.blueGrey;
    }
  }

  static String _colorKey(Color color) {
    if (color == Colors.indigo) return 'blue';
    if (color == Colors.deepOrange) return 'orange';
    if (color == Colors.teal) return 'green';
    if (color == Colors.pink) return 'pink';
    if (color == Colors.brown) return 'brown';
    if (color == Colors.deepPurple) return 'purple';
    return 'blueGrey';
  }
}

/// Sepete eklenen bir ürünü (seçilen beden/renk ile birlikte) temsil eder.
class CartItem {
  final Product product;
  final String selectedSize;
  final String selectedColor;
  int quantity;

  CartItem({
    required this.product,
    required this.selectedSize,
    required this.selectedColor,
    this.quantity = 1,
  });

  double get totalPrice => product.price * quantity;
}
