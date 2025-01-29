// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pharmacy.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PharmacyAdapter extends TypeAdapter<Pharmacy> {
  @override
  final int typeId = 3;

  @override
  Pharmacy read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Pharmacy(
      id: fields[0] as int,
      name: fields[1] as String,
      location: fields[2] as String,
      contactNumber: fields[3] as String,
      email: fields[4] as String,
      ownerName: fields[5] as String,
      registrationDate: fields[6] as DateTime,
      licenseNumber: fields[7] as String,
      servicesOffered: (fields[8] as List).cast<String>(),
      operatingHours: (fields[9] as List).cast<String>(),
      isActive: fields[10] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Pharmacy obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.location)
      ..writeByte(3)
      ..write(obj.contactNumber)
      ..writeByte(4)
      ..write(obj.email)
      ..writeByte(5)
      ..write(obj.ownerName)
      ..writeByte(6)
      ..write(obj.registrationDate)
      ..writeByte(7)
      ..write(obj.licenseNumber)
      ..writeByte(8)
      ..write(obj.servicesOffered)
      ..writeByte(9)
      ..write(obj.operatingHours)
      ..writeByte(10)
      ..write(obj.isActive);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PharmacyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
