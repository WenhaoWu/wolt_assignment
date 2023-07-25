// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Item _$ItemFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Item',
      json,
      ($checkedConvert) {
        final val = Item(
          image: $checkedConvert(
              'image', (v) => Image.fromJson(v as Map<String, dynamic>)),
          venue: $checkedConvert(
              'venue', (v) => Venue.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );
