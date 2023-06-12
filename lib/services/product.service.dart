import 'package:dio/dio.dart';
import 'package:ecom/config.dart';
import 'package:ecom/interceptors/response_interceptor.dart';
import 'package:ecom/models/paged-response.model.dart';
import 'package:ecom/models/product.model.dart';

class ProductService {
  static final ProductService _instance = ProductService._privateConstructor();

  static ProductService get instance => _instance;

  final Dio dio = Dio();

  ProductService._privateConstructor() {
    dio.interceptors.add(ResponseInterceptor());
  }

  Future<PagedResponse<Product>?> getProducts(int page) async {
    try {
      String? url = '${Config.API_URL}/recommend/items';
      final response = await dio.get(url, queryParameters: { "page": page });
      if (response.statusCode == 200) {
        return Product.pagedFromJson(response.data["data"]);
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      rethrow;
    }
  }
}