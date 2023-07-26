import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wolt_api/wolt_api.dart' show Item;

part 'restaurant.g.dart';

@JsonSerializable()
class Restaurant extends Equatable {
  final String name;
  final String shortDescription;
  final String imgUrl;
  final bool isFavourite;

  factory Restaurant.fromJson(Map<String, dynamic> json) =>
      _$RestaurantFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantToJson(this);

  const Restaurant({
    required this.name,
    required this.shortDescription,
    required this.imgUrl,
    required this.isFavourite,
  });

  factory Restaurant.fromItem(Item item) {
    return Restaurant(
      name: item.venue.name,
      shortDescription: item.venue.shortDescription,
      imgUrl: item.image.url,
      isFavourite: false,
    );
  }

  Restaurant copyWith({bool? isFavourite}) {
    return Restaurant(
        name: name,
        shortDescription: shortDescription,
        imgUrl: imgUrl,
        isFavourite: isFavourite ?? this.isFavourite);
  }

  @override
  List<Object?> get props => [name, shortDescription, imgUrl, isFavourite];
}
