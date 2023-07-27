import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geo_location/geo_location.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wolt_api/wolt_api.dart';
import 'package:wolt_assignment/restaurant/cubit/restaurant_cubit.dart';
import 'package:wolt_assignment/restaurant/widget/loading.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle.light,
            elevation: 0.0,
            centerTitle: true,
            title: Text(
              "Restaurant",
              style: GoogleFonts.montserrat(
                  fontSize: 26.0, fontWeight: FontWeight.bold),
            )),
        body: BlocProvider(
          create: (context) => RestaurantCubit(
            context.read<WoltApiClient>(),
            context.read<GeoLocationApiClient>(),
          ),
          child: const RestaurantView(),
        ));
  }
}

class RestaurantView extends StatelessWidget {
  const RestaurantView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestaurantCubit, RestaurantState>(
        builder: (context, state) {
      switch (state.status) {
        case RestaurantStatus.initial:
          return const Loading();
        case RestaurantStatus.loading:
          return const Loading();
        case RestaurantStatus.success:
          return const Placeholder(
            color: Colors.blue,
          );
        case RestaurantStatus.failure:
          return const Placeholder(
            color: Colors.green,
          );
      }
    });
  }
}
