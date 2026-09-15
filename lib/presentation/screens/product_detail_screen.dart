import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:product_catalog/presentation/providers/product_detail_provider.dart';

class ProductDetailScreen extends ConsumerWidget {
  final int productId;

  const ProductDetailScreen({
    super.key,
    required this.productId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productState = ref.watch(
      productDetailProvider(productId),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail'),
      ),
      body: productState.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stackTrace) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Something went wrong'),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  ref.invalidate(
                    productDetailProvider(productId),
                  );
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
        data: (product) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 280,
                  child: PageView.builder(
                    itemCount: product.images.length,
                    itemBuilder: (context, index) {
                      return Image.network(
                        product.images[index],
                        fit: BoxFit.contain,
                        errorBuilder: (
                          context,
                          error,
                          stackTrace,
                        ) {
                          return const Center(
                            child: Icon(
                              Icons.broken_image,
                              size: 48,
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  product.title,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall,
                ),
                const SizedBox(height: 12),
                Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(Icons.star),
                    const SizedBox(width: 4),
                    Text(
                      product.rating.toStringAsFixed(1),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  product.description,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}