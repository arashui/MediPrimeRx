import 'package:hive/hive.dart';

part 'customer.g.dart'; // Needed for Hive type adapter

@HiveType(typeId: 0) // Unique typeId for this model
class Customer {
  @HiveField(0)
  final int customerId;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String email;

  @HiveField(3)
  final String phoneNumber;

  @HiveField(4)
  final String address;

  @HiveField(5)
  final String city;

  @HiveField(6)
  final String state;

  @HiveField(7)
  final String zipCode;

  @HiveField(8)
  final DateTime registrationDate;

  @HiveField(9)
  final String preferredPaymentMethod; // e.g., "Cash", "Card", "UPI"

  @HiveField(10)
  final double totalSpent;

  @HiveField(11)
  final double outstandingBalance;

  @HiveField(12)
  final String notes;

  Customer({
    required this.customerId,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.registrationDate,
    required this.preferredPaymentMethod,
    required this.totalSpent,
    required this.outstandingBalance,
    required this.notes,
  });

  /// Converts a JSON map into a `Customer` instance
  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      customerId: json['customerId'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
      city: json['city'],
      state: json['state'],
      zipCode: json['zipCode'],
      registrationDate: DateTime.parse(json['registrationDate']),
      preferredPaymentMethod: json['preferredPaymentMethod'],
      totalSpent: (json['totalSpent'] as num).toDouble(),
      outstandingBalance: (json['outstandingBalance'] as num).toDouble(),
      notes: json['notes'],
    );
  }

  /// Converts a `Customer` instance into a JSON map
  Map<String, dynamic> toJson() {
    return {
      'customerId': customerId,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'address': address,
      'city': city,
      'state': state,
      'zipCode': zipCode,
      'registrationDate': registrationDate.toIso8601String(),
      'preferredPaymentMethod': preferredPaymentMethod,
      'totalSpent': totalSpent,
      'outstandingBalance': outstandingBalance,
      'notes': notes,
    };
  }
}
