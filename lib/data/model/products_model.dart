
import 'dart:convert';

class ProductsModel {
  final String productName;
  final String productImage;
  final String productId;
  final double productPrice;

//<editor-fold desc="Data Methods">
  const ProductsModel({
    required this.productName,
    required this.productImage,
    required this.productId,
    required this.productPrice,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductsModel &&
          runtimeType == other.runtimeType &&
          productName == other.productName &&
          productImage == other.productImage &&
          productId == other.productId &&
          productPrice == other.productPrice);

  @override
  int get hashCode =>
      productName.hashCode ^
      productImage.hashCode ^
      productId.hashCode ^
      productPrice.hashCode;

  /*@override
  String toString() {
    return 'ProductsModel{ productName: $productName, productImage: $productImage, productId: $productId, productPrice: $productPrice,}';
  }*/

  ProductsModel copyWith({
    String? productName,
    String? productImage,
    String? productId,
    double? productPrice,
  }) {
    return ProductsModel(
      productName: productName ?? this.productName,
      productImage: productImage ?? this.productImage,
      productId: productId ?? this.productId,
      productPrice: productPrice ?? this.productPrice,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productName': this.productName,
      'productImage': this.productImage,
      'productId': this.productId,
      'productPrice': this.productPrice,
    };
  }

  String toJson() => json.encode(toMap());

  factory ProductsModel.fromJson(Map<String,dynamic> json){
    String imageUrl = 'https://via.placeholder.com/150';
    if(json['photos'] != null && json['photos'].isNotEmpty){
      imageUrl = 'https://api.timbu.cloud/images/' + json['photos'][0]['url'];
    }
    return ProductsModel(
        productName: json['name'] as String,
        productImage: imageUrl,
        productId: json['id'] as String,
        productPrice: json['current_price'][0]['NGN'][0] as double,
    );
  }

  factory ProductsModel.fromMap(Map<String, dynamic> map) {
    String imageUrl = 'https://via.placeholder.com/150';
    if(map['photos'] != null && map['photos'].isNotEmpty){
      imageUrl = 'https://api.timbu.cloud/images/' + map['photos'][0]['url'];
    }
    return ProductsModel(
      productName: map['name'] as String,
      productImage: imageUrl,
      productId: map['id'] as String,
      productPrice: map['current_price'][0]['NGN'][0] as double,
    );
  }

//</editor-fold>
}