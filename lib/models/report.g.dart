// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReportAdapter extends TypeAdapter<Report> {
  @override
  final int typeId = 5;

  @override
  Report read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Report(
      reportId: fields[0] as int,
      title: fields[1] as String,
      description: fields[2] as String,
      generatedDate: fields[3] as DateTime,
      generatedBy: fields[4] as String,
      type: fields[5] as String,
      data: (fields[6] as Map).cast<String, dynamic>(),
      status: fields[7] as String,
      filePath: fields[8] as String,
      notes: fields[9] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Report obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.reportId)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.generatedDate)
      ..writeByte(4)
      ..write(obj.generatedBy)
      ..writeByte(5)
      ..write(obj.type)
      ..writeByte(6)
      ..write(obj.data)
      ..writeByte(7)
      ..write(obj.status)
      ..writeByte(8)
      ..write(obj.filePath)
      ..writeByte(9)
      ..write(obj.notes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReportAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
