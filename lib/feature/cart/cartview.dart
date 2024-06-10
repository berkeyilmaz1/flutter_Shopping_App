import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/product/providers/cart_provider.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Text(
              "Toplam ${Provider.of<CartProvider>(context).totalPriceOfCart().toStringAsFixed(2)}")
        ],
      ),
      body: Consumer<CartProvider>(
        builder: (context, value, child) {
          return ListView.builder(
            itemCount: value.cartItems?.length,
            itemBuilder: (BuildContext context, int index) {
              final item = value.cartItems?[index];
              return ListTile(
                leading: IconButton(
                    onPressed: () =>
                        Provider.of<CartProvider>(context, listen: false)
                            .removeItemFromCart(item),
                    icon: const Icon(Icons.delete)),
                title: Text(item?.title ?? " "),
                subtitle: Text('Miktar: ${item?.amount}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        Provider.of<CartProvider>(context, listen: false)
                            .decreaseItemAmount(item);
                      },
                    ),
                    Text('${(item?.price ?? 0) * (item?.amount ?? 1)}\$'),
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
