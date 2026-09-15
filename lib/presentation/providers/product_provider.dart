import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:product_catalog/core/network/dio_client.dart';
import 'package:product_catalog/data/datasources/product_remote_datasource.dart';
import 'package:product_catalog/data/models/product.dart';
import 'package:product_catalog/data/repositories/product_repository_impl.dart';

class ProductState {
  final List<Product> products;
  final int total;
  final bool isLoadingMore;
  final bool hasMore;
  final String query;

  const ProductState({
    this.products = const [],
    this.total = 0,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.query = '',
  });

  ProductState copyWith({
    List<Product>? products,
    int? total,
    bool? isLoadingMore,
    bool? hasMore,
    String? query,
  }) {
    return ProductState(
      products: products ?? this.products,
      total: total ?? this.total,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      query: query ?? this.query,
    );
  }
}

final dioClientProvider = Provider<DioClient>((ref) {
  return DioClient();
});

final productDataSourceProvider =
    Provider<ProductRemoteDatasource>((ref) {
  final dioClient = ref.read(dioClientProvider);

  return ProductRemoteDatasource(dioClient.dio);
});

final productRepositoryProvider =
    Provider<ProductRepositoryImpl>((ref) {
  final datasource = ref.read(productDataSourceProvider);

  return ProductRepositoryImpl(datasource);
});

final productProvider =
    AsyncNotifierProvider<ProductNotifier, ProductState>(
  ProductNotifier.new,
);

class ProductNotifier extends AsyncNotifier<ProductState> {
  static const int pageSize = 20;

  ProductRepositoryImpl get repository {
    return ref.read(productRepositoryProvider);
  }

  @override
  Future<ProductState> build() async {
    final response = await repository.getProducts(
      limit: pageSize,
      skip: 0,
    );

    return ProductState(
      products: response.products,
      total: response.total,
      hasMore: response.products.length < response.total,
    );
  }

  Future<void> loadMore() async {
    final currentState = state.value;

    if (currentState == null ||
        currentState.isLoadingMore ||
        !currentState.hasMore) {
      return;
    }

    state = AsyncData(
      currentState.copyWith(
        isLoadingMore: true,
      ),
    );

    try {
      final response = currentState.query.isEmpty
        ? await repository.getProducts(
            limit: pageSize,
            skip: currentState.products.length,
          )
        : await repository.searchProducts(
            query: currentState.query,
            limit: pageSize,
            skip: currentState.products.length,
      );

      final updatedProducts = [
        ...currentState.products,
        ...response.products,
      ];

      state = AsyncData(
        currentState.copyWith(
          products: updatedProducts,
          total: response.total,
          isLoadingMore: false,
          hasMore: updatedProducts.length < response.total,
        ),
      );
    } catch (_) {
      state = AsyncData(
        currentState.copyWith(
          isLoadingMore: false,
        ),
      );
    }
  }

  Future<void> search(String query) async {
    final trimmedQuery = query.trim();

    if (trimmedQuery.isEmpty) {
      ref.invalidateSelf();
      return;
    }

    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final response = await repository.searchProducts(
        query: trimmedQuery,
        limit: pageSize,
        skip: 0,
      );

      return ProductState(
        products: response.products,
        total: response.total,
        query: trimmedQuery,
        hasMore: response.products.length < response.total,
      );
    });
  }

  Future<void> refresh() async {
    final currentState = state.value;
    final query = currentState?.query ?? '';

    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final response = query.isEmpty
          ? await repository.getProducts(
              limit: pageSize,
              skip: 0,
            )
          : await repository.searchProducts(
              query: query,
              limit: pageSize,
              skip: 0,
            );

      return ProductState(
        products: response.products,
        total: response.total,
        query: query,
        hasMore: response.products.length < response.total,
      );
    });
  }
}