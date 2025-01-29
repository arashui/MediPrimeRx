import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/product.dart';

class PharmacyDrugProvider with ChangeNotifier {
  late Box<PharmacyDrug> _menuBox;
  List<PharmacyDrug> _medicineItems = [];

  PharmacyDrugProvider() {
    _menuBox = Hive.box<PharmacyDrug>('medicine_items'); // Initialize first
    loadMenuItems(); // Then load data
  }

  List<PharmacyDrug> get medicineItems => _medicineItems;

  void loadMenuItems() {
    _medicineItems = _menuBox.values.toList();
    notifyListeners();
  }

  void addMenuItem(PharmacyDrug item) {
    _menuBox.put(item.id, item);
    loadMenuItems();
  }

  void deleteMenuItem(int id) {
    _menuBox.delete(id);
    _medicineItems.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  Future<void> restoreMenuItems(List<dynamic> items) async {
    try {
      if (items.isEmpty) return;
      final dataMap = {for (var item in items) item['id']: PharmacyDrug.fromJson(item)};
      await _menuBox.putAll(dataMap);
      _medicineItems = _menuBox.values.toList();
      notifyListeners();
    } catch (e) {
      debugPrint('Error restoring menu items: $e');
    }
  }
}
