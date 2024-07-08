
import 'package:flutter/material.dart';
import 'package:taxo_hng/data/api_service.dart';
import 'package:taxo_hng/data/model/product_detail_model.dart';

import 'model/products_model.dart';

class ProductRepo{
  final ApiClient apiClient;
  ProductRepo(this.apiClient);
 //getting all products data from api
  Future<List<ProductsModel>> getProductsList(BuildContext context) async {
    List<ProductsModel> productsData = [];
    try{
      final products = await apiClient.fetchProductsData();

      if(products.statusCode == 200){
        List data = products.data['items'];
        productsData = data.map((e) => ProductsModel.fromMap(e)).toList();
      }else if(products.statusCode == 400){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Bad Request. The request was invalid')));
      }else if(products.statusCode == 404){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Not Found. The resource was not found')));
      }else if(products.statusCode == 500){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Internal Server Error')));
      }
    }catch(e){
      e.toString();
    }
    return productsData;
  }


  //getting product information from api
  Future<ProductDetailModel> getProductDetail(String productId,BuildContext context) async {
    var productDetail;
    try{
      final product = await apiClient.fetchProductDetailData(productId);
      if(product.statusCode == 200){
        final data = product.data;
        productDetail = ProductDetailModel.fromJson(data);

      }else if(product.statusCode == 400){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Bad Request. The request was invalid')));
      }else if(product.statusCode == 404){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Not Found. The resource was not found')));
      }else if(product.statusCode == 500){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Internal Server Error')));
      }
    }catch(e){
      print(e.toString());
    }
    return productDetail;
  }
}