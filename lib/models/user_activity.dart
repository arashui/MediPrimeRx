import 'package:hive/hive.dart';

part 'user_activity.g.dart'; // Needed for Hive type adapter

@HiveType(typeId: 6) // Unique typeId for this model
class UserActivity {
  @HiveField(0)
  final int activityId;

  @HiveField(1)
  final String userId;

  @HiveField(2)
  final String activityType; // e.g., "Login", "Add Item", "Update Item", "Delete Item"

  @HiveField(3)
  final String description; // Detailed description of the activity

  @HiveField(4)
  final DateTime timestamp;

  @HiveField(5)
  final String ipAddress;

  @HiveField(6)
  final String deviceInfo;

  @HiveField(7)
  final String status; // e.g., "Success", "Failed"

  @HiveField(8)
  final bool isRegularCustomer;

  UserActivity({
    required this.activityId,
    required this.userId,
    required this.activityType,
    required this.description,
    required this.timestamp,
    required this.ipAddress,
    required this.deviceInfo,
    required this.status,
    required this.isRegularCustomer,
  });

  /// Converts a JSON map into a `UserActivity` instance
  factory UserActivity.fromJson(Map<String, dynamic> json) {
    return UserActivity(
      activityId: json['activityId'],
      userId: json['userId'],
      activityType: json['activityType'],
      description: json['description'],
      timestamp: DateTime.parse(json['timestamp']),
      ipAddress: json['ipAddress'],
      deviceInfo: json['deviceInfo'],
      status: json['status'],
      isRegularCustomer: json['isRegularCustomer'],
    );
  }

  /// Converts a `UserActivity` instance into a JSON map
  Map<String, dynamic> toJson() {
    return {
      'activityId': activityId,
      'userId': userId,
      'activityType': activityType,
      'description': description,
      'timestamp': timestamp.toIso8601String(),
      'ipAddress': ipAddress,
      'deviceInfo': deviceInfo,
      'status': status,
      'isRegularCustomer': isRegularCustomer,
    };
  }
}
