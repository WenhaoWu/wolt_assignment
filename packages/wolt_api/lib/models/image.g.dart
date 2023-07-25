// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Image _$ImageFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Image',
      json,
      ($checkedConvert) {
        final val = Image(
          blurhash: $checkedConvert('blurhash', (v) => v as int),
          url: $checkedConvert('url', (v) => v as String),
        );
        return val;
      },
    );
