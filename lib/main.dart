import 'package:flutter/material.dart';

import 'package:movies/providers/movies_providers.dart';
import 'package:movies/themes/app_theme.dart';
import 'package:provider/provider.dart';

import 'screens/screens.dart';


void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: ( _ ) => MoviesProvider(), lazy: false, ),
        ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movies',
      initialRoute: 'home',
      routes: {
        'home': (_) => HomeScreen(),
        'details': (_) => DetailsScreen(),
      },
      theme: AppTheme.lightTheme
    );
  }
}
