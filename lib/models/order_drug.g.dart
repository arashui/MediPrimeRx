// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_drug.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OrderDrugAdapter extends TypeAdapter<OrderDrug> {
  @override
  final int typeId = 2;

  @override
  OrderDrug read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OrderDrug(
      orderId: fields[0] as int,
      drugId: fields[1] as int,
      drugName: fields[2] as String,
      quantity: fields[3] as int,
      unitPrice: fields[4] as double,
      totalPrice: fields[5] as double,
      discount: fields[6] as double,
      paidAmount: fields[7] as double,
      customerName: fields[8] as String,
      customerContact: fields[9] as String,
      orderDate: fields[10] as DateTime,
      paymentMethod: fields[11] as String,
      orderStatus: fields[12] as String,
      deliveryDate: fields[13] as DateTime?,
      deliveryAddress: fields[14] as String,
      isPrescriptionRequired: fields[15] as bool,
      prescriptionUrl: fields[16] as String,
      notes: fields[17] as String,
    );
  }

  @override
  void write(BinaryWriter writer, OrderDrug obj) {
    writer
      ..writeByte(18)
      ..writeByte(0)
      ..write(obj.orderId)
      ..writeByte(1)
      ..write(obj.drugId)
      ..writeByte(2)
      ..write(obj.drugName)
      ..writeByte(3)
      ..write(obj.quantity)
      ..writeByte(4)
      ..write(obj.unitPrice)
      ..writeByte(5)
      ..write(obj.totalPrice)
      ..writeByte(6)
      ..write(obj.discount)
      ..writeByte(7)
      ..write(obj.paidAmount)
      ..writeByte(8)
      ..write(obj.customerName)
      ..writeByte(9)
      ..write(obj.customerContact)
      ..writeByte(10)
      ..write(obj.orderDate)
      ..writeByte(11)
      ..write(obj.paymentMethod)
      ..writeByte(12)
      ..write(obj.orderStatus)
      ..writeByte(13)
      ..write(obj.deliveryDate)
      ..writeByte(14)
      ..write(obj.deliveryAddress)
      ..writeByte(15)
      ..write(obj.isPrescriptionRequired)
      ..writeByte(16)
      ..write(obj.prescriptionUrl)
      ..writeByte(17)
      ..write(obj.notes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderDrugAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
