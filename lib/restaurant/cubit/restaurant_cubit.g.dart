// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RestaurantState _$RestaurantStateFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'RestaurantState',
      json,
      ($checkedConvert) {
        final val = RestaurantState(
          status: $checkedConvert(
              'status',
              (v) =>
                  $enumDecodeNullable(_$RestaurantStatusEnumMap, v) ??
                  RestaurantStatus.initial),
          restaurants: $checkedConvert(
              'restaurants',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => Restaurant.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$RestaurantStateToJson(RestaurantState instance) =>
    <String, dynamic>{
      'status': _$RestaurantStatusEnumMap[instance.status]!,
      'restaurants': instance.restaurants.map((e) => e.toJson()).toList(),
    };

const _$RestaurantStatusEnumMap = {
  RestaurantStatus.initial: 'initial',
  RestaurantStatus.loading: 'loading',
  RestaurantStatus.success: 'success',
  RestaurantStatus.failure: 'failure',
};
