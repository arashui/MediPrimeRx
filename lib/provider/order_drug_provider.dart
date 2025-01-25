import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/order_drug.dart';

class OrderDrugProvider with ChangeNotifier {
  static const String _boxName = "orderDrugsBox";
  late Box<OrderDrug> _orderDrugBox;

  Future<void> initialize() async {
    _orderDrugBox = await Hive.openBox<OrderDrug>(_boxName);
    notifyListeners();
  }

  List<OrderDrug> get orders => _orderDrugBox.values.toList();

  void addOrder(OrderDrug order) async {
    await _orderDrugBox.put(order.orderId, order);
    notifyListeners();
  }

  void updateOrder(OrderDrug order) async {
    if (_orderDrugBox.containsKey(order.orderId)) {
      await _orderDrugBox.put(order.orderId, order);
      notifyListeners();
    }
  }

  void deleteOrder(int orderId) async {
    await _orderDrugBox.delete(orderId);
    notifyListeners();
  }

  OrderDrug? getOrderById(int orderId) {
    return _orderDrugBox.get(orderId);
  }

  List<OrderDrug> filterOrdersByStatus(String status) {
    return orders.where((order) => order.orderStatus == status).toList();
  }

  double calculateTotalRevenue() {
    return orders.fold(0.0, (sum, order) => sum + order.paidAmount);
  }

  double calculateTotalDiscounts() {
    return orders.fold(0.0, (sum, order) => sum + order.discount);
  }

  List<OrderDrug> getPendingOrders() {
    return filterOrdersByStatus("Pending");
  }

  List<OrderDrug> getCompletedOrders() {
    return filterOrdersByStatus("Completed");
  }

  void clearOrders() async {
    await _orderDrugBox.clear();
    notifyListeners();
  }
}
