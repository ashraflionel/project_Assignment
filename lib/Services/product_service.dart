import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/product_model.dart';
import 'package:http/http.dart';

class ProductListAPIProvider with ChangeNotifier {
  bool _error = false;
  String _errorMessage = "";
  ProductModel? _productModel;

  Future<void> fetchData() async {
    final uri = Uri.parse(
        "https://dummyjson.com/products");
    final response = await get(uri);

    if (response.statusCode == 200) {

      print("------------------------"+response.statusCode.toString());
      try {
        final jsonResponse = jsonDecode(response.body);
        _productModel = ProductModel.fromJson(jsonResponse);
      } catch (e) {
        _error = false;
        _errorMessage = e.toString();
        _productModel = null;
      }
    } else {
      _error = false;
      _errorMessage =
          "Error with response code " + response.statusCode.toString();
      _productModel = null;
    }
    notifyListeners();
  }



Future<void> searchData(String searchvalue) async {
    final uri = Uri.parse("https://dummyjson.com/products/search?q=$searchvalue");
    final response = await get(uri);

    if (response.statusCode == 200) {
      print("-----------searchData-------------"+response.statusCode.toString());
      
      try {
        final jsonResponse = jsonDecode(response.body);
        _productModel = ProductModel.fromJson(jsonResponse);
         print("-----------searchData-------------"+response.body.toString());
      } catch (e) {
        _error = false;
        _errorMessage = e.toString();
        _productModel = null;
      }
    } else {
      _error = false;
      _errorMessage ="Error with response code " + response.statusCode.toString();
      _productModel = null;
    }
    notifyListeners();
  }
  bool get error => _error;

  String get errorMessage => _errorMessage;

  ProductModel? get productResponseModel => _productModel;

  bool get ifLoading => _error == false && _productModel == null;
}
