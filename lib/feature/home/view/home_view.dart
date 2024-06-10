import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/feature/cart/cartview.dart';
import 'package:shopping_app/feature/home/viewmodel/home_viewmodel.dart';
import 'package:shopping_app/product/providers/cart_provider.dart';
import 'package:shopping_app/product/utility/components/product_card.dart';
import 'package:shopping_app/product/utility/constants/colors.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends HomeviewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _fabButton(context),
      appBar: AppBar(
        title: Text("M Y  S T O R E",
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: ProjectColors.siyah)),
        actions: [
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : const SizedBox.shrink()
        ],
      ),
      body: Consumer<CartProvider>(
        builder: (context, value, child) {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
            ),
            itemCount: items?.length ?? 0,
            itemBuilder: (BuildContext context, int index) {
              return ProductCard(
                model: items![index],
              );
            },
          );
        },
      ),
    );
  }

  FloatingActionButton _fabButton(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.shopping_basket_rounded),
      onPressed: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const CartView(),
      )),
    );
  }
}
