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

class Review {
  final String id;
  final String userName;
  final String comment;
  final double rating;
  final DateTime date;
  final String? vendorReply;

  Review({
    required this.id,
    required this.userName,
    required this.comment,
    required this.rating,
    required this.date,
    this.vendorReply,
  });


  Review copyWith({
    String? id,
    String? userName,
    String? comment,
    double? rating,
    DateTime? date,
    String? vendorReply,
  }) {
    return Review(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      comment: comment ?? this.comment,
      rating: rating ?? this.rating,
      date: date ?? this.date,
      vendorReply: vendorReply ?? this.vendorReply,
    );
  }
}
