// models/booking_model.dart
class BookingModel {
  final String id;
  final String date;
  final String time;
  final String status;
  final String statusMessage;
  final DoctorModel doctor;
  final PatientModel patient;
  final ReceiptModel receipt;

  BookingModel({
    required this.id,
    required this.date,
    required this.time,
    required this.status,
    required this.statusMessage,
    required this.doctor,
    required this.patient,
    required this.receipt,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'] ?? '',
      date: json['date'] ?? '',
      time: json['time'] ?? '',
      status: json['status'] ?? '',
      statusMessage: json['statusMessage'] ?? '',
      doctor: DoctorModel.fromJson(json['doctor'] ?? {}),
      patient: PatientModel.fromJson(json['patient'] ?? {}),
      receipt: ReceiptModel.fromJson(json['receipt'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'time': time,
      'status': status,
      'statusMessage': statusMessage,
      'doctor': doctor.toJson(),
      'patient': patient.toJson(),
      'receipt': receipt.toJson(),
    };
  }
}

class DoctorModel {
  final String id;
  final String name;
  final String title;
  final String imageUrl;
  final double hourlyRate;
  final String duration;

  DoctorModel({
    required this.id,
    required this.name,
    required this.title,
    required this.imageUrl,
    required this.hourlyRate,
    required this.duration,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      title: json['title'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      hourlyRate: (json['hourlyRate'] ?? 0).toDouble(),
      duration: json['duration'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'title': title,
      'imageUrl': imageUrl,
      'hourlyRate': hourlyRate,
      'duration': duration,
    };
  }
}

class PatientModel {
  final String id;
  final String name;
  final String imageUrl;
  final String favoriteMessage;

  PatientModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.favoriteMessage,
  });

  factory PatientModel.fromJson(Map<String, dynamic> json) {
    return PatientModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      favoriteMessage: json['favoriteMessage'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'favoriteMessage': favoriteMessage,
    };
  }
}

class ReceiptModel {
  final double subtotal;
  final double vat;
  final double totalBill;
  final String currency;

  ReceiptModel({
    required this.subtotal,
    required this.vat,
    required this.totalBill,
    this.currency = '\$',
  });

  factory ReceiptModel.fromJson(Map<String, dynamic> json) {
    return ReceiptModel(
      subtotal: (json['subtotal'] ?? 0).toDouble(),
      vat: (json['vat'] ?? 0).toDouble(),
      totalBill: (json['totalBill'] ?? 0).toDouble(),
      currency: json['currency'] ?? '\$',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subtotal': subtotal,
      'vat': vat,
      'totalBill': totalBill,
      'currency': currency,
    };
  }
}