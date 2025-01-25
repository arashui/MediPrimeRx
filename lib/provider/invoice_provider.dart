import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/invoice.dart';

class InvoiceProvider with ChangeNotifier {
  late Box<Invoice> _invoiceBox;

  /// Initialize the Hive box
  Future<void> initialize() async {
    _invoiceBox = await Hive.openBox<Invoice>('invoices');
    notifyListeners();
  }

  /// Get all invoices
  List<Invoice> get invoices {
    return _invoiceBox.values.toList();
  }

  /// Add a new invoice
  Future<void> addInvoice(Invoice invoice) async {
    await _invoiceBox.put(invoice.invoiceId, invoice);
    notifyListeners();
  }

  /// Update an existing invoice
  Future<void> updateInvoice(Invoice invoice) async {
    if (_invoiceBox.containsKey(invoice.invoiceId)) {
      await _invoiceBox.put(invoice.invoiceId, invoice);
      notifyListeners();
    } else {
      throw Exception('Invoice not found');
    }
  }

  /// Delete an invoice by ID
  Future<void> deleteInvoice(int id) async {
    await _invoiceBox.delete(id);
    notifyListeners();
  }

  /// Get an invoice by ID
  Invoice? getInvoiceById(int id) {
    return _invoiceBox.get(id);
  }

  /// Get total revenue from all invoices
  double get totalRevenue {
    return _invoiceBox.values.fold(0, (sum, invoice) => sum + invoice.totalAmount);
  }

  /// Get total outstanding balance due from all invoices
  double get totalOutstandingBalance {
    return _invoiceBox.values.fold(0, (sum, invoice) => sum + invoice.balanceDue);
  }

  /// Get invoices filtered by customer name
  List<Invoice> getInvoicesByCustomer(String customerName) {
    return _invoiceBox.values
        .where((invoice) => invoice.customerName.toLowerCase().contains(customerName.toLowerCase()))
        .toList();
  }

  /// Clear all invoices
  Future<void> clearInvoices() async {
    await _invoiceBox.clear();
    notifyListeners();
  }

  /// Dispose the Hive box
  @override
  void dispose() {
    _invoiceBox.close();
    super.dispose();
  }
}
