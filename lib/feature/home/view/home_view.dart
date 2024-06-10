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
        leading: isLoading
            ? const Center(child: CircularProgressIndicator())
            : const SizedBox.shrink(),
        actions: [_searchBar(context)],
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

  IconButton _searchBar(BuildContext context) {
    return IconButton(
        onPressed: () => showDialog(
              context: context,
              builder: (context) => AlertDialog(
                actions: [
                  SizedBox(
                    width: 600,
                    height: 600,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          TextField(
                            onChanged: (value) => runFilter(value),
                            decoration: const InputDecoration(
                              labelText: "Ara",
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.search),
                            ),
                          ),
                          Expanded(
                              child: SizedBox(
                            width: 400,
                            height: 200,
                            child: ListView.builder(
                              itemCount: filteredItems?.length ?? 0,
                              itemBuilder: (BuildContext context, int index) {
                                final item = filteredItems![index];
                                return Card(
                                  child: ListTile(
                                    leading: Image.network(item.image ?? " "),
                                    title: Text(item.title ?? ""),
                                  ),
                                );
                              },
                            ),
                          ))
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
        icon: const Icon(Icons.search_rounded));
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
