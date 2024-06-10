import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/feature/home/view/home_view.dart';
import 'package:shopping_app/product/providers/cart_provider.dart';
import 'package:shopping_app/product/utility/constants/colors.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                  backgroundColor:
                      WidgetStatePropertyAll(Colors.grey.shade200))),
          appBarTheme: AppBarTheme(
              centerTitle: true, backgroundColor: ProjectColors.beyaz),
          scaffoldBackgroundColor: Colors.grey.shade300,
          cardTheme: const CardTheme(color: Colors.white),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: ProjectColors.beyaz,
              foregroundColor: ProjectColors.siyah),
          textTheme: const TextTheme(
              bodyMedium:
                  TextStyle(fontSize: 18, fontWeight: FontWeight.w500))),
      debugShowCheckedModeBanner: false,
      home: const HomeView(),
    );
  }
}
