import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:wolt_assignment/restaurant/models/models.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wolt_api/wolt_api.dart' show WoltApiClient;
import 'package:geo_location/geo_location.dart'
    show GeoLocationApiClient, LatLong;

part 'restaurant_state.dart';

part 'restaurant_cubit.g.dart';

const int maxItemPerPage = 15;

class RestaurantCubit extends HydratedCubit<RestaurantState> {
  final WoltApiClient _woltApiClient;
  final GeoLocationApiClient _geoLocationApiClient;

  late StreamSubscription<LatLong> _control;

  RestaurantCubit(
    this._woltApiClient,
    this._geoLocationApiClient,
  ) : super(RestaurantState()) {
    _control = _geoLocationApiClient.streamLatLong().listen(_handleLatLong);
  }

  @override
  RestaurantState fromJson(Map<String, dynamic> json) =>
      RestaurantState.fromJson(json);

  @override
  Map<String, dynamic> toJson(RestaurantState state) => state.toJson();

  @override
  Future<void> close() async {
    await _control.cancel();
    super.close();
  }

  Future _handleLatLong(LatLong latLong) async {
    emit(state.copyWith(status: RestaurantStatus.loading));

    try {
      final items = await _woltApiClient.getItems(
        latitude: latLong.latitude,
        longitude: latLong.longitude,
      );

      final restaurants = items.take(maxItemPerPage).map(Restaurant.fromItem);

      emit(state.copyWith(
        status: RestaurantStatus.success,
        restaurants: restaurants.toList(),
      ));
    } on Exception {
      emit(state.copyWith(status: RestaurantStatus.failure));
    }
  }
}
