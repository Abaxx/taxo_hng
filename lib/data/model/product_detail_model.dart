
import 'dart:convert';

class ProductDetailModel {
  final String productName;
  final String productDescription;
  final String productImage;
  final bool productAvailable;
  final double productAvailableQuantity;

//<editor-fold desc="Data Methods">


  const ProductDetailModel({
    required this.productName,
    required this.productDescription,
    required this.productImage,
    required this.productAvailable,
    required this.productAvailableQuantity,
  });


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is ProductDetailModel &&
              runtimeType == other.runtimeType &&
              productName == other.productName &&
              productDescription == other.productDescription &&
              productImage == other.productImage &&
              productAvailable == other.productAvailable &&
              productAvailableQuantity == other.productAvailableQuantity
          );


  @override
  int get hashCode =>
      productName.hashCode ^
      productDescription.hashCode ^
      productImage.hashCode ^
      productAvailable.hashCode ^
      productAvailableQuantity.hashCode;


  @override
  String toString() {
    return 'ProductDetailModel{ productName: $productName, productDescription: $productDescription, productImage: $productImage, productAvailable: $productAvailable, productAvailableQuantity: $productAvailableQuantity,}';
  }


  ProductDetailModel copyWith({
    String? productName,
    String? productDescription,
    String? productImage,
    double? productPrice,
    bool? productAvailable,
    double? productAvailableQuantity,
  }) {
    return ProductDetailModel(
      productName: productName ?? this.productName,
      productDescription: productDescription ?? this.productDescription,
      productImage: productImage ?? this.productImage,
      productAvailable: productAvailable ?? this.productAvailable,
      productAvailableQuantity: productAvailableQuantity ??
          this.productAvailableQuantity,
    );
  }


  Map<String, dynamic> toMap() {
    return {
      'productName': this.productName,
      'productDescription': this.productDescription,
      'productImage': this.productImage,
      'productAvailable': this.productAvailable,
      'productAvailableQuantity': this.productAvailableQuantity,
    };
  }

  String toJson() => json.encode(toMap());

  factory ProductDetailModel.fromJson(Map<String,dynamic> json){
    String imageUrl = 'https://via.placeholder.com/150';
    if(json['photos'] != null && json['photos'].isNotEmpty){
      imageUrl = 'https://api.timbu.cloud/images/' + json['photos'][0]['url'];
    }
    return ProductDetailModel(
      productName: json['name'] as String,
      productImage: imageUrl,
      productDescription: json['description'] as String,
      productAvailable: json['is_available'] as bool,
      productAvailableQuantity: json['available_quantity'] as double,
    );
  }

  factory ProductDetailModel.fromMap(Map<String, dynamic> map) {
    String imageUrl = 'https://via.placeholder.com/150';
    if(map['photos'] != null && map['photos'].isNotEmpty){
      imageUrl = 'https://api.timbu.cloud/images/' + map['photos'][0]['url'];
    }
    return ProductDetailModel(
        productName: map['name'] as String,
        productImage: imageUrl,
        productDescription: map['description'] as String,
        productAvailable: map['is_available'] as bool,
        productAvailableQuantity: map['available_quantity'] as double,
    );
  }


//</editor-fold>
}