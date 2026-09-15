import 'package:product_catalog/data/datasources/product_remote_datasource.dart';
import 'package:product_catalog/data/models/product.dart';

class ProductRepositoryImpl {
  final ProductRemoteDatasource datasource;

  ProductRepositoryImpl(this.datasource);

  Future<ProductResponse> getProducts({
    required int limit,
    required int skip,
  }) {
    return datasource.getProducts(
      limit: limit, 
      skip: skip
    );
  }

  Future<ProductResponse> searchProducts({
    required String query,
    required int limit,
    required int skip,
  }) {
    return datasource.searchProducts(
      query: query, 
      limit: limit, 
      skip: skip
    );
  }

  Future<Product> getProduct(int id) {
    return datasource.getProduct(id);
  }
}