// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Restaurant _$RestaurantFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Restaurant',
      json,
      ($checkedConvert) {
        final val = Restaurant(
          name: $checkedConvert('name', (v) => v as String),
          shortDescription:
              $checkedConvert('short_description', (v) => v as String),
          imgUrl: $checkedConvert('img_url', (v) => v as String),
          isFavourite: $checkedConvert('is_favourite', (v) => v as bool),
        );
        return val;
      },
      fieldKeyMap: const {
        'shortDescription': 'short_description',
        'imgUrl': 'img_url',
        'isFavourite': 'is_favourite'
      },
    );

Map<String, dynamic> _$RestaurantToJson(Restaurant instance) =>
    <String, dynamic>{
      'name': instance.name,
      'short_description': instance.shortDescription,
      'img_url': instance.imgUrl,
      'is_favourite': instance.isFavourite,
    };
