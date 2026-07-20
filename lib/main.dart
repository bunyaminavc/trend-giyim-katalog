import 'package:flutter/material.dart';
import 'screens/main_screen.dart';
import 'screens/product_detail_screen.dart';

void main() {
  runApp(const TrendGiyimApp());
}

class TrendGiyimApp extends StatelessWidget {
  const TrendGiyimApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trend Giyim - Mini Katalog',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF6C63FF),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF7F7F9),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          elevation: 0,
          centerTitle: true,
        ),
      ),
      // Named routes kullanımı
      initialRoute: '/',
      routes: {
        '/': (context) => const MainScreen(),
        ProductDetailScreen.routeName: (context) => const ProductDetailScreen(),
      },
    );
  }
}
