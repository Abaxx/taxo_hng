
import 'package:flutter/material.dart';
import 'package:taxo_hng/data/api_service.dart';
import 'package:taxo_hng/data/products_repo.dart';
import 'package:taxo_hng/screens/details.dart';

import '../data/model/products_model.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final apiClient = ApiClient();

  @override
  Widget build(BuildContext context) {
    final productRepo = ProductRepo(apiClient);
    return Scaffold(
      appBar: AppBar(
        title: Text('Taxo Shop'),
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder<List<ProductsModel>>(
          future: productRepo.getProductsList(context),
          builder: (context,AsyncSnapshot<List<ProductsModel>>snapshot){
            // checking if future is resolved
            if(snapshot.connectionState == ConnectionState.active || snapshot.connectionState == ConnectionState.done){
              if(snapshot.hasData){
                return ListView.builder(
                    padding: const EdgeInsets.all(5),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext ctx,int index){

                      // Extracting data from snapshot
                      final name = snapshot.data![index].productName;
                      final image = snapshot.data![index].productImage;
                      final price = snapshot.data![index].productPrice;
                      final id = snapshot.data![index].productId;

                      return GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductDetail(productId: id,productPrice: price,)));
                        },
                        child: Card(
                          margin: const EdgeInsets.all(0),
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
                                color: Colors.deepPurple,
                                alignment: Alignment.center,
                                child: Text('NGN$price',style: TextStyle(color: Colors.white, fontSize: 20),),
                              )
                            ],
                          ),
                        ),
                      );
                    }
                );
              }else if (snapshot.hasError){
                return Center(child: Text('${snapshot.error} occurred'),);
              }else {
                return Center(child: CircularProgressIndicator(),);
              }
            }else {
              return Center(child: CircularProgressIndicator(),);
            }
          }
      ),
    );
  }

}