import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/pharmacy.dart';

class PharmacyProvider with ChangeNotifier {
  static const String _pharmacyBoxName = "pharmacyBox";
  late Box<Pharmacy> _pharmacyBox;

  /// Initializes the Hive box
  Future<void> init() async {
    _pharmacyBox = await Hive.openBox<Pharmacy>(_pharmacyBoxName);
  }

  /// Adds a new Pharmacy to the box
  Future<void> addPharmacy(Pharmacy pharmacy) async {
    await _pharmacyBox.put(pharmacy.id, pharmacy);
    notifyListeners();
  }

  /// Updates an existing Pharmacy in the box
  Future<void> updatePharmacy(Pharmacy pharmacy) async {
    if (_pharmacyBox.containsKey(pharmacy.id)) {
      await _pharmacyBox.put(pharmacy.id, pharmacy);
      notifyListeners();
    } else {
      throw Exception("Pharmacy with ID ${pharmacy.id} not found");
    }
  }

  /// Deletes a Pharmacy from the box
  Future<void> deletePharmacy(int id) async {
    await _pharmacyBox.delete(id);
    notifyListeners();
  }

  /// Retrieves all Pharmacies from the box
  List<Pharmacy> getAllPharmacies() {
    return _pharmacyBox.values.toList();
  }

  /// Retrieves a Pharmacy by ID
  Pharmacy? getPharmacyById(int id) {
    return _pharmacyBox.get(id);
  }

  /// Filters pharmacies by their active status
  List<Pharmacy> getActivePharmacies() {
    return _pharmacyBox.values.where((pharmacy) => pharmacy.isActive).toList();
  }

  /// Filters pharmacies by service offered
  List<Pharmacy> getPharmaciesByService(String service) {
    return _pharmacyBox.values
        .where((pharmacy) => pharmacy.servicesOffered.contains(service))
        .toList();
  }

  /// Closes the Hive box when no longer needed
  Future<void> close() async {
    await _pharmacyBox.close();
  }
}
