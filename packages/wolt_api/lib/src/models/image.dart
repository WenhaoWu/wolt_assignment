import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'image.g.dart';

@JsonSerializable()
class Image extends Equatable {
  const Image({
    required this.blurhash,
    required this.url,
  });

  factory Image.fromJson(Map<String, dynamic> json) =>
      _$ImageFromJson(json);

  final String blurhash;
  final String url;

  @override
  List<Object?> get props => [blurhash, url];
}