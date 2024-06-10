import 'package:flutter/material.dart';
import 'package:shopping_app/feature/home/view/home_view.dart';
import 'package:shopping_app/product/model/product_model.dart';
import 'package:shopping_app/product/service/product_service.dart';

abstract class HomeviewModel extends State<HomeView> {
  List<ProductModel>? items;
  bool isLoading = false;
  late final ProductService _productService;

  get shopItems => items;

  @override
  void initState() {
    super.initState();
    _productService = ProductService();

    fetchItems();
  }

  Future<void> fetchItems() async {
    changeLoading();
    items = await _productService.fetchItems();
    changeLoading();
  }

  void changeLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }
}
