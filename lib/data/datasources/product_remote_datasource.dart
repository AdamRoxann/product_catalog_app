import 'package:dio/dio.dart';
import 'package:product_catalog/core/constants/api_constants.dart';
import 'package:product_catalog/data/models/product.dart';

class ProductRemoteDatasource{
  final Dio dio;

  ProductRemoteDatasource(this.dio);

  Future<ProductResponse> getProducts({
    required int limit,
    required int skip,
  }) async {
    final response = await dio.get(
      ApiConstants.products,
      queryParameters: {
        'limit': limit,
        'skip': skip
      }
    );
  return ProductResponse.fromJson(response.data);
  }

  Future<ProductResponse> searchProducts({
    required String query,
    required int limit,
    required int skip,
  }) async {
    final response = await dio.get(
      ApiConstants.productSearch,
      queryParameters: {
        'q': query,
        'limit': limit,
        'skip': skip
      }
    );
  return ProductResponse.fromJson(response.data);
  }

  Future<Product> getProduct(int id) async {
    final response = await dio.get(
      '${ApiConstants.products}/$id',
    );

    return Product.fromJson(response.data);
  }
}