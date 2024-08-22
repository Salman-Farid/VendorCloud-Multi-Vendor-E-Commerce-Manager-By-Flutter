// product_model.dart
class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final double rating;
  final List<Review> reviews;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.rating,
    required this.reviews,
  });
}

// review_model.dart
class Review {
  final String id;
  final String userName;
  final String comment;
  final double rating;
  final DateTime date;

  Review({
    required this.id,
    required this.userName,
    required this.comment,
    required this.rating,
    required this.date,
  });
}
