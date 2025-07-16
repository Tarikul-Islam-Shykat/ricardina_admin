// controllers/booking_summary_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prettyrini/feature/booking_summary/model/summary_model.dart';

class BookingSummaryController extends GetxController {
  // Observable booking data
  final Rx<BookingModel?> booking = Rx<BookingModel?>(null);
  
  // Loading states
  final RxBool isLoading = false.obs;
  final RxBool isCompleting = false.obs;
  
  // Status
  final RxString bookingStatus = 'confirmed'.obs;

  @override
  void onInit() {
    super.onInit();
    loadBookingData();
  }

  // Load dummy booking data
  void loadBookingData() {
    isLoading.value = true;
    
    // Simulate API call
    Future.delayed(const Duration(milliseconds: 800), () {
      booking.value = BookingModel(
        id: 'booking_001',
        date: '12-04-2025',
        time: '10:20 - 10:30 PM',
        status: 'On time',
        statusMessage: "We've got your booking!",
        doctor: DoctorModel(
          id: 'doc_001',
          name: 'Dr C. DELOITRE',
          title: 'Cardiologist',
          imageUrl: 'assets/images/doctor_avatar.png', // Placeholder
          hourlyRate: 30.0,
          duration: '1 hour',
        ),
        patient: PatientModel(
          id: 'patient_001',
          name: 'Dianne Russell',
          imageUrl: 'assets/images/patient_avatar.png', // Placeholder
          favoriteMessage: 'Save this hospital to Favorites and find it quickly next time.',
        ),
        receipt: ReceiptModel(
          subtotal: 30.0,
          vat: 2.0,
          totalBill: 22.0,
          currency: '\$',
        ),
      );
      
      isLoading.value = false;
    });
  }

  // Mark booking as complete
  Future<void> markAsComplete() async {
    if (booking.value == null) return;
    
    isCompleting.value = true;
    
    try {
      // Simulate API call to mark as complete
      await Future.delayed(const Duration(milliseconds: 1500));
      
      bookingStatus.value = 'completed';
      
      // Show success message
      Get.snackbar(
        'Success',
        'Booking marked as complete!',
        backgroundColor: const Color(0xFF4CAF50),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
      );
      
      // Navigate back or to next screen
      Future.delayed(const Duration(seconds: 1), () {
        Get.back();
      });
      
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to complete booking. Please try again.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isCompleting.value = false;
    }
  }

  // Add to favorites
  void addToFavorites() {
    if (booking.value == null) return;
    
    Get.snackbar(
      'Added to Favorites',
      'Hospital added to your favorites!',
      backgroundColor: const Color(0xFF2196F3),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  // Get formatted date and time
  String get formattedDateTime {
    if (booking.value == null) return '';
    return '${booking.value!.date} / ${booking.value!.time}';
  }

  // Get status color
  Color get statusColor {
    switch (bookingStatus.value.toLowerCase()) {
      case 'completed':
        return const Color(0xFF4CAF50);
      case 'on time':
      case 'confirmed':
        return const Color(0xFF4ECDC4);
      case 'delayed':
        return const Color(0xFFFF9800);
      case 'cancelled':
        return const Color(0xFFF44336);
      default:
        return const Color(0xFF4ECDC4);
    }
  }

  // Refresh booking data
  void refreshBooking() {
    loadBookingData();
  }

  // Navigate back
  void goBack() {
    Get.back();
  }
}