import 'package:hive/hive.dart';

part 'order_drug.g.dart'; // Needed for Hive type adapter

@HiveType(typeId: 2) // Unique typeId for this model
class OrderDrug {
  @HiveField(0)
  final int orderId;

  @HiveField(1)
  final int drugId;

  @HiveField(2)
  final String drugName;

  @HiveField(3)
  final int quantity;

  @HiveField(4)
  final double unitPrice;

  @HiveField(5)
  final double totalPrice;

  @HiveField(6)
  final double discount;

  @HiveField(7)
  final double paidAmount;

  @HiveField(8)
  final String customerName;

  @HiveField(9)
  final String customerContact;

  @HiveField(10)
  final DateTime orderDate;

  @HiveField(11)
  final String paymentMethod;

  @HiveField(12)
  final String orderStatus; // Example: "Pending", "Completed", "Cancelled"

  @HiveField(13)
  final DateTime? deliveryDate;

  @HiveField(14)
  final String deliveryAddress;

  @HiveField(15)
  final bool isPrescriptionRequired;

  @HiveField(16)
  final String prescriptionUrl; // URL to prescription if uploaded

  @HiveField(17)
  final String notes; // Additional order notes

  OrderDrug({
    required this.orderId,
    required this.drugId,
    required this.drugName,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
    required this.discount,
    required this.paidAmount,
    required this.customerName,
    required this.customerContact,
    required this.orderDate,
    required this.paymentMethod,
    required this.orderStatus,
    this.deliveryDate,
    required this.deliveryAddress,
    required this.isPrescriptionRequired,
    required this.prescriptionUrl,
    required this.notes,
  });

  /// Converts a JSON map into an `OrderDrug` instance
  factory OrderDrug.fromJson(Map<String, dynamic> json) {
    return OrderDrug(
      orderId: json['orderId'],
      drugId: json['drugId'],
      drugName: json['drugName'],
      quantity: json['quantity'],
      unitPrice: (json['unitPrice'] as num).toDouble(),
      totalPrice: (json['totalPrice'] as num).toDouble(),
      discount: (json['discount'] as num).toDouble(),
      paidAmount: (json['paidAmount'] as num).toDouble(),
      customerName: json['customerName'],
      customerContact: json['customerContact'],
      orderDate: DateTime.parse(json['orderDate']),
      paymentMethod: json['paymentMethod'],
      orderStatus: json['orderStatus'],
      deliveryDate: json['deliveryDate'] != null
          ? DateTime.parse(json['deliveryDate'])
          : null,
      deliveryAddress: json['deliveryAddress'],
      isPrescriptionRequired: json['isPrescriptionRequired'],
      prescriptionUrl: json['prescriptionUrl'],
      notes: json['notes'],
    );
  }

  /// Converts an `OrderDrug` instance into a JSON map
  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'drugId': drugId,
      'drugName': drugName,
      'quantity': quantity,
      'unitPrice': unitPrice,
      'totalPrice': totalPrice,
      'discount': discount,
      'paidAmount': paidAmount,
      'customerName': customerName,
      'customerContact': customerContact,
      'orderDate': orderDate.toIso8601String(),
      'paymentMethod': paymentMethod,
      'orderStatus': orderStatus,
      'deliveryDate': deliveryDate?.toIso8601String(),
      'deliveryAddress': deliveryAddress,
      'isPrescriptionRequired': isPrescriptionRequired,
      'prescriptionUrl': prescriptionUrl,
      'notes': notes,
    };
  }
}
