import 'package:get/get.dart';

class DoctorsController extends GetxController {
  // User stats
  String totalOrders = "25+";
  String pendingOrders = "05";

  // Stats percentages
  String totalOrdersPercentage = "20%";
  String pendingOrdersPercentage = "10%";

  bool totalOrdersIsPositive = true;
  bool pendingOrdersIsPositive = false;

  // Dummy pending bookings list
  List<DoctorsModel> pendingBookings = [
    DoctorsModel(
        name: "Dr. Jonathons ",
        image:
            "https://unsplash.com/photos/ready-to-help-cheerful-pleasant-positive-pediatrician-holding-pen-and-expressing-gladness-while-sitting-at-the-table-FLvJ1TUDuaU",
        description:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
        rating: 4.9),
    DoctorsModel(
        name: "Dr. Richard ",
        image:
            "https://unsplash.com/photos/man-in-white-dress-shirt-wearing-black-framed-eyeglasses-pTrhfmj2jDA",
        description:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
        rating: 3.9),
    DoctorsModel(
        name: "Dr. Darlene",
        image:
            "https://unsplash.com/photos/a-woman-in-a-white-coat-O13B7suRG4A",
        description:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
        rating: 2.9),
    DoctorsModel(
        name: "Dr. Courtney ",
        image:
            "https://unsplash.com/photos/woman-standing-under-tree-FVh_yqLR9eA",
        description:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
        rating: 4.2),
    DoctorsModel(
        name: "Dr. Ronald ",
        image:
            "https://unsplash.com/photos/portrait-of-successful-and-confident-middle-aged-specialist-male-doctor-crossed-arms-in-white-medical-gown-eyMWJKHryic",
        description:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
        rating: 4.1),
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
  void onBookingTap(DoctorsModel booking) {
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
        DoctorsModel(
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
class DoctorsModel {
  final String name;
  final String image;
  final String description;
  final double rating;

  DoctorsModel({
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
  factory DoctorsModel.fromJson(Map<String, dynamic> json) {
    return DoctorsModel(
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      description: json['description'] ?? '',
      rating: json['rating'] ?? '',
    );
  }
}
