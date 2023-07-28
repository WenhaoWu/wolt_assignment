import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geo_location/geo_location.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wolt_api/wolt_api.dart';
import 'package:wolt_assignment/restaurant/cubit/restaurant_cubit.dart';
import 'package:wolt_assignment/restaurant/widget/widgets.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RestaurantCubit(
        context.read<WoltApiClient>(),
        context.read<GeoLocationApiClient>(),
      ),
      child: Scaffold(
        appBar: _buildAppBar(),
        body: const RestaurantView(),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle.light,
      elevation: 0.0,
      centerTitle: true,
      title: Text(
        "Restaurant",
        style:
            GoogleFonts.montserrat(fontSize: 26.0, fontWeight: FontWeight.bold),
      ),
      leading: BlocBuilder<RestaurantCubit, RestaurantState>(
        builder: (context, state) => state.status.isLoading
            ? const Center(
                heightFactor: 1,
                widthFactor: 1,
                child: SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                ),
              )
            : const SizedBox(),
      ),
    );
  }
}

class RestaurantView extends StatelessWidget {
  const RestaurantView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestaurantCubit, RestaurantState>(
      buildWhen: (prev, current) => !current.status.isLoading,
      builder: (context, state) {
        switch (state.status) {
          case RestaurantStatus.initial:
            return const Loading();
          case RestaurantStatus.loading:
            throw Exception("No view for loading");
          case RestaurantStatus.success:
            return ListWidget(list: state.restaurants);
          case RestaurantStatus.failure:
            return const FailureWidget();
        }
      },
    );
  }
}
