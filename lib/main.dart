import 'package:an_spacex/custom_observer.dart';
import 'package:an_spacex/screens/menu_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  Bloc.observer = CustomObserver();
  initializeDateFormatting("tr_TR");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SpaceX',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
          titleTextStyle: TextStyle(
            color: Colors.white
          )
        ),
        iconTheme: IconThemeData(
          color: Color(0xFF8991a5)
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.black,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey
        ),
        useMaterial3: true,
      ),
      home: const MenuPage(),
    );
  }
}

