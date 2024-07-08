
import 'package:flutter/material.dart';
import '../data/api_service.dart';
import '../data/model/product_detail_model.dart';
import '../data/products_repo.dart';

class ProductDetail extends StatelessWidget {
  ProductDetail({super.key,this.productId,this.productPrice});
  final apiClient = ApiClient();
  final productId;
  final productPrice;

  @override
  Widget build(BuildContext context) {
    final productRepo = ProductRepo(apiClient);
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder<ProductDetailModel>(
          future: productRepo.getProductDetail(productId,context),
          builder: (context,AsyncSnapshot<ProductDetailModel>snapshot){
            // checking if future is resolved
            if(snapshot.connectionState == ConnectionState.active || snapshot.connectionState == ConnectionState.done){
              if(snapshot.hasData){
                final productDetail = snapshot.data;
                final name = productDetail!.productName;
                final image = productDetail.productImage;
                final available = productDetail.productAvailable;
                final description = productDetail.productDescription;
                final availableQuantity = productDetail.productAvailableQuantity.toInt();

                return Card(
                  margin: EdgeInsets.all(0),
                  color: Colors.black,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width ,
                        height: 200,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(image),
                              fit: BoxFit.fill
                          ),
                        ),
                        alignment: Alignment.center,
                        child:  Text(name,style: TextStyle(color: Colors.white,fontSize: 30),),
                      ),
                      Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: Text(description,style: TextStyle(color: Colors.white, fontSize: 20),),
                      ),
                      Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: Text("Available: ${available == true ? 'Yes' : 'No'}",style: TextStyle(color: Colors.white, fontSize: 20),),
                      ),
                      Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: Text('Quantity: $availableQuantity',style: TextStyle(color: Colors.white, fontSize: 20),),
                      ),
                      Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: Text('NGN$productPrice/unit',style: TextStyle(color: Colors.white, fontSize: 20),),
                      )
                    ],
                  ),
                );
              }else if (snapshot.hasError){
                return const Center(child: Text('Error occurred'),);
              }else {
                return const Center(child: CircularProgressIndicator(),);
              }
            }else {
              return const Center(child: CircularProgressIndicator(),);
            }
          }
      ),
    );
  }
}