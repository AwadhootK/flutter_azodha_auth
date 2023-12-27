// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 0;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User()
      ..id = fields[0] as String?
      ..firstName = fields[1] as String?
      ..lastName = fields[2] as String?
      ..middleName = fields[3] as String?
      ..gender = fields[4] as String?
      ..patientid = fields[6] as String?
      ..birthDate = fields[7] as DateTime?
      ..addressLine1 = fields[8] as String?
      ..addressLine2 = fields[9] as String?
      ..city = fields[10] as String?
      ..state = fields[11] as String?
      ..zipCode = fields[12] as String?
      ..country = fields[13] as String?
      ..phone = fields[14] as String?
      ..email = fields[15] as String?
      ..name = fields[16] as String?;
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.firstName)
      ..writeByte(2)
      ..write(obj.lastName)
      ..writeByte(3)
      ..write(obj.middleName)
      ..writeByte(4)
      ..write(obj.gender)
      ..writeByte(6)
      ..write(obj.patientid)
      ..writeByte(7)
      ..write(obj.birthDate)
      ..writeByte(8)
      ..write(obj.addressLine1)
      ..writeByte(9)
      ..write(obj.addressLine2)
      ..writeByte(10)
      ..write(obj.city)
      ..writeByte(11)
      ..write(obj.state)
      ..writeByte(12)
      ..write(obj.zipCode)
      ..writeByte(13)
      ..write(obj.country)
      ..writeByte(14)
      ..write(obj.phone)
      ..writeByte(15)
      ..write(obj.email)
      ..writeByte(16)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
