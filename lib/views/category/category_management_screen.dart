// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
//
// class CategoryGridView extends GetView<CategoryController> {
//   static const routeName = "/all_categories";
//
//   @override
//   Widget build(BuildContext context) {
//     // Fetch categories when the view is first built
//     controller.getCategories();
//
//     return Scaffold(
//       appBar: AppBar(title: Text('Category Grid')),
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return Center(child: CircularProgressIndicator());
//         } else if (controller.categories.isEmpty) {
//           return Center(child: Text('No categories available.'));
//         } else {
//           return GridView.builder(
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2, // Number of columns in the grid
//               crossAxisSpacing: 10.0, // Space between columns
//               mainAxisSpacing: 10.0, // Space between rows
//               childAspectRatio: 0.75, // Aspect ratio of each item
//             ),
//             itemCount: controller.categories.length,
//             itemBuilder: (context, index) {
//               final category = controller.categories[index];
//               return Stack(
//                 children: [
//                   Card(
//                     elevation: 3,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Expanded(
//                           child: category.imageUrl != null
//                               ? Image.network(
//                             "https://baburhaatbd.com${category.imageUrl}",
//                             fit: BoxFit.cover,
//                             width: double.infinity,
//                           )
//                               : Container(color: Colors.grey),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text(
//                             category.name ?? '',
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                             ),
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Positioned(
//                     top: 8,
//                     right: 8,
//                     child: PopupMenuButton<String>(
//                       onSelected: (value) {
//                         if (value == 'update') {
//                           controller.updateCategory(category);
//                         } else if (value == 'delete') {
//                           controller.deleteCategory(category);
//                         }
//                       },
//                       itemBuilder: (context) => [
//                         PopupMenuItem(
//                           value: 'update',
//                           child: Text('Update Category'),
//                         ),
//                         PopupMenuItem(
//                           value: 'delete',
//                           child: Text('Delete Category'),
//                         ),
//                       ],
//                       icon: Icon(Icons.more_vert),
//                     ),
//                   ),
//                 ],
//               );
//             },
//           );
//         }
//       }),
//     );
//   }
// }
