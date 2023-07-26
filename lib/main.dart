import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geo_location/geo_location.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wolt_api/wolt_api.dart';
import 'package:wolt_assignment/restaurant/restaurant.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Bloc.observer = const GlobalBlocObserver();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MultiRepositoryProvider(
          providers: [
            RepositoryProvider<WoltApiClient>(
                create: (context) => WoltApiClient()),
            RepositoryProvider<GeoLocationApiClient>(
                create: (context) => GeoLocationApiClient()),
          ],
          child: const RestaurantScreen(),
        ));
  }
}
