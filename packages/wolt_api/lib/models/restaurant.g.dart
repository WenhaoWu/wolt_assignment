// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'restaurant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Restaurant _$RestaurantFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Restaurant',
      json,
      ($checkedConvert) {
        final val = Restaurant(
          image: $checkedConvert(
              'image', (v) => Image.fromJson(v as Map<String, dynamic>)),
          venue: $checkedConvert(
              'venue', (v) => Venue.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );
