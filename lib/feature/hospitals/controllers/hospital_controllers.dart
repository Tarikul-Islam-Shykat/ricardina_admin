import 'package:get/get.dart';

class HospitalControllers extends GetxController {
  // User stats
  String totalOrders = "25+";
  String pendingOrders = "05";

  // Stats percentages
  String totalOrdersPercentage = "20%";
  String pendingOrdersPercentage = "10%";

  bool totalOrdersIsPositive = true;
  bool pendingOrdersIsPositive = false;

  // Dummy pending bookings list
  List<HospitalModel> pendingBookings = [
    HospitalModel(
        name: "Jonathons Hostpital",
        image:
            "https://thumbs.dreamstime.com/b/modern-hospital-building-close-up-view-59693685.jpg",
        description:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
        rating: 4),
    HospitalModel(
        name: "Park Avenue Hospital",
        image:
            "https://thumbs.dreamstime.com/b/modern-hospital-building-close-up-view-59693685.jpg",
        description:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
        rating: 2),
    HospitalModel(
        name: "Darlene Hospital",
        image:
            "https://plus.unsplash.com/premium_photo-1672097247893-4f8660247b1f?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aG9zcGl0YWwlMjBidWlsZGluZ3xlbnwwfHwwfHx8MA%3D%3D",
        description:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
        rating: 2.5),
    HospitalModel(
        name: "Courtney Hospital",
        image:
            "https://thumbs.dreamstime.com/b/modern-hospital-building-close-up-view-59693685.jpg",
        description:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
        rating: 3.4),
    HospitalModel(
        name: "Ronald Hospital",
        image:
            "https://t3.ftcdn.net/jpg/02/11/15/66/360_F_211156620_CeBr5etdTNXLb231sFcQ8M9YD1OY5IW8.jpg",
        description:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
        rating: 4.2),
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
  void onBookingTap(HospitalModel booking) {
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
  void addNewBooking(String name, String image, String time, double rating) {
    pendingBookings.insert(
        0,
        HospitalModel(
            name: name, image: image, description: time, rating: rating));
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
    if (newPendingPercentage != null)
      pendingOrdersPercentage = newPendingPercentage;

    update();
  }
}

// Booking model class
class HospitalModel {
  final String name;
  final String image;
  final String description;
  final double rating;

  HospitalModel({
    required this.name,
    required this.image,
    required this.description,
    required this.rating,
  });

  // Convert to JSON (for API integration)
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'description': description,
      'rating': rating,
    };
  }

  // Create from JSON (for API integration)
  factory HospitalModel.fromJson(Map<String, dynamic> json) {
    return HospitalModel(
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      description: json['description'] ?? '',
      rating: json['rating'] ?? '',
    );
  }
}
