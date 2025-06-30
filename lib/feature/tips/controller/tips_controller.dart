import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prettyrini/feature/tips/data/health_card.dart';

class TipsController extends GetxController {
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
