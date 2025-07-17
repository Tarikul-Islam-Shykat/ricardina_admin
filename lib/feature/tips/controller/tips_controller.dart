import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/const/app_colors.dart';
import 'package:prettyrini/core/global_widegts/app_snackbar.dart';
import 'package:prettyrini/core/global_widegts/loading_screen.dart';
import 'package:prettyrini/core/network_caller/endpoints.dart';
import 'package:prettyrini/core/network_caller/network_config.dart';
import 'package:prettyrini/feature/tips/data/category_model.dart';
import 'package:prettyrini/feature/tips/data/health_card.dart';

class TipsController extends GetxController {
  final NetworkConfig _networkConfig = NetworkConfig();
  // Observable list of health cards
  final RxList<HealthCard> _healthCards = <HealthCard>[].obs;
  final RxList<HealthCard> _filteredCards = <HealthCard>[].obs;
  final Rx<HealthType?> _selectedType = Rx<HealthType?>(null);
  final RxBool _isLoading = false.obs;

  // Getters
  List<HealthCard> get healthCards => _healthCards;
  List<HealthCard> get filteredCards => _filteredCards;
  HealthType? get selectedType => _selectedType.value;
  bool get isLoading => _isLoading.value;

  @override
  void onInit() {
    super.onInit();
    loadHealthCards();
    getCategories();
  }

  var categories = <CategoryModel>[].obs;
  var selectedCategoryId = ''.obs; // Empty string means "All" is selected
  final isCategoryLoading = false.obs;

  void filterByCategory(String? categoryId) {
    selectedCategoryId.value = categoryId ?? '';
    // Add your filtering logic here
  }

  Future<bool> getCategories() async {
    try {
      isCategoryLoading.value = true;
      final response = await _networkConfig.ApiRequestHandler(
        RequestMethod.GET,
        Urls.getCategories,
        {},
        is_auth: true,
      );
      if (response != null && response['success'] == true) {
        List<dynamic> categoryData = response['data'] ?? [];
        categories.value =
            categoryData.map((item) => CategoryModel.fromJson(item)).toList();
        // AppSnackbar.show(
        //     message: "Categories loaded successfully", isSuccess: true);
        return true;
      } else {
        AppSnackbar.show(message: response['message'], isSuccess: false);
        return false;
      }
    } catch (e) {
      AppSnackbar.show(
          message: "Failed to load categories: $e", isSuccess: false);
      return false;
    } finally {
      isCategoryLoading.value = false;
    }
  }

  Future<bool> addNewCategory(String categoryName) async {
    try {
      isCategoryLoading.value = true;
      final Map<String, dynamic> requestBody = {
        "name": categoryName,
      };
      final response = await _networkConfig.ApiRequestHandler(
        RequestMethod.POST,
        Urls.getCategories, // Same URL but POST method
        jsonEncode(requestBody),
        is_auth: true,
      );

      if (response != null && response['success'] == true) {
        AppSnackbar.show(
            message: "Category added successfully", isSuccess: true);
        // Refresh categories after adding
        await getCategories();
        return true;
      } else {
        AppSnackbar.show(
            message: response['message'] ?? "Failed to add category",
            isSuccess: false);
        return false;
      }
    } catch (e) {
      AppSnackbar.show(message: "Failed to add category: $e", isSuccess: false);
      return false;
    } finally {
      isCategoryLoading.value = false;
    }
  }

