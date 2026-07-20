import 'package:flutter/foundation.dart';
import '../models/product.dart';

/// Basit sepet state yönetimi (simülasyon).
/// Eğitim kapsamı "ekstra paket kullanılmayacaktır" dediği için Provider gibi
/// bir state-management paketi yerine, Flutter SDK'sının kendi getirdiği
/// [ChangeNotifier] (dışarıdan paket gerektirmez) ile basit bir singleton
/// üzerinden yönetilir. Dinleyen widget'lar (AnimatedBuilder ile) otomatik
/// güncellenir; ekranlar ayrıca kendi setState() çağrılarını da yapabilir.
class CartService extends ChangeNotifier {
  CartService._internal();
  static final CartService instance = CartService._internal();

  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  int get totalItemCount =>
      _items.fold(0, (sum, item) => sum + item.quantity);

  double get totalPrice =>
      _items.fold(0.0, (sum, item) => sum + item.totalPrice);

  void addToCart(Product product, String size, String color) {
    final existingIndex = _items.indexWhere((item) =>
        item.product.id == product.id &&
        item.selectedSize == size &&
        item.selectedColor == color);

    if (existingIndex >= 0) {
      _items[existingIndex].quantity += 1;
    } else {
      _items.add(CartItem(
        product: product,
        selectedSize: size,
        selectedColor: color,
      ));
    }
    notifyListeners();
  }

  /// Adet arttırır.
  void incrementQuantity(int index) {
    if (index < 0 || index >= _items.length) return;
    _items[index].quantity += 1;
    notifyListeners();
  }

  /// Adet azaltır; adet 1 iken tekrar azaltılırsa ürünü sepetten çıkarır.
  void decrementQuantity(int index) {
    if (index < 0 || index >= _items.length) return;
    if (_items[index].quantity > 1) {
      _items[index].quantity -= 1;
    } else {
      _items.removeAt(index);
    }
    notifyListeners();
  }

  void removeAt(int index) {
    if (index < 0 || index >= _items.length) return;
    _items.removeAt(index);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
