import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shopping_app/product/model/product_model.dart';
class CartProvider extends ChangeNotifier {
  final List<ProductModel> _cartItems = [];
  List<ProductModel>? get cartItems => _cartItems;

void addItemToCart(ProductModel? model, int amount) {
    if (model != null) {
      var existingProduct = _cartItems.firstWhere(
        (item) => item.id == model.id,
        orElse: () => ProductModel(id: -1),
      );

      if (existingProduct.id != -1) {
        existingProduct.amount += amount;
      } else {
        model.amount = amount;
        _cartItems.add(model);
      }

      notifyListeners();
    }
  } 
  

  void removeItemFromCart(ProductModel? model) {
    if (model != null) {
      _cartItems.remove(model);
      notifyListeners();
    }
  }

  void decreaseItemAmount(ProductModel? model) {
    if (model != null) {
      var existingProduct = _cartItems.firstWhere(
        (item) => item.id == model.id,
        orElse: () => ProductModel(id: -1),
      );

      if (existingProduct.id != -1) {
        if (existingProduct.amount > 1) {
          existingProduct.amount -= 1;
        } else {
          _cartItems.remove(existingProduct);
        }
        notifyListeners();
      }
    }
  }

  double getTotalPrice() {
    return _cartItems.fold(0, (sum, item) => sum + (item.price ?? 0) * item.amount);
  }



  double totalPriceOfCart() {
    double totalPrice=0.0;
    for (var item in _cartItems) {
      totalPrice +=(item.price ?? 0) *item.amount;
    }
    return totalPrice;
  }


  
}
