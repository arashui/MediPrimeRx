import 'package:hive/hive.dart';

part 'pharmacy.g.dart'; // Needed for Hive type adapter

@HiveType(typeId: 3) // Unique typeId for this model
class Pharmacy {
  @HiveField(0)
  final int id; // Unique ID for the pharmacy

  @HiveField(1)
  final String name; // Name of the pharmacy

  @HiveField(2)
  final String location; // Address or location of the pharmacy

  @HiveField(3)
  final String contactNumber; // Contact number of the pharmacy

  @HiveField(4)
  final String email; // Email of the pharmacy

  @HiveField(5)
  final String ownerName; // Name of the owner of the pharmacy

  @HiveField(6)
  final DateTime registrationDate; // Registration date of the pharmacy

  @HiveField(7)
  final String licenseNumber; // License number of the pharmacy

  @HiveField(8)
  final List<String> servicesOffered; // List of services (e.g., delivery, consultation)

  @HiveField(9)
  final List<String> operatingHours; // Operating hours (e.g., Monday to Friday: 9 AM - 8 PM)

  @HiveField(10)
  final bool isActive; // Whether the pharmacy is currently active

  Pharmacy({
    required this.id,
    required this.name,
    required this.location,
    required this.contactNumber,
    required this.email,
    required this.ownerName,
    required this.registrationDate,
    required this.licenseNumber,
    required this.servicesOffered,
    required this.operatingHours,
    required this.isActive,
  });

  /// Converts a JSON map into a `Pharmacy` instance
  factory Pharmacy.fromJson(Map<String, dynamic> json) {
    return Pharmacy(
      id: json['id'],
      name: json['name'],
      location: json['location'],
      contactNumber: json['contactNumber'],
      email: json['email'],
      ownerName: json['ownerName'],
      registrationDate: DateTime.parse(json['registrationDate']),
      licenseNumber: json['licenseNumber'],
      servicesOffered: List<String>.from(json['servicesOffered']),
      operatingHours: List<String>.from(json['operatingHours']),
      isActive: json['isActive'],
    );
  }

  /// Converts a `Pharmacy` instance into a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'contactNumber': contactNumber,
      'email': email,
      'ownerName': ownerName,
      'registrationDate': registrationDate.toIso8601String(),
      'licenseNumber': licenseNumber,
      'servicesOffered': servicesOffered,
      'operatingHours': operatingHours,
      'isActive': isActive,
    };
  }
}
