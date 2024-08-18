import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karmalab_assignment/services/sub_category_service.dart';
import '../models/category_model.dart';
import 'category_controller.dart';

class SubCategoryController extends CategoryController {
  final TextEditingController _categoryIdController = TextEditingController();
  final SubCategoryService _subCategoryService = SubCategoryService();

  // Getter for category ID controller
  TextEditingController get categoryIdController => _categoryIdController;

  @override
  bool validate() {
    final categoryId = categoryIdController.text.trim();
    if (categoryId.isEmpty) {
      Get.snackbar(
        'Validation Error',
        'Category ID is required.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
    return super.validate();
  }

  // Create subcategory
  Future<void> createSubCategory(
      Function(SubCategories?, {String? errorMessage})? onCreate) async {
    final valid = validate();

    if (valid) {
      final subCategory = SubCategories(
        category: categoryIdController.text,
        name: nameController.text,
        shippingCharge: shippingChargeController.text,
        vat: vatController.text,
        status: statusController.text,
        commission: commissionController.text,
      );

      try {
        isLoading.value = true;
        final createdSubCategory = await _subCategoryService.createSubCategory(subCategory.toJson());
        isLoading.value = false;
        if (onCreate != null) onCreate(createdSubCategory);
      } catch (e) {
        isLoading.value = false;
        if (onCreate != null) onCreate(null, errorMessage: e.toString());
      }
    }
  }

  // Update subcategory
  Future<void> updateSubCategoryById(String id, SubCategories subCategory) async {
    try {
      isLoading.value = true;
      final updatedSubCategoryResponse = await _subCategoryService.updateSubCategoryById(id, subCategory.toJson());
      isLoading.value = false;
      final updatedSubCategory = SubCategories.fromJson(updatedSubCategoryResponse as Map<String, dynamic>);
      // Handle the updated subcategory as needed
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', 'Failed to update subcategory: $e', snackPosition: SnackPosition.BOTTOM);
    }
  }

  // Delete subcategory
  Future<void> deleteSubCategory(String id, Function(bool, {String? errorMessage})? onDelete) async {
    try {
      isLoading.value = true;
      final success = await _subCategoryService.deleteSubCategoryById(id);
      isLoading.value = false;
      if (onDelete != null) onDelete(success);
    } catch (e) {
      isLoading.value = false;
      if (onDelete != null) onDelete(false, errorMessage: e.toString());
    }
  }
}