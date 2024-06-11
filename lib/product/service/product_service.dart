import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shopping_app/product/model/product_model.dart';

class ProductService {
  final String pathName;
  final Dio _dio;
  ProductService(this.pathName)
      : _dio = Dio(BaseOptions(baseUrl: "https://fakestoreapi.com/products"));

  Future<List<ProductModel>?> fetchItems() async {
    final response = await _dio.get(pathName);

    if (response.statusCode == HttpStatus.ok) {
      final datas = response.data;
      if (datas is List) {
        return datas
            .map(
              (e) => ProductModel.fromJson(e),
            )
            .toList();
      }
    }
    return null;
  }
}
