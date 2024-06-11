import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/product/providers/cart_provider.dart';
import 'package:shopping_app/product/utility/constants/colors.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  final String removeText = "Ürün sepetten çıkarıldı";
  @override
  Widget build(BuildContext context) {
    const String storeName = "M Y  S T O R E";
    return Scaffold(
      backgroundColor: ProjectColors.beyaz,
      appBar: AppBar(
        title: Text(storeName,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: ProjectColors.siyah)),
        actions: [
          Text(
              "Toplam ${Provider.of<CartProvider>(context).totalPriceOfCart().toStringAsFixed(2)} \$",
              style: Theme.of(context).textTheme.bodyMedium)
        ],
      ),
      body: Consumer<CartProvider>(
        builder: (context, value, child) {
          return ListView.builder(
            itemCount: value.cartItems?.length,
            itemBuilder: (BuildContext context, int index) {
              final item = value.cartItems?[index];
              return ListTile(
                leading: Image.network(item?.image ?? " "),
                title: Text(item?.title ?? " "),
                subtitle: Text('Miktar: ${item?.amount}',
                    style: Theme.of(context).textTheme.bodyMedium),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        onPressed: () {
                          Provider.of<CartProvider>(context, listen: false)
                              .removeItemFromCart(item);

                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              duration: const Duration(milliseconds: 300),
                              content: Text(removeText)));
                        },
                        icon: const Icon(Icons.delete)),
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        Provider.of<CartProvider>(context, listen: false)
                            .decreaseItemAmount(item);
                      },
                    ),
                    Text(
                        '${((item?.price ?? 0) * (item?.amount ?? 1)).toStringAsFixed(2)}\$',
                        style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
