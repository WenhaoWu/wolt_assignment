import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wolt_api/src/models/image.dart';
import 'package:wolt_api/src/models/venue.dart';

part 'item.g.dart';

@JsonSerializable()
class Item extends Equatable {
  const Item({
    required this.image,
    required this.venue,
  });

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  final Image image;
  final Venue venue;

  @override
  List<Object?> get props => [image, venue];
}
