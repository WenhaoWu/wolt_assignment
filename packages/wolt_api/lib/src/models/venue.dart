import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'venue.g.dart';

@JsonSerializable()
class Venue extends Equatable {
  const Venue({
    required this.id,
    required this.name,
    required this.location,
    required this.shortDescription,
  });

  factory Venue.fromJson(Map<String, dynamic> json) => _$VenueFromJson(json);

  final String id;
  final String name;
  final List<double> location;
  @JsonKey(name: "short_description")
  final String shortDescription;

  @override
  List<Object?> get props => [id, name, location, shortDescription];
}
