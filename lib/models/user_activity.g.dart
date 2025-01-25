// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_activity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserActivityAdapter extends TypeAdapter<UserActivity> {
  @override
  final int typeId = 6;

  @override
  UserActivity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserActivity(
      activityId: fields[0] as int,
      userId: fields[1] as String,
      activityType: fields[2] as String,
      description: fields[3] as String,
      timestamp: fields[4] as DateTime,
      ipAddress: fields[5] as String,
      deviceInfo: fields[6] as String,
      status: fields[7] as String,
      isRegularCustomer: fields[8] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, UserActivity obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.activityId)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.activityType)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.timestamp)
      ..writeByte(5)
      ..write(obj.ipAddress)
      ..writeByte(6)
      ..write(obj.deviceInfo)
      ..writeByte(7)
      ..write(obj.status)
      ..writeByte(8)
      ..write(obj.isRegularCustomer);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserActivityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
