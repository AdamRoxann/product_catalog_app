import 'package:go_router/go_router.dart';
import 'package:product_catalog/presentation/screens/product_detail_screen.dart';
import 'package:product_catalog/presentation/screens/product_list_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/products',
  routes: [
    GoRoute(path: '/products', builder: (context, state) {
      return const ProductListScreen();
    }),
    GoRoute(path: '/product/:id', builder: (context, state) {
      final productId = int.tryParse(state.pathParameters['id'] ?? '') ?? 0;
      return ProductDetailScreen(
        productId: productId,
      );
    })
  ]
);