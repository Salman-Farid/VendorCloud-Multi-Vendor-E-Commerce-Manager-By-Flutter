// import 'package:get/get.dart';
//
// import '../models/order_model.dart';
//
// class OrderController extends GetxController {
//   final orders = <Order>[].obs;
//   final isLoading = true.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchOrders();
//   }
//
//   void fetchOrders() async {
//     try {
//       isLoading(true);
//       // Simulating API call
//       await Future.delayed(Duration(seconds: 2));
//       final response = {
//         "status": "success",
//         "total": 1,
//         "data": [
//           {
//             "_id": "66c5baa71a1fdc7f11b375d4",
//             "products": [
//               {
//                 "product": "66bd94f2da8a30ffc85c1f1b",
//                 "price": 380.7,
//                 "quantity": 2,
//                 "_id": "66c5baa71a1fdc7f11b375d5"
//               },
//               {
//                 "product": "66bf4055db6e865e0466d602",
//                 "price": 23432,
//                 "quantity": 1,
//                 "_id": "66c5baa71a1fdc7f11b375d6"
//               }
//             ],
//             "status": "pending",
//             "currency": "bdt",
//             "paymentType": "cash",
//             "user": "66b8af66fc3c520a4f5633b0",
//             "shippingInfo": {
//               "name": "Md Abdullah",
//               "email": "mdabdullah.dev@gmail.com",
//               "phone": "01756155777",
//               "method": "Courier",
//               "address1": "525352",
//               "address2": "",
//               "city": "Kashiani",
//               "state": "Gopalganj",
//               "postcode": 24324,
//               "country": "Bangladesh",
//               "deliveryFee": 60,
//               "_id": "66c5baa71a1fdc7f11b375d7"
//             },
//             "createdAt": "2024-08-21T10:00:07.792Z",
//             "updatedAt": "2024-08-21T10:00:07.792Z",
//             "__v": 0
//           }
//         ]
//       };
//
//       if (response['status'] == 'success') {
//         orders.value = (response['data'] as List).map((order) => Order.fromJson(order)).toList();
//       }
//     } finally {
//       isLoading(false);
//     }
//   }
// }
