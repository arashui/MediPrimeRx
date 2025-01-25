import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/user_activity.dart'; // Adjust the path as needed

class UserActivityProvider with ChangeNotifier {
  late Box<UserActivity> _userActivityBox;

  Future<void> init() async {
    _userActivityBox = await Hive.openBox<UserActivity>('userActivity');
  }

  // Get all user activities
  List<UserActivity> getAllActivities() {
    return _userActivityBox.values.toList();
  }

  // Add a new user activity
  Future<void> addActivity(UserActivity activity) async {
    await _userActivityBox.put(activity.activityId, activity);
    notifyListeners();
  }

  // Update an existing user activity
  Future<void> updateActivity(UserActivity activity) async {
    if (_userActivityBox.containsKey(activity.activityId)) {
      await _userActivityBox.put(activity.activityId, activity);
      notifyListeners();
    } else {
      throw Exception("Activity with ID ${activity.activityId} does not exist.");
    }
  }

  // Delete a user activity by ID
  Future<void> deleteActivity(int activityId) async {
    await _userActivityBox.delete(activityId);
    notifyListeners();
  }

  // Get a specific user activity by ID
  UserActivity? getActivityById(int activityId) {
    return _userActivityBox.get(activityId);
  }

  // Get all activities for a specific user
  List<UserActivity> getActivitiesByUser(String userId) {
    return _userActivityBox.values
        .where((activity) => activity.userId == userId)
        .toList();
  }

  // Get activities filtered by type
  List<UserActivity> getActivitiesByType(String activityType) {
    return _userActivityBox.values
        .where((activity) => activity.activityType == activityType)
        .toList();
  }

  // Get activities with a specific status
  List<UserActivity> getActivitiesByStatus(String status) {
    return _userActivityBox.values
        .where((activity) => activity.status == status)
        .toList();
  }

  // Get all regular customer activities
  List<UserActivity> getRegularCustomerActivities() {
    return _userActivityBox.values
        .where((activity) => activity.isRegularCustomer)
        .toList();
  }

  // Clear all user activities
  Future<void> clearAllActivities() async {
    await _userActivityBox.clear();
    notifyListeners();
  }

  // Close the Hive box
  Future<void> closeBox() async {
    await _userActivityBox.close();
  }
}
