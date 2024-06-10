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
  String addText = "Ekle";

  @override
  Widget build(BuildContext context) {
    const String addedText = "Ürün başarıyla eklendi";
    return GestureDetector(
      onTap: () => _bottomSheet(context),
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("${widget.model.category?.toUpperCase()}"),
            SizedBox(
              width: MediaQuery.of(context).size.width / 5,
              height: MediaQuery.of(context).size.height / 5,
              child: Image.network(widget.model.image ?? ""),
            ),
            Text("${widget.model.title}",
                style: Theme.of(context).textTheme.bodyMedium),
            Text("${widget.model.price.toString()}\$",
                style: Theme.of(context).textTheme.bodyMedium),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AmountPicker(
                  initialAmount: _selectedAmount,
                  onAmountChanged: (amount) {
                    setState(() {
                      _selectedAmount = amount;
                    });
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    Provider.of<CartProvider>(context, listen: false)
                        .addItemToCart(widget.model, _selectedAmount);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        duration: Duration(milliseconds: 300),
                        content: Text(addedText)));
                  },
                  child: Text(
                    addText,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<dynamic> _bottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("${widget.model.title}"),
              SizedBox(
                width: MediaQuery.of(context).size.width / 5,
                height: MediaQuery.of(context).size.height / 5,
                child: Image.network(widget.model.image ?? ""),
              ),
              Text("${widget.model.price.toString()}\$",
                  style: Theme.of(context).textTheme.bodyMedium),
              const Divider(),
              Text("${widget.model.description.toString()}\$",
                  maxLines: 5, style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        );
      },
    );
  }
}
