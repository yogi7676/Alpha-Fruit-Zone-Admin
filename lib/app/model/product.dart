import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String? productName;
  String? imageUrl;

  Product({this.productName, this.imageUrl});

  Product.fromJson(DocumentSnapshot json) {
    productName = json["productName"] == null ? null : json["productName"];
    imageUrl = json["imageUrl"] == null ? null : json["imageUrl"];
  }

  Map<String, dynamic>? toMap(Product model) {
    var data = Map<String, dynamic>();

    data['productName'] = model.productName;
    data['imageUrl'] = model.imageUrl;
    return data;
  }
}
