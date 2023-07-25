import 'package:json_annotation/json_annotation.dart';
import 'package:wolt_api/models/image.dart';
import 'package:wolt_api/models/venue.dart';

part 'restaurant.g.dart';

@JsonSerializable()
class Restaurant {
  const Restaurant({
    required this.image,
    required this.venue,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) =>
      _$RestaurantFromJson(json);

  final Image image;
  final Venue venue;
}
