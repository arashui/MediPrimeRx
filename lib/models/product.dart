import 'package:hive/hive.dart';

part 'product.g.dart'; // Needed for the Hive type adapter

@HiveType(typeId: 4) // Unique typeId for this model
class PharmacyDrug {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String genericName;

  @HiveField(3)
  final String manufacturer;

  @HiveField(4)
  final String category;

  @HiveField(5)
  final String subcategory;

  @HiveField(6)
  final String barcode;

  @HiveField(7)
  final String imageUrl;

  @HiveField(8)
  final double price;

  @HiveField(9)
  final double offerPrice;

  @HiveField(10)
  final int stock;

  @HiveField(11)
  final DateTime expiryDate;

  @HiveField(12)
  final String batchNumber;

  @HiveField(13)
  final double unitSize;

  @HiveField(14)
  final String unitType;

  @HiveField(15)
  final String storageConditions;

  @HiveField(16)
  final bool prescriptionRequired;

  @HiveField(17)
  final DateTime dateAdded;

  @HiveField(18)
  final DateTime? lastRestocked;

  @HiveField(19)
  final String supplierName;

  @HiveField(20)
  final String supplierContact;

  @HiveField(21)
  final double mrp;

  @HiveField(22)
  final double gst;

  @HiveField(23)
  final String? scheduleCategory;

  @HiveField(24)
  final int reorderLevel;

  @HiveField(25)
  final String? usageInstructions;

  @HiveField(26)
  final List<String>? sideEffects;

  @HiveField(27)
  final String? contraindications;

  @HiveField(28)
  final String drugInteractions;

  @HiveField(29)
  final String? form;

  @HiveField(30)
  final String medicineComposition;

  PharmacyDrug({
    required this.id,
    required this.name,
    required this.genericName,
    required this.manufacturer,
    required this.category,
    required this.subcategory,
    required this.barcode,
    required this.imageUrl,
    required this.price,
    required this.offerPrice,
    required this.stock,
    required this.expiryDate,
    required this.batchNumber,
    required this.unitSize,
    required this.unitType,
    required this.storageConditions,
    required this.prescriptionRequired,
    required this.dateAdded,
    this.lastRestocked,
    required this.supplierName,
    required this.supplierContact,
    required this.mrp,
    required this.gst,
    this.scheduleCategory,
    required this.reorderLevel,
    this.usageInstructions,
    this.sideEffects,
    required this.contraindications,
    required this.drugInteractions,
    this.form,
    required this.medicineComposition
  });

  /// Converts a JSON map into a `PharmacyDrug` instance
  factory PharmacyDrug.fromJson(Map<String, dynamic> json) {
    return PharmacyDrug(
      id: json['id'],
      name: json['name'],
      genericName: json['genericName'],
      manufacturer: json['manufacturer'],
      category: json['category'],
      subcategory: json['subcategory'],
      barcode: json['barcode'],
      imageUrl: json['imageUrl'],
      price: (json['price'] as num).toDouble(),
      offerPrice: (json['offerPrice'] as num).toDouble(),
      stock: json['stock'],
      expiryDate: DateTime.parse(json['expiryDate']),
      batchNumber: json['batchNumber'],
      unitSize: (json['unitSize'] as num).toDouble(),
      unitType: json['unitType'],
      storageConditions: json['storageConditions'],
      prescriptionRequired: json['prescriptionRequired'],
      dateAdded: DateTime.parse(json['dateAdded']),
      lastRestocked: json['lastRestocked'] != null
          ? DateTime.parse(json['lastRestocked'])
          : null,
      supplierName: json['supplierName'],
      supplierContact: json['supplierContact'],
      mrp: (json['mrp'] as num).toDouble(),
      gst: (json['gst'] as num).toDouble(),
      scheduleCategory: json['scheduleCategory'],
      reorderLevel: json['reorderLevel'],
      usageInstructions: json['usageInstructions'],
      sideEffects: List<String>.from(json['sideEffects']),
      contraindications: json['contraindications'],
      drugInteractions: json['drugInteractions'],
      form: json['form'],
        medicineComposition : json['medicineComposition']
    );
  }

  /// Converts a `PharmacyDrug` instance into a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'genericName': genericName,
      'manufacturer': manufacturer,
      'category': category,
      'subcategory': subcategory,
      'barcode': barcode,
      'imageUrl': imageUrl,
      'price': price,
      'offerPrice': offerPrice,
      'stock': stock,
      'expiryDate': expiryDate.toIso8601String(),
      'batchNumber': batchNumber,
      'unitSize': unitSize,
      'unitType': unitType,
      'storageConditions': storageConditions,
      'prescriptionRequired': prescriptionRequired,
      'dateAdded': dateAdded.toIso8601String(),
      'lastRestocked': lastRestocked?.toIso8601String(),
      'supplierName': supplierName,
      'supplierContact': supplierContact,
      'mrp': mrp,
      'gst': gst,
      'scheduleCategory': scheduleCategory,
      'reorderLevel': reorderLevel,
      'usageInstructions': usageInstructions,
      'sideEffects': sideEffects,
      'contraindications': contraindications,
      'drugInteractions': drugInteractions,
      'form': form,
      'medicineComposition': medicineComposition,
    };
  }
  // Method to add quantity
  // void addQuantity(int value) {
  //   quantity += value;
  // }
  //
  // // Method to reset quantity
  // void resetQuantity() {
  //   quantity = 0;
  // }
}
