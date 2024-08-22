// product_controller.dart
import 'package:get/get.dart';

import '../models/product_review_ProductModel.dart';




class ProductReviewController  extends GetxController {
  final RxList<Product> products = <Product>[].obs;
  final Rx<Product?> selectedProduct = Rx<Product?>(null);

  @override
  void onInit() {
    super.onInit();
    _loadProducts();
  }

  void _loadProducts() {
    products.addAll([
      Product(
        id: '1',
        name: 'Premium Wireless Headphones',
        description: 'High-quality wireless headphones with noise cancellation and long battery life.',
        price: 199.99,
        imageUrl: 'https://t3.ftcdn.net/jpg/02/50/92/10/360_F_250921070_wiWoQlB5TWmFsnZHB2PC43aoLXOpwaPi.jpg',
        rating: 4.5,
        reviews: [
          Review(id: '1', userName: 'John Doe', comment: 'Great sound quality and comfortable to wear!', rating: 5.0, date: DateTime(2023, 5, 1)),
          Review(id: '2', userName: 'Jane Smith', comment: 'Good battery life, but a bit pricey.', rating: 4.0, date: DateTime(2023, 4, 28)),
        ],
      ),
      Product(
        id: '2',
        name: 'Smart Fitness Tracker',
        description: 'Track your fitness goals with this advanced smartwatch.',
        price: 129.99,
        imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTW1yhlTpkCnujnhzP-xioiy9RdDQkKLMnMSg&s',
        rating: 4.3,
        reviews: [
          Review(id: '3', userName: 'Mike Johnson', comment: 'Accurate tracking and great battery life!', rating: 4.5, date: DateTime(2023, 5, 3)),
          Review(id: '4', userName: 'Sarah Lee', comment: 'Love the sleep tracking feature.', rating: 4.0, date: DateTime(2023, 5, 2)),
        ],
      ),
      Product(
        id: '3',
        name: 'Portable Bluetooth Speaker',
        description: 'Compact and waterproof speaker with amazing sound quality.',
        price: 79.99,
        imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQJjMKPmbhk96hzTwbAkzUlXE-Re1kyYGVqYg&s',
        rating: 4.7,
        reviews: [
          Review(id: '5', userName: 'David Brown', comment: 'Impressive sound for its size!', rating: 5.0, date: DateTime(2023, 4, 30)),
          Review(id: '6', userName: 'Emily White', comment: 'Perfect for outdoor use.', rating: 4.5, date: DateTime(2023, 4, 29)),
        ],
      ),
      Product(
        id: '4',
        name: 'Ultra HD 4K TV',
        description: '55-inch Smart TV with stunning picture quality and built-in streaming apps.',
        price: 699.99,
        imageUrl: 'https://a.storyblok.com/f/165154/1280x720/a4c06ff7b1/01_hero-image_20-trending-ecommerce-products-to-sell-in-2023.jpg',
        rating: 4.6,
        reviews: [
          Review(id: '7', userName: 'Robert Green', comment: 'Amazing picture quality!', rating: 5.0, date: DateTime(2023, 5, 4)),
          Review(id: '8', userName: 'Lisa Taylor', comment: 'Easy to set up and use.', rating: 4.5, date: DateTime(2023, 5, 3)),
        ],
      ),
      Product(
        id: '5',
        name: 'Professional DSLR Camera',
        description: 'High-end camera for photography enthusiasts and professionals.',
        price: 1299.99,
        imageUrl: 'https://images.pexels.com/photos/3944405/pexels-photo-3944405.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
        rating: 4.8,
        reviews: [
          Review(id: '9', userName: 'Chris Anderson', comment: 'Exceptional image quality and features!', rating: 5.0, date: DateTime(2023, 5, 2)),
          Review(id: '10', userName: 'Amanda Clark', comment: 'A bit heavy, but worth it for the quality.', rating: 4.5, date: DateTime(2023, 5, 1)),
        ],
      ),
      Product(
        id: '6',
        name: 'Electric Scooter',
        description: 'Foldable electric scooter with long range and fast charging.',
        price: 399.99,
        imageUrl: 'https://www.shutterstock.com/image-photo/cosmetics-packaging-set-different-cosmetic-600nw-2109839063.jpg',
        rating: 4.4,
        reviews: [
          Review(id: '11', userName: 'Tom Wilson', comment: 'Great for commuting!', rating: 4.5, date: DateTime(2023, 4, 30)),
          Review(id: '12', userName: 'Emma Davis', comment: 'Smooth ride, but could use better suspension.', rating: 4.0, date: DateTime(2023, 4, 29)),
        ],
      ),
      Product(
        id: '7',
        name: 'Smart Home Security System',
        description: 'DIY home security system with cameras, sensors, and mobile app control.',
        price: 299.99,
        imageUrl: 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cHJvZHVjdHxlbnwwfHwwfHx8MA%3D%3D',
        rating: 4.5,
        reviews: [
          Review(id: '13', userName: 'Daniel Lee', comment: 'Easy to install and great peace of mind.', rating: 5.0, date: DateTime(2023, 5, 5)),
          Review(id: '14', userName: 'Olivia Martin', comment: 'Good features, but app could be more user-friendly.', rating: 4.0, date: DateTime(2023, 5, 4)),
        ],
      ),
      Product(
        id: '8',
        name: 'Robotic Vacuum Cleaner',
        description: 'Smart robot vacuum with mapping technology and app control.',
        price: 349.99,
        imageUrl: 'https://st3.depositphotos.com/1177973/12669/i/450/depositphotos_126693854-stock-photo-set-of-body-care-products.jpg',
        rating: 4.6,
        reviews: [
          Review(id: '15', userName: 'Sophie Turner', comment: 'Keeps my floors clean with minimal effort!', rating: 5.0, date: DateTime(2023, 5, 3)),
          Review(id: '16', userName: 'Jack Robinson', comment: 'Works well, but sometimes gets stuck under furniture.', rating: 4.0, date: DateTime(2023, 5, 2)),
        ],
      ),
      Product(
        id: '9',
        name: 'Ergonomic Office Chair',
        description: 'Comfortable and adjustable chair for long work hours.',
        price: 249.99,
        imageUrl: 'https://media.istockphoto.com/id/1136422297/photo/face-cream-serum-lotion-moisturizer-and-sea-salt-among-bamboo-leaves.jpg?s=612x612&w=0&k=20&c=mwzWVrDvJTkHlVf-8RL49Hs5xjuv1TrYcBW4DnWVt-0=',
        rating: 4.7,
        reviews: [
          Review(id: '17', userName: 'Nathan Scott', comment: 'Best chair I\'ve ever owned!', rating: 5.0, date: DateTime(2023, 5, 1)),
          Review(id: '18', userName: 'Rachel Green', comment: 'Very comfortable, but assembly was a bit tricky.', rating: 4.5, date: DateTime(2023, 4, 30)),
        ],
      ),
      Product(
        id: '10',
        name: 'Wireless Gaming Mouse',
        description: 'High-precision wireless mouse for gamers with customizable buttons.',
        price: 79.99,
        imageUrl: 'https://thumbs.dreamstime.com/b/set-care-beauty-products-skin-29817248.jpg',
        rating: 4.8,
        reviews: [
          Review(id: '19', userName: 'Alex Chen', comment: 'Responsive and comfortable for long gaming sessions!', rating: 5.0, date: DateTime(2023, 5, 6)),
          Review(id: '20', userName: 'Megan Fox', comment: 'Great mouse, but software could be more intuitive.', rating: 4.5, date: DateTime(2023, 5, 5)),
        ],
      ),
    ]);
  }

  void addReview(Product product, Review review) {
    product.reviews.add(review);
    products.refresh(); // This will update the UI wherever products are used
  }

  double getAverageRating(Product product) {
    if (product.reviews.isEmpty) return 0.0;
    return product.reviews.map((r) => r.rating).reduce((a, b) => a + b) / product.reviews.length;
  }
}




