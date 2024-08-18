// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppSettingsAdapter extends TypeAdapter<AppSettings> {
  @override
  final int typeId = 1;

  @override
  AppSettings read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppSettings(
      darkMode: fields[0] as bool,
      currency: fields[1] as String,
      expenseCategories: (fields[2] as List).cast<String>(),
      budgetAlerts: fields[3] as bool,
      notifications: fields[4] as bool,
      privacyPolicy: fields[5] as String,
      language: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AppSettings obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.darkMode)
      ..writeByte(1)
      ..write(obj.currency)
      ..writeByte(2)
      ..write(obj.expenseCategories)
      ..writeByte(3)
      ..write(obj.budgetAlerts)
      ..writeByte(4)
      ..write(obj.notifications)
      ..writeByte(5)
      ..write(obj.privacyPolicy)
      ..writeByte(6)
      ..write(obj.language);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppSettingsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
