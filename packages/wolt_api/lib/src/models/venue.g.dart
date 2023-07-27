// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'venue.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Venue _$VenueFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Venue',
      json,
      ($checkedConvert) {
        final val = Venue(
          id: $checkedConvert('id', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String),
          location: $checkedConvert(
              'location',
              (v) => (v as List<dynamic>)
                  .map((e) => (e as num).toDouble())
                  .toList()),
          shortDescription:
              $checkedConvert('short_description', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {'shortDescription': 'short_description'},
    );
