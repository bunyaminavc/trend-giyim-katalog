# Trend Giyim - Mini Katalog Uygulaması

## Kısa Açıklama
Bu proje, Flutter Günlük Eğitimi kapsamında geliştirilen bir **Mini Katalog Uygulaması**dır.
Bir kıyafet mağazası senaryosu üzerinden; ürün listeleme (GridView), kategoriye göre
filtreleme, arama, ürün detay sayfası (beden/renk seçimi), favoriler, alt navigasyon
çubuğu (Mağaza / Favoriler / Sepet), sayfalar arası geçiş (Navigator, Named Routes,
Route Arguments) ve sepet/sipariş simülasyonu (adet arttırma/azaltma dahil) içerir.

Ürün verisi gerçek bir API'den değil, eğitim amaçlı JSON simülasyonundan
(`lib/data/products_data.dart`) okunmaktadır; `Product.fromJson` / `toJson` ile
model-JSON dönüşümü gösterilmiştir.

## Ekranlar
- **Mağaza (Ana Sayfa)**: Arama çubuğu, kampanya banner'ı, kategori filtre çipleri
  ve ürün kartlarından oluşan grid.
- **Favoriler**: Kalp ikonuyla işaretlenen ürünlerin listelendiği ekran.
- **Sepet**: Sepetteki ürünler, adet arttırma/azaltma, ürün çıkarma, toplam tutar ve
  "Siparişi Tamamla" (simülasyon).
- **Ürün Detayı**: Ürün açıklaması, beden ve renk seçimi, favori ekleme, "Sepete Ekle".

Bu üç ana ekran (Mağaza / Favoriler / Sepet) arasında ekranın altındaki
**BottomNavigationBar** ile geçiş yapılır; sepetteki ürün adedi Sepet
sekmesinin ikonunda rozet olarak gösterilir.

## Kullanılan Flutter Sürümü
- Flutter **3.19+** (Dart SDK **>=3.0.0 <4.0.0**)
- `flutter --version` ile kendi ortamınızdaki sürümü doğrulayabilirsiniz.

## Proje Yapısı
```
lib/
  main.dart                       # Uygulama girişi, MaterialApp, named routes
  models/product.dart             # Product ve CartItem modelleri (fromJson/toJson)
  data/products_data.dart         # Simüle JSON veri kaynağı, kategori listesi
  services/cart_service.dart      # Sepet state yönetimi (ChangeNotifier, ekstra paket yok)
  services/favorites_service.dart # Favoriler state yönetimi (ChangeNotifier)
  screens/main_screen.dart        # Alt navigasyon (Mağaza/Favoriler/Sepet) iskeleti
  screens/home_screen.dart        # Mağaza sekmesi: ürün listesi / kategori filtresi
  screens/product_detail_screen.dart
  screens/favorites_screen.dart
  screens/cart_screen.dart
  widgets/product_card.dart       # GridView kart bileşeni (favori kalp ikonu dahil)
```

## Çalıştırma Adımları
1. Flutter SDK'nın kurulu olduğundan emin olun: `flutter doctor`
2. Proje klasörüne girin:
   ```bash
   cd trend_giyim_katalog
   ```
3. Bağımlılıkları indirin:
   ```bash
   flutter pub get
   ```
4. Bir emulator/cihaz başlatın veya bağlayın, ardından çalıştırın:
   ```bash
   flutter run
   ```

## Notlar
- Bu eğitimin kapsamı gereği (`material.dart` dışında ekstra paket kullanılmaması)
  sepet ve favoriler state yönetimi harici bir paket (Provider vb.) yerine Flutter
  SDK'sının kendi getirdiği `ChangeNotifier` sınıfı ile basit singleton'lar
  (`CartService`, `FavoritesService`) olarak simüle edilmiştir. Bu sayede sepete bir
  ürün başka bir ekrandan (ör. ürün detayından) eklendiğinde de Sepet/Favoriler
  sekmeleri otomatik güncellenir.
- Ürün görselleri yerine kategoriye özel ikonlar ve renkler kullanılmıştır (gerçek
  görsel asset gerektirmeden çalışır durumda kalması için).
