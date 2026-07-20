import 'package:flutter/foundation.dart';
import '../models/product.dart';

/// Basit favori (beğenilen ürün) state yönetimi (simülasyon).
/// CartService ile aynı mantık: ekstra paket kullanılmadan, Flutter SDK'sının
/// kendi [ChangeNotifier] sınıfı üzerinden bir singleton olarak yönetilir.
class FavoritesService extends ChangeNotifier {
  FavoritesService._internal();
  static final FavoritesService instance = FavoritesService._internal();

  final Set<int> _favoriteIds = {};

  bool isFavorite(Product product) => _favoriteIds.contains(product.id);

  void toggle(Product product) {
    if (_favoriteIds.contains(product.id)) {
      _favoriteIds.remove(product.id);
    } else {
      _favoriteIds.add(product.id);
    }
    notifyListeners();
  }

  List<Product> filterFavorites(List<Product> all) {
    return all.where((p) => _favoriteIds.contains(p.id)).toList();
  }

  int get count => _favoriteIds.length;
}
