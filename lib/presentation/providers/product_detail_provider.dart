import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:product_catalog/data/models/product.dart';
import 'package:product_catalog/presentation/providers/product_provider.dart';

final productDetailProvider =
    FutureProvider.family<Product, int>((ref, productId) async {
  final repository = ref.read(productRepositoryProvider);

  return repository.getProduct(productId);
});