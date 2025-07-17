import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/const/app_colors.dart';
import 'package:prettyrini/core/global_widegts/loading_screen.dart';
import 'package:prettyrini/feature/dashboard/ui/dashboard.dart';
import 'package:prettyrini/feature/tips/controller/tips_controller.dart';
import 'package:prettyrini/feature/tips/widget/tips_card_widget.dart';
import 'package:prettyrini/feature/tips/data/health_card.dart';

class TipsUi extends StatefulWidget {
  const TipsUi({Key? key}) : super(key: key);

  @override
  State<TipsUi> createState() => _TipsUiScreenState();
}

class _TipsUiScreenState extends State<TipsUi> {
  final TipsController controller = Get.put(TipsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 60),
            _buildHeader(),
            const SizedBox(height: 20),
            Obx(() => controller.isCategoryLoading.value
                ? btnLoading()
                : _buildCategoryFilter()),
            const SizedBox(height: 20),
            _buildTipsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          headingText(text: "Health Tips"),
          GestureDetector(
            onTap: _showAddTipBottomSheet,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryColor,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Category Filter UI Widget
  Widget _buildCategoryFilter() {
    return Container(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount:
            controller.categories.length + 2, // +2 for "All" and "Add New"
        itemBuilder: (context, index) {
          if (index == 0) {
            // "All" option - always first and selected by default
            return Obx(() => _buildCategoryChip(
                  label: "All",
                  isSelected: controller.selectedCategoryId.value.isEmpty,
                  onTap: () => controller.filterByCategory(null),
                ));
          }

          if (index == controller.categories.length + 1) {
            // "Add New Category" option - always last
            return _buildAddCategoryChip();
          }

          final category = controller.categories[index - 1];
          return Obx(() => _buildCategoryChip(
                label: category.name,
                isSelected: controller.selectedCategoryId.value == category.id,
                onTap: () => controller.filterByCategory(category.id),
              ));
        },
      ),
    );
  }

  Widget _buildAddCategoryChip() {
    return GestureDetector(
      onTap: () => controller.showAddCategoryDialog(context),
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: AppColors.primaryColor,
            width: 1,
            style: BorderStyle.solid,
          ),
        ),
        child: Text(
          "+ Add New",
          style: TextStyle(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryChip({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: isSelected ? AppColors.primaryColor : Colors.grey.shade300,
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey.shade600,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildTipsList() {
    return Obx(() {
      if (controller.isLoading) {
        return const Padding(
          padding: EdgeInsets.all(50.0),
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2C3E50)),
          ),
        );
      }

      if (controller.filteredCards.isEmpty) {
        return const Padding(
          padding: EdgeInsets.all(50.0),
          child: Text(
            'No health cards found',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey,
            ),
          ),
        );
      }

      return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: controller.filteredCards
              .map((card) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: TipsCardWidget(
                      card: card,
                      controller: controller,
                    ),
                  ))
              .toList(),
        ),
      );
    });
  }

  String _getTypeDisplayName(HealthType type) {
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

  void _showAddTipBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildAddTipBottomSheet(),
    );
  }

  Widget _buildAddTipBottomSheet() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(top: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 20),

          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Create New Tips',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2C3E50),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(
                      Icons.close,
                      size: 20,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),

          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Select Category
                  const Text(
                    'Select Category',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2C3E50),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey.shade50,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Select Category',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                          ),
                        ),
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.grey.shade600,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Word Limit
                  const Text(
                    'Word Limit',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2C3E50),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey.shade50,
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'How Many words you want to generate',
                        hintStyle: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),

                  // Generate Button
                  Container(
                    width: double.infinity,
                    height: 50,
                    margin: const EdgeInsets.only(bottom: 30),
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle generate tips action
                        Navigator.pop(context);
                        Get.snackbar(
                          'Success',
                          'Tips generation feature coming soon!',
                          backgroundColor: AppColors.primaryColor,
                          colorText: Colors.white,
                          snackPosition: SnackPosition.TOP,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2ECC71),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                      child: const Text(
                        'Generate Tips',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
