import 'package:an_spacex/custom_observer.dart';
import 'package:an_spacex/screens/menu_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
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
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
            foregroundColor: Colors.white, backgroundColor: Colors.deepPurple),
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.black,
            titleTextStyle: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Color(0xFF8991a5)),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Colors.deepPurple.withOpacity(.3),
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey),
        textTheme: TextTheme(
          displayLarge: GoogleFonts.ubuntu(
            color: Colors.white,
          ),
          displayMedium: GoogleFonts.ubuntu(
            color: Colors.white,
          ),
          displaySmall: GoogleFonts.ubuntu(color: Colors.white, fontSize: 24),
          bodyLarge: GoogleFonts.ubuntu(color: Colors.white),
          bodyMedium: GoogleFonts.ubuntu(color: Colors.white),
          bodySmall: GoogleFonts.ubuntu(color: Colors.white),
        ),
        useMaterial3: true,
      ),
      home: const MenuPage(),
    );
  }
}
