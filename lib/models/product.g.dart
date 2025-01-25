// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PharmacyDrugAdapter extends TypeAdapter<PharmacyDrug> {
  @override
  final int typeId = 1;

  @override
  PharmacyDrug read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PharmacyDrug(
      id: fields[0] as int,
      name: fields[1] as String,
      genericName: fields[2] as String,
      manufacturer: fields[3] as String,
      category: fields[4] as String,
      subcategory: fields[5] as String,
      barcode: fields[6] as String,
      imageUrl: fields[7] as String,
      price: fields[8] as double,
      offerPrice: fields[9] as double,
      stock: fields[10] as int,
      expiryDate: fields[11] as DateTime,
      batchNumber: fields[12] as String,
      unitSize: fields[13] as double,
      unitType: fields[14] as String,
      storageConditions: fields[15] as String,
      prescriptionRequired: fields[16] as bool,
      dateAdded: fields[17] as DateTime,
      lastRestocked: fields[18] as DateTime?,
      supplierName: fields[19] as String,
      supplierContact: fields[20] as String,
      mrp: fields[21] as double,
      gst: fields[22] as double,
      scheduleCategory: fields[23] as String,
      reorderLevel: fields[24] as int,
      usageInstructions: fields[25] as String,
      sideEffects: (fields[26] as List).cast<String>(),
      contraindications: fields[27] as String,
      drugInteractions: fields[28] as String,
      form: fields[29] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PharmacyDrug obj) {
    writer
      ..writeByte(30)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.genericName)
      ..writeByte(3)
      ..write(obj.manufacturer)
      ..writeByte(4)
      ..write(obj.category)
      ..writeByte(5)
      ..write(obj.subcategory)
      ..writeByte(6)
      ..write(obj.barcode)
      ..writeByte(7)
      ..write(obj.imageUrl)
      ..writeByte(8)
      ..write(obj.price)
      ..writeByte(9)
      ..write(obj.offerPrice)
      ..writeByte(10)
      ..write(obj.stock)
      ..writeByte(11)
      ..write(obj.expiryDate)
      ..writeByte(12)
      ..write(obj.batchNumber)
      ..writeByte(13)
      ..write(obj.unitSize)
      ..writeByte(14)
      ..write(obj.unitType)
      ..writeByte(15)
      ..write(obj.storageConditions)
      ..writeByte(16)
      ..write(obj.prescriptionRequired)
      ..writeByte(17)
      ..write(obj.dateAdded)
      ..writeByte(18)
      ..write(obj.lastRestocked)
      ..writeByte(19)
      ..write(obj.supplierName)
      ..writeByte(20)
      ..write(obj.supplierContact)
      ..writeByte(21)
      ..write(obj.mrp)
      ..writeByte(22)
      ..write(obj.gst)
      ..writeByte(23)
      ..write(obj.scheduleCategory)
      ..writeByte(24)
      ..write(obj.reorderLevel)
      ..writeByte(25)
      ..write(obj.usageInstructions)
      ..writeByte(26)
      ..write(obj.sideEffects)
      ..writeByte(27)
      ..write(obj.contraindications)
      ..writeByte(28)
      ..write(obj.drugInteractions)
      ..writeByte(29)
      ..write(obj.form);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PharmacyDrugAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
