import 'package:flutter_test/flutter_test.dart';
import 'package:product_catalog/data/models/product.dart';

void main() {
  group('Product.fromJson', () {
    test('creates a Product from valid JSON', () {
      final json = {
        'id': 1,
        'title': 'Test Product',
        'description': 'Test description',
        'price': 99.99,
        'rating': 4.5,
        'thumbnail': 'https://example.com/image.jpg',
        'images': [
          'https://example.com/image1.jpg',
          'https://example.com/image2.jpg',
        ],
      };

      final product = Product.fromJson(json);

      expect(product.id, 1);
      expect(product.title, 'Test Product');
      expect(product.description, 'Test description');
      expect(product.price, 99.99);
      expect(product.rating, 4.5);
      expect(product.thumbnail, 'https://example.com/image.jpg');
      expect(product.images.length, 2);
    });
  });
}