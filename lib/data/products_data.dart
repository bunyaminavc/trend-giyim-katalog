import 'dart:convert';
import '../models/product.dart';

/// Bu proje "eğitim/demo amaçlıdır" (bkz. Proje Çıktısı Raporu, Bölüm 5).
/// Gerçek bir API yerine, JSON okuma/parse etme mantığını göstermek için
/// ürün verisi burada JSON string olarak simüle edilmiştir.
///
/// "imagePath" alanı assets/images/ klasöründeki gerçek dosyaya işaret eder.
/// Dosya bulunamazsa arayüz otomatik olarak ikona geri döner (bkz. ProductCard
/// ve ProductDetailScreen içindeki errorBuilder kullanımı).
const String _productsJson = '''
[
  {"id": 1, "name": "Basic Beyaz Tişört", "category": "Tişört", "price": 149.90,
   "description": "Yüzde yüz pamuklu, günlük kullanıma uygun rahat kesim beyaz tişört.",
   "iconKey": "tshirt", "colorKey": "blueGrey",
   "sizes": ["S", "M", "L", "XL"], "colors": ["Beyaz", "Siyah", "Gri"],
   "imagePath": "assets/images/beyaztisort.webp"},

  {"id": 2, "name": "Slim Fit Kot Pantolon", "category": "Pantolon", "price": 449.90,
   "description": "Dar kesim, esnek kumaşlı klasik kot pantolon.",
   "iconKey": "pants", "colorKey": "blue",
   "sizes": ["30", "32", "34", "36"], "colors": ["Lacivert", "Siyah"],
   "imagePath": "assets/images/kotpantolon.webp"},

  {"id": 3, "name": "Deri Ceket", "category": "Ceket", "price": 899.90,
   "description": "Suni deri, fermuarlı ve şık görünümlü kışlık ceket.",
   "iconKey": "jacket", "colorKey": "brown",
   "sizes": ["S", "M", "L"], "colors": ["Kahverengi", "Siyah"],
   "imagePath": "assets/images/dericeket.webp"},

  {"id": 4, "name": "Yazlık Elbise", "category": "Elbise", "price": 349.90,
   "description": "Hafif kumaştan üretilmiş, çiçek desenli yazlık elbise.",
   "iconKey": "dress", "colorKey": "pink",
   "sizes": ["XS", "S", "M", "L"], "colors": ["Pembe", "Sarı", "Mavi"],
   "imagePath": "assets/images/yazlıkelbise.webp"},

  {"id": 5, "name": "Spor Ayakkabı", "category": "Ayakkabı", "price": 599.90,
   "description": "Nefes alabilen file yüzeyli, günlük ve spor kullanım için ideal ayakkabı.",
   "iconKey": "shoes", "colorKey": "green",
   "sizes": ["38", "39", "40", "41", "42"], "colors": ["Beyaz", "Siyah", "Yeşil"],
   "imagePath": "assets/images/sporayakkabı.webp"},

  {"id": 6, "name": "Kadın Sırt Çantası", "category": "Aksesuar", "price": 299.90,
   "description": "Su geçirmez kumaştan üretilmiş, çok gözlü şık sırt çantası.",
   "iconKey": "bag", "colorKey": "purple",
   "sizes": ["Standart"], "colors": ["Mor", "Siyah", "Bej"],
   "imagePath": "assets/images/kadinsirtcanta.webp"},

  {"id": 7, "name": "Oversize Sweatshirt", "category": "Sweatshirt", "price": 379.90,
   "description": "Şardonlu, içi yumuşak dokulu bol kesim sweatshirt.",
   "iconKey": "tshirt", "colorKey": "orange",
   "sizes": ["S", "M", "L", "XL"], "colors": ["Turuncu", "Gri", "Bordo"],
   "imagePath": "assets/images/oversizesweat.webp"},

  {"id": 8, "name": "Kumaş Pantolon", "category": "Pantolon", "price": 429.90,
   "description": "Ofis ve günlük kombinlere uygun klasik kesim kumaş pantolon.",
   "iconKey": "pants", "colorKey": "blueGrey",
   "sizes": ["38", "40", "42", "44"], "colors": ["Siyah", "Lacivert", "Bej"],
   "imagePath": "assets/images/kumaspantolon.webp"}
]
''';

/// JSON verisini okuyup List<Product> döndürür.
/// (fromJson / toJson temel mantığı burada gösterilmektedir.)
List<Product> loadProducts() {
  final List<dynamic> decoded = jsonDecode(_productsJson) as List<dynamic>;
  return decoded
      .map((item) => Product.fromJson(item as Map<String, dynamic>))
      .toList();
}

/// Ürünlerdeki benzersiz kategori listesini döndürür (filtre çipleri için).
List<String> loadCategories() {
  final products = loadProducts();
  final categories = products.map((p) => p.category).toSet().toList();
  categories.sort();
  return categories;
}
