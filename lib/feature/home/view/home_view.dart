import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/feature/cart/cartview.dart';
import 'package:shopping_app/feature/home/viewmodel/home_viewmodel.dart';
import 'package:shopping_app/product/providers/cart_provider.dart';
import 'package:shopping_app/product/utility/components/product_card.dart';

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
        title: _categorySelector(),
        leading: isLoading
            ? const Center(child: CircularProgressIndicator())
            : const SizedBox.shrink(),
        actions: [_searchBar(context)],
      ),
      body: _bodyProductShower(),
    );
  }

  Consumer<CartProvider> _bodyProductShower() {
    return Consumer<CartProvider>(
      builder: (context, value, child) {
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
          ),
          itemCount: filteredItems?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            return ProductCard(
              model: filteredItems![index],
            );
          },
        );
      },
    );
  }

  Wrap _categorySelector() {
    return Wrap(
      spacing: 10.0,
      children: List<Widget>.generate(4, (int index) {
        return ChoiceChip(
          label: Text(categories[index]),
          selected: selectedChipIndex == index,
          onSelected: (bool selected) {
            setState(() {
              selectedChipIndex = selected ? index : -1;
              pathName = selected ? paths[index] : '';
              servicePathName = pathName;
              fetchItems();
            });
          },
        );
      }).toList(),
    );
  }

  IconButton _searchBar(BuildContext context) {
    return IconButton(
      onPressed: () => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          actions: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                onChanged: (value) => runFilter(value),
                decoration: const InputDecoration(
                  labelText: "Ara",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            )
          ],
        ),
      ),
      icon: const Icon(Icons.search_rounded),
    );
  }

  FloatingActionButton _fabButton(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.shopping_basket_rounded),
      onPressed: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const CartView(),
        ),
      ),
    );
  }
}
