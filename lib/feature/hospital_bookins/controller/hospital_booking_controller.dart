import 'package:get/get.dart';

class HospitalBookingController extends GetxController {
  // User stats
  String totalOrders = "25+";
  String pendingOrders = "05";
  
  // Stats percentages
  String totalOrdersPercentage = "20%";
  String pendingOrdersPercentage = "10%";
  
  bool totalOrdersIsPositive = true;
  bool pendingOrdersIsPositive = false;
  
  // Dummy pending bookings list
  List<BookingModel> pendingBookings = [
    BookingModel(
      name: "Dianne Russell",
      image: "https://images.unsplash.com/photo-1494790108755-2616b612b786?w=150&h=150&fit=crop&crop=face",
      time: "12-04-2025 | 10:30 PM",
    ),
    BookingModel(
      name: "Guy Hawkins",
      image: "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150&h=150&fit=crop&crop=face",
      time: "12-04-2025 | 10:30 PM",
    ),
    BookingModel(
      name: "Jenny Wilson",
      image: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=150&h=150&fit=crop&crop=face",
      time: "12-04-2025 | 10:30 PM",
    ),
    BookingModel(
      name: "Darlene Robertson",
      image: "https://images.unsplash.com/photo-1547425260-76bcadfb4f2c?w=150&h=150&fit=crop&crop=face",
      time: "12-04-2025 | 10:30 PM",
    ),
    BookingModel(
      name: "Courtney Henry",
      image: "https://images.unsplash.com/photo-1489424731084-a5d8b219a5bb?w=150&h=150&fit=crop&crop=face",
      time: "13-04-2025 | 09:15 AM",
    ),
    BookingModel(
      name: "Ronald Richards",
      image: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=150&h=150&fit=crop&crop=face",
      time: "13-04-2025 | 11:45 AM",
    ),
  ];
  
  @override
  void onInit() {
    super.onInit();
    loadDashboardData();
  }
  
  // Load dashboard data (API calls would go here)
  void loadDashboardData() {
    // Simulate loading data
    print("Loading dashboard data...");
    
    // You can add API calls here to fetch real data
    // Example:
    // await fetchUserStats();
    // await fetchPendingBookings();
    
    update(); // Update UI after data is loaded
  }
  
  // Handle see all bookings tap
  void onSeeAllBookingsTap() {
    print("See all bookings tapped");
    // Navigate to all bookings screen
    // Get.toNamed('/all-bookings');
  }
  
  // Handle booking item tap
  void onBookingTap(BookingModel booking) {
    print("Booking tapped: ${booking.name}");
    // Navigate to booking details or show options
    // Get.toNamed('/booking-details', arguments: booking);
  }
  
  // Handle notification tap
  void onNotificationTap() {
    print("Notification tapped");
    // Navigate to notifications screen
    // Get.toNamed('/notifications');
  }
  
  // Refresh dashboard data
  Future<void> refreshDashboard() async {
    print("Refreshing dashboard...");
    // Add pull-to-refresh logic here
    await Future.delayed(const Duration(seconds: 2)); // Simulate API call
    loadDashboardData();
  }
  
  // Add new booking (for testing)
  void addNewBooking(String name, String image, String time) {
    pendingBookings.insert(0, BookingModel(
      name: name,
      image: image,
      time: time,
    ));
    update();
  }
  
  // Remove booking
  void removeBooking(int index) {
    if (index >= 0 && index < pendingBookings.length) {
      pendingBookings.removeAt(index);
      update();
    }
  }
  
  // Update stats (for testing or real-time updates)
  void updateStats({
    String? newTotalOrders,
    String? newPendingOrders,
    String? newTotalPercentage,
    String? newPendingPercentage,
  }) {
    if (newTotalOrders != null) totalOrders = newTotalOrders;
    if (newPendingOrders != null) pendingOrders = newPendingOrders;
    if (newTotalPercentage != null) totalOrdersPercentage = newTotalPercentage;
    if (newPendingPercentage != null) pendingOrdersPercentage = newPendingPercentage;
    
    update();
  }
}

// Booking model class
class BookingModel {
  final String name;
  final String image;
  final String time;
  
  BookingModel({
    required this.name,
    required this.image,
    required this.time,
  });
  
  // Convert to JSON (for API integration)
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'time': time,
    };
  }
  
  // Create from JSON (for API integration)
  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      time: json['time'] ?? '',
    );
  }
}