// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserVM.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserVM _$UserVMFromJson(Map<String, dynamic> json) {
  return UserVM(
    json['id'] as String,
    json['username'] as String,
    json['name'] as String,
    DateTime.parse(json['dateOfBirth'] as String),
    json['email'] as String,
  );
}

Map<String, dynamic> _$UserVMToJson(UserVM instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'name': instance.name,
      'dateOfBirth': instance.dateOfBirth.toIso8601String(),
      'email': instance.email,
    };
