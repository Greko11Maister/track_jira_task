// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_adapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AuthAdapterAdapter extends TypeAdapter<AuthAdapter> {
  @override
  final int typeId = 3;

  @override
  AuthAdapter read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AuthAdapter(
      username: fields[1] as String?,
      token: fields[0] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AuthAdapter obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.token)
      ..writeByte(1)
      ..write(obj.username);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthAdapterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
