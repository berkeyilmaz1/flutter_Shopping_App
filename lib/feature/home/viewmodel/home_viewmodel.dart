import 'package:flutter/material.dart';
import 'package:shopping_app/feature/home/view/home_view.dart';
import 'package:shopping_app/product/model/product_model.dart';
import 'package:shopping_app/product/service/product_service.dart';

abstract class HomeviewModel extends State<HomeView> {
  List<ProductModel>? items;
  List<ProductModel>? filteredItems;
  bool isLoading = false;
  late final ProductService _productService;

  @override
  void initState() {
    _productService = ProductService();
    fetchItems();
    super.initState();
  }

  void runFilter(String enteredWord) {
    List<ProductModel>? results = [];

    if (enteredWord.isEmpty) {
      results = items;
    } else {
      results = items
          ?.where((item) =>
              item.title?.toLowerCase().contains(enteredWord.toLowerCase()) ??
              false)
          .toList();
    }
    setState(() {
      filteredItems = results;
    });
  }

  Future<void> fetchItems() async {
    changeLoading();
    items = await _productService.fetchItems();
    changeLoading();
    filteredItems = items;
  }

  void changeLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }
}
