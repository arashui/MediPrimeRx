import 'package:hive/hive.dart';

part 'invoice.g.dart'; // Needed for Hive type adapter

@HiveType(typeId: 3) // Unique typeId for this model
class Invoice {
  @HiveField(0)
  final int invoiceId;

  @HiveField(1)
  final DateTime invoiceDate;

  @HiveField(2)
  final String customerName;

  @HiveField(3)
  final String customerContact;

  @HiveField(4)
  final String customerAddress;

  @HiveField(5)
  final List<InvoiceItem> items;

  @HiveField(6)
  final double totalAmount;

  @HiveField(7)
  final double discount;

  @HiveField(8)
  final double paidAmount;

  @HiveField(9)
  final double balanceDue;

  @HiveField(10)
  final String paymentMethod;

  @HiveField(11)
  final String notes;

  Invoice({
    required this.invoiceId,
    required this.invoiceDate,
    required this.customerName,
    required this.customerContact,
    required this.customerAddress,
    required this.items,
    required this.totalAmount,
    required this.discount,
    required this.paidAmount,
    required this.balanceDue,
    required this.paymentMethod,
    required this.notes,
  });

  /// Converts a JSON map into an `Invoice` instance
  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      invoiceId: json['invoiceId'],
      invoiceDate: DateTime.parse(json['invoiceDate']),
      customerName: json['customerName'],
      customerContact: json['customerContact'],
      customerAddress: json['customerAddress'],
      items: (json['items'] as List)
          .map((item) => InvoiceItem.fromJson(item))
          .toList(),
      totalAmount: (json['totalAmount'] as num).toDouble(),
      discount: (json['discount'] as num).toDouble(),
      paidAmount: (json['paidAmount'] as num).toDouble(),
      balanceDue: (json['balanceDue'] as num).toDouble(),
      paymentMethod: json['paymentMethod'],
      notes: json['notes'],
    );
  }

  /// Converts an `Invoice` instance into a JSON map
  Map<String, dynamic> toJson() {
    return {
      'invoiceId': invoiceId,
      'invoiceDate': invoiceDate.toIso8601String(),
      'customerName': customerName,
      'customerContact': customerContact,
      'customerAddress': customerAddress,
      'items': items.map((item) => item.toJson()).toList(),
      'totalAmount': totalAmount,
      'discount': discount,
      'paidAmount': paidAmount,
      'balanceDue': balanceDue,
      'paymentMethod': paymentMethod,
      'notes': notes,
    };
  }
}

@HiveType(typeId: 4) // Unique typeId for nested InvoiceItem
class InvoiceItem {
  @HiveField(0)
  final int drugId;

  @HiveField(1)
  final String drugName;

  @HiveField(2)
  final int quantity;

  @HiveField(3)
  final double unitPrice;

  @HiveField(4)
  final double totalPrice;

  InvoiceItem({
    required this.drugId,
    required this.drugName,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
  });

  /// Converts a JSON map into an `InvoiceItem` instance
  factory InvoiceItem.fromJson(Map<String, dynamic> json) {
    return InvoiceItem(
      drugId: json['drugId'],
      drugName: json['drugName'],
      quantity: json['quantity'],
      unitPrice: (json['unitPrice'] as num).toDouble(),
      totalPrice: (json['totalPrice'] as num).toDouble(),
    );
  }

  /// Converts an `InvoiceItem` instance into a JSON map
  Map<String, dynamic> toJson() {
    return {
      'drugId': drugId,
      'drugName': drugName,
      'quantity': quantity,
      'unitPrice': unitPrice,
      'totalPrice': totalPrice,
    };
  }
}
