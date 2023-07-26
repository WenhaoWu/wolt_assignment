part of 'restaurant_cubit.dart';

enum RestaurantStatus { initial, loading, success, failure }

extension RestaurantListStatusX on RestaurantStatus {
  bool get isInitial => this == RestaurantStatus.initial;

  bool get isLoading => this == RestaurantStatus.loading;

  bool get isSuccess => this == RestaurantStatus.success;

  bool get isFailure => this == RestaurantStatus.failure;
}

@JsonSerializable()
class RestaurantState extends Equatable {
  final RestaurantStatus status;
  final List<Restaurant> restaurants;

  RestaurantState({
    this.status = RestaurantStatus.initial,
    List<Restaurant>? restaurants,
  }) : restaurants = restaurants ?? [];

  factory RestaurantState.fromJson(Map<String, dynamic> json) =>
      _$RestaurantStateFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantStateToJson(this);

  @override
  List<Object?> get props => [status, restaurants];

  RestaurantState copyWith({
    RestaurantStatus? status,
    List<Restaurant>? restaurants,
  }) {
    return RestaurantState(
      status: status ?? this.status,
      restaurants: restaurants ?? this.restaurants,
    );
  }
}
