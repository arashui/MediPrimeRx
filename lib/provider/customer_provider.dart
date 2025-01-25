import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import '../models/customer.dart';

class CustomerProvider extends ChangeNotifier {
  late Box<Customer> _customerBox;

  /// Initialize the Hive box for customers
  Future<void> initialize() async {
    _customerBox = await Hive.openBox<Customer>('customers');
    notifyListeners();
  }

  /// Fetch all customers
  List<Customer> get customers => _customerBox.values.toList();

  /// Add a new customer
  Future<void> addCustomer(Customer customer) async {
    await _customerBox.put(customer.customerId, customer);
    notifyListeners();
  }

  /// Update an existing customer
  Future<void> updateCustomer(int customerId, Customer updatedCustomer) async {
    if (_customerBox.containsKey(customerId)) {
      await _customerBox.put(customerId, updatedCustomer);
      notifyListeners();
    }
  }

  /// Delete a customer by ID
  Future<void> deleteCustomer(int customerId) async {
    if (_customerBox.containsKey(customerId)) {
      await _customerBox.delete(customerId);
      notifyListeners();
    }
  }

  /// Get a customer by ID
  Customer? getCustomerById(int customerId) {
    return _customerBox.get(customerId);
  }

  /// Get customers with outstanding balance
  List<Customer> getCustomersWithOutstandingBalance() {
    return _customerBox.values
        .where((customer) => customer.outstandingBalance > 0)
        .toList();
  }

  /// Calculate the total revenue from all customers
  double calculateTotalRevenue() {
    return _customerBox.values.fold(
        0.0, (sum, customer) => sum + customer.totalSpent);
  }

  /// Check if a customer is a regular customer based on total spent threshold
  bool isRegularCustomer(int customerId, {double threshold = 1000.0}) {
    final customer = _customerBox.get(customerId);
    if (customer != null) {
      return customer.totalSpent >= threshold;
    }
    return false;
  }

  /// Clear all customer data (for testing or reset purposes)
  Future<void> clearAllCustomers() async {
    await _customerBox.clear();
    notifyListeners();
  }
}
