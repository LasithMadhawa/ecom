import 'package:ecom/models/paged-response.model.dart';

class Product {
  String? code;
  double? price;
  double? discountPrice;
  String? name;
  String? image;

  Product({this.code, this.name, this.image, this.discountPrice, this.price});

  Product.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    price = json['price'];
    discountPrice = json['discountPrice'];
    name = json['name'];
    image = json['image'];
  }

  static List<Product> listFromJson(List<dynamic> json) {
    return json.map((value) => Product.fromJson(value)).toList();
  }

  static PagedResponse<Product>? pagedFromJson(Map<String, dynamic> json) {
    PagedResponse<Product> resp = PagedResponse.fromJson(json);
    resp.items = listFromJson(json['products']);
    return resp;
  }
}
