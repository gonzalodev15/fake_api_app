import 'package:fake_api_app/Models/ProductRating.dart';

class Product {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final ProductRating rating;

  const Product(
      {required this.id,
      required this.title,
      required this.price,
      required this.description,
      required this.category,
      required this.image,
      required this.rating});

  factory Product.fromJson(Map<String, dynamic> json) {
    final price = switch (json['price']) {
      double price => price,
      int price => price.toDouble(),
      _ => throw const FormatException('Invalid price type'),
    };

    return switch (json) {
      {
        'id': int id,
        'title': String title,
        'description': String description,
        'category': String category,
        'image': String image,
        'rating': Map<String, dynamic> rating
      } =>
        Product(
            id: id,
            title: title,
            price: price,
            description: description,
            category: category,
            image: image,
            rating: ProductRating.fromJson(rating)),
      _ => throw const FormatException('Failed to load product.'),
    };
  }
}
