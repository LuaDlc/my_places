import 'package:flutter/material.dart';
import 'package:my_places/pages/place_form_page.dart';
import 'package:my_places/pages/places_list_page.dart';
import 'package:my_places/utils/app_routes.dart';
import 'package:provider/provider.dart';

import 'providers/my_places.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => MyPlaces(),
      child: MaterialApp(
        title: 'My Places',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const PlacesListPage(),
        routes: {
          AppRoutes.placeForm: (ctx) => const PlaceFormPage(),
        },
      ),
    );
  }
}
