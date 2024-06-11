import 'package:flutter/material.dart';
import 'package:shopping_app/feature/home/view/home_view.dart';
import 'package:shopping_app/product/model/product_model.dart';
import 'package:shopping_app/product/service/product_service.dart';

abstract class HomeviewModel extends State<HomeView> {
  List<ProductModel>? items;
  List<ProductModel>? filteredItems;
  bool isLoading = false;
  late ProductService _productService;
  String servicePathName = "";
   int selectedChipIndex = -1;
   String pathName = '';

  final List<String> categories = [
    'electronics',
    'jewelery',
    "men's clothing",
    "women's clothing"
  ];

  final List<String> paths = [
    '/category/electronics',
    '/category/jewelery',
    "/category/men's clothing",
    "/category/women's clothing"
  ];

  @override
  void initState() {
    super.initState();
    _productService = ProductService(servicePathName);
    fetchItems();
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
    _productService = ProductService(servicePathName);
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
