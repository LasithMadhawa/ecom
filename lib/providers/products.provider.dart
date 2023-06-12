import 'package:ecom/models/product.model.dart';
import 'package:ecom/services/product.service.dart';
import 'package:flutter/material.dart';

enum ProductDataState {
  uninitialized,
  error,
  loading,
  fetched,
  hasMore,
  noMore
}

class ProductProvider extends ChangeNotifier {
  List<Product> _products = [];
  List<Product> get products => _products;
  ProductDataState _dataState = ProductDataState.uninitialized;
  ProductDataState get dataState => _dataState;
  int _page = 0;
  // Mock data
  // final List<Product> _sampleProducts = [
  //   Product(code: "1", name: "Sed id mi ullamcorper, vehicula purus ut, pharetra quam.", discountPrice: 4590.00, price: 5400),
  //   Product(code: "1", name: "Fusce lacinia velit ac augue viverra sagittis.", discountPrice: 4590.00, price: 5400),
  //   Product(code: "1", name: "Nullam ut erat at purus posuere ultrices.", discountPrice: 4590.00, price: 5400),
  //   Product(code: "1", name: "Proin dapibus urna a augue vestibulum lacinia.", discountPrice: 4590.00, price: 5400),
  //   Product(code: "1", name: "Nunc posuere neque in neque euismod placerat.", discountPrice: 4590.00, price: 5400),
  //   Product(code: "1", name: "Cras volutpat leo ut purus feugiat malesuada.", discountPrice: 4590.00, price: 5400),
  //   Product(code: "1", name: "Curabitur volutpat justo a felis imperdiet fermentum.", discountPrice: 4590.00, price: 5400),
  //   Product(code: "1", name: "Nullam in ante vitae quam aliquam tempor sit amet vitae magna.", discountPrice: 4590.00, price: 5400),
  //   Product(code: "1", name: "Morbi non mauris eu felis dignissim tristique.", discountPrice: 4590.00, price: 5400),
  //   Product(code: "1", name: "Phasellus tempor ligula in nibh consectetur viverra.", discountPrice: 4590.00, price: 5400),
  // ];

  ProductProvider();

  // Fetch data from the service
  fetchData() async {
    if (_dataState == ProductDataState.loading || _dataState == ProductDataState.noMore) {
      return;
    }
    _dataState = ProductDataState.loading;
    notifyListeners();
    try {
      final resp = await ProductService.instance.getProducts(_page);
      resp?.items?.forEach((product) {
        _products.add(product);
      });
      // Check if there is more data
      if (resp != null && resp.totalCount != null && _products.length < resp.totalCount!) {
        _dataState = ProductDataState.hasMore;
      } else {
        _dataState = ProductDataState.noMore;
      }
      _page++;
      notifyListeners();
    } catch (e) {
      _dataState = ProductDataState.error;
      notifyListeners();
    }
  }

  // fetchData() async {
  //   if (_dataState == ProductDataState.loading ||
  //       _dataState == ProductDataState.noMore) {
  //     return;
  //   }
  //   _dataState = ProductDataState.loading;
  //   notifyListeners();
  //   await Future.delayed(const Duration(seconds: 2));
  //     for (var product in _sampleProducts) {
  //       _products.add(product);
  //     }
  //     if (_products.length < 50) {
  //       _dataState = ProductDataState.hasMore;
  //     } else {
  //       _dataState = ProductDataState.noMore;
  //     }
  //     notifyListeners();
  // }
}
