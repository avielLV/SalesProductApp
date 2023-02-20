import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:proudcto_app/models/models.dart';
import 'package:http/http.dart' as http;

class ProductService extends ChangeNotifier {
  final String _baseUrl =
      'flutter-curso-udemy-326c6-default-rtdb.firebaseio.com';

  final List<ProductResponse> products = [];
  final storage = const FlutterSecureStorage();

  late ProductResponse selectedProduct;
  bool isloading = true;
  bool isSaviing = false;
  File? newPictureFile;
  ProductService() {
    loadProducts();
  }

  Future<List<ProductResponse>> loadProducts() async {
    isloading = true;
    notifyListeners();

    final url = Uri.https(
        _baseUrl, 'product.json', {'auth': await storage.read(key: 'token')});

    final resp = await http.get(url);

    if (resp.statusCode == 200) {
      final Map<String, dynamic> productsMap = jsonDecode(resp.body);
      productsMap.forEach((key, value) {
        final tempProduct = ProductResponse.fromJson(value);
        tempProduct.id = key;
        products.add(tempProduct);
      });
      isloading = false;
      notifyListeners();
      return products;
    } else {
      isloading = false;
      notifyListeners();
      return [];
    }
  }

  Future saveOrCreateProduct(ProductResponse product) async {
    isSaviing = true;
    notifyListeners();
    if (product.id == null) {
      await createProduct(product);
    } else {
      await updateProduct(product);
    }

    isSaviing = false;
    notifyListeners();
  }

  Future<String> updateProduct(ProductResponse product) async {
    final url = Uri.https(_baseUrl, 'product/${product.id}.json',
        {'auth': await storage.read(key: 'token')});
    await http.put(url, body: json.encode(product.toJson()));
    // final decodeDate = resp.body;

    final index = products.indexWhere((element) => element.id == product.id);
    products[index] = product;

    return '';
  }

  Future<String> createProduct(ProductResponse product) async {
    final url = Uri.https(
        _baseUrl, 'product.json', {'auth': await storage.read(key: 'token')});
    final resp = await http.post(url, body: json.encode(product.toJson()));
    final decodeDate = jsonDecode(resp.body);
    product.id = decodeDate['name'];
    products.add(product);

    return product.id ?? '';
  }

  void updateSelectedProductImage(String path) {
    selectedProduct.picture = path;
    newPictureFile = File.fromUri(Uri(path: path));
    notifyListeners();
  }
}
