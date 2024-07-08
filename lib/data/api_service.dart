
import 'package:dio/dio.dart';
import '../AppConstant.dart';

class ApiClient{
  late Dio dio;
  BaseOptions options = BaseOptions(
    baseUrl: SERVER_API_URL,
    connectTimeout: Duration(seconds: 15),
    receiveTimeout: Duration(seconds: 15),
    responseType: ResponseType.json
  );

  final queryParameters = {'Apikey': Apikey,'Appid':Appid,'organization_id':orgID};

  //Fetching all the products from server
  Future<Response> fetchProductsData() async {
    dio = Dio(options);
    final path = 'products?';
    try{
      Response response = await dio.get(path,queryParameters: queryParameters,
      );
      return response;
    }on DioException catch(e){
      throw e.toString();
    }
  }

  //Fetching product information from server
  Future<Response> fetchProductDetailData(String productId) async {
    dio = Dio(options);
    final path = 'products/${productId}?';
    try{
      Response response = await dio.get(path,queryParameters: queryParameters,
      );
      return response;
    }on DioException catch(e){
      throw e.toString();
    }
  }
}