import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/product.dart';

class PharmacyDrugProvider with ChangeNotifier {
  late Box<PharmacyDrug> _pharmacyDrugBox;

  /// Initialize the Hive box
  Future<void> initialize() async {
    _pharmacyDrugBox = await Hive.openBox<PharmacyDrug>('pharmacyDrugs');
    notifyListeners();
  }

  /// Get all pharmacy drugs
  List<PharmacyDrug> get pharmacyDrugs {
    return _pharmacyDrugBox.values.toList();
  }

  /// Add a new pharmacy drug
  Future<void> addPharmacyDrug(PharmacyDrug drug) async {
    await _pharmacyDrugBox.put(drug.id, drug);
    notifyListeners();
  }

  /// Update an existing pharmacy drug
  Future<void> updatePharmacyDrug(PharmacyDrug drug) async {
    if (_pharmacyDrugBox.containsKey(drug.id)) {
      await _pharmacyDrugBox.put(drug.id, drug);
      notifyListeners();
    } else {
      throw Exception('PharmacyDrug not found');
    }
  }

  /// Delete a pharmacy drug by ID
  Future<void> deletePharmacyDrug(int id) async {
    await _pharmacyDrugBox.delete(id);
    notifyListeners();
  }

  /// Get a pharmacy drug by ID
  PharmacyDrug? getPharmacyDrugById(int id) {
    return _pharmacyDrugBox.get(id);
  }

  /// Check if a pharmacy drug exists
  bool pharmacyDrugExists(int id) {
    return _pharmacyDrugBox.containsKey(id);
  }

  /// Get drugs that need restocking (below reorder level)
  List<PharmacyDrug> get drugsBelowReorderLevel {
    return _pharmacyDrugBox.values
        .where((drug) => drug.stock <= drug.reorderLevel)
        .toList();
  }

  /// Get drugs close to expiry (e.g., within 30 days)
  List<PharmacyDrug> get drugsCloseToExpiry {
    final currentDate = DateTime.now();
    return _pharmacyDrugBox.values
        .where((drug) => drug.expiryDate.isBefore(currentDate.add(const Duration(days: 30))))
        .toList();
  }

  /// Clear all pharmacy drugs
  Future<void> clearPharmacyDrugs() async {
    await _pharmacyDrugBox.clear();
    notifyListeners();
  }

  /// Dispose the Hive box
  @override
  void dispose() {
    _pharmacyDrugBox.close();
    super.dispose();
  }
}