  void showAddCategoryDialog(BuildContext context) {
    final TextEditingController nameController = TextEditingController();

    Get.dialog(
      AlertDialog(
        title: const Text("Add New Category"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              cursorColor: AppColors.primaryColor, // pointer/cursor color
              decoration: InputDecoration(
                labelText: "Category Name",
                hintText: "Enter category name",
                labelStyle: TextStyle(color: AppColors.primaryColor),
                hintStyle:
                    TextStyle(color: AppColors.primaryColor.withOpacity(0.6)),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: AppColors.primaryColor, width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: AppColors.primaryColor, width: 1.0),
                ),
              ),
              autofocus: true,
              style:
                  TextStyle(color: AppColors.primaryColor), // input text color
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text(
              "Cancel",
              style: TextStyle(color: AppColors.primaryColor),
            ),
          ),
          Obx(() => ElevatedButton(
                onPressed: isCategoryLoading.value
                    ? null
                    : () async {
                        if (nameController.text.trim().isNotEmpty) {
                          final success =
                              await addNewCategory(nameController.text.trim());
                          if (success) {
                            Get.back();
                            Navigator.pop(context);
                          }
                        } else {
                          AppSnackbar.show(
                              message: "Please enter a category name",
                              isSuccess: false);
                        }
                      },
                child: isCategoryLoading.value
                    ? loadingSmall()
                    : const Text(
                        "Add",
                        style: TextStyle(color: AppColors.primaryColor),
                      ),
              )),
        ],
      ),
    );
  }

  // Load health cards data
  void loadHealthCards() {
    _isLoading.value = true;

    // Simulate loading delay
    Future.delayed(const Duration(milliseconds: 500), () {
      _healthCards.value = HealthData.getHealthCards();
      // Initially show all cards
      _filteredCards.value = _healthCards;
      _isLoading.value = false;
    });
  }

  // Filter cards by type
  void filterByType(HealthType? type) {
    _selectedType.value = type;

    if (type == null) {
      // Show all cards when no type is selected
      _filteredCards.value = _healthCards;
    } else {
      // Filter cards by selected type
      _filteredCards.value =
          _healthCards.where((card) => card.type == type).toList();
    }
  }

  // Get cards by specific type
  List<HealthCard> getCardsByType(HealthType type) {
    return _healthCards.where((card) => card.type == type).toList();
  }

  // Get all unique types from health cards
  List<HealthType> getAvailableTypes() {
    return _healthCards.map((card) => card.type).toSet().toList();
  }

  // Get count of cards for each type
  int getCardCountByType(HealthType type) {
    return _healthCards.where((card) => card.type == type).length;
  }

  // Get type color
  Color getTypeColor(HealthType type) {
    switch (type) {
      case HealthType.heart:
        return const Color(0xFFE74C3C);
      case HealthType.blood:
        return const Color(0xFFE55353);
      case HealthType.water:
        return const Color(0xFF3498DB);
      case HealthType.step:
        return const Color(0xFF2ECC71);
      case HealthType.weight:
        return const Color(0xFFE67E22);
      case HealthType.health:
        return const Color(0xFF9B59B6);
      default:
        return const Color(0xFF34495E);
    }
  }

  // Get type icon
  IconData getTypeIcon(HealthType type) {
    switch (type) {
      case HealthType.heart:
        return Icons.favorite;
      case HealthType.blood:
        return Icons.bloodtype;
      case HealthType.water:
        return Icons.water_drop;
      case HealthType.step:
        return Icons.directions_walk;
      case HealthType.weight:
        return Icons.monitor_weight;
      case HealthType.health:
        return Icons.health_and_safety;
      default:
        return Icons.health_and_safety;
    }
  }

  // Get type display name
  String getTypeDisplayName(HealthType type) {
    switch (type) {
      case HealthType.heart:
        return "Heart";
      case HealthType.blood:
        return "Blood";
      case HealthType.water:
        return "Water";
      case HealthType.step:
        return "Steps";
      case HealthType.weight:
        return "Weight";
      case HealthType.health:
        return "Health";
      default:
        return "Health";
    }
  }

  // Search functionality
  void searchCards(String query) {
    if (query.isEmpty) {
      filterByType(_selectedType.value);
      return;
    }

    List<HealthCard> searchBase = _selectedType.value == null
        ? _healthCards
        : _healthCards
            .where((card) => card.type == _selectedType.value)
            .toList();

    final searchResults = searchBase.where((card) {
      return card.title.toLowerCase().contains(query.toLowerCase()) ||
          card.description.toLowerCase().contains(query.toLowerCase());
    }).toList();

    _filteredCards.value = searchResults;
  }

  // Refresh data
  void refreshData() {
    loadHealthCards();
  }

  // Clear filter
  void clearFilter() {
    _selectedType.value = null;
    _filteredCards.value = _healthCards;
  }

  // Check if filter is active
  bool get isFilterActive => _selectedType.value != null;

  // Get filtered count
  int get filteredCount => _filteredCards.length;

  // Get total count
  int get totalCount => _healthCards.length;
}
