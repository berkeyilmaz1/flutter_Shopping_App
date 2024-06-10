import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/product/model/product_model.dart';
import 'package:shopping_app/product/providers/cart_provider.dart';
import 'package:shopping_app/product/utility/components/amount_picker.dart';
class ProductCard extends StatefulWidget {
  const ProductCard({
    super.key,
    required this.model,
  });

  final ProductModel model;

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  int _selectedAmount = 1;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 5,
            height: MediaQuery.of(context).size.height / 5,
            child: Image.network(widget.model.image ?? ""),
          ),
          Text("${widget.model.price.toString()}\$"),
          Row(
            children: [
              AmountPicker(
                initialAmount: _selectedAmount,
                onAmountChanged: (amount) {
                  setState(() {
                    _selectedAmount = amount;
                  });
                },
              ),
              TextButton(
                onPressed: () => Provider.of<CartProvider>(context, listen: false)
                    .addItemToCart(widget.model, _selectedAmount),
                child: const Text("Ekle"),
              )
            ],
          )
        ],
      ),
    );
  }
}

