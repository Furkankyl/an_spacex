import 'package:an_spacex/screens/home_page.dart';
import 'package:an_spacex/widgets/custom_background.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SpaceX"),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Launches"),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Ana Sayfa"),
        ],
      ),
      body: PageTransitionSwitcher(
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (
            Widget child,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            ) {
          return FadeThroughTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            fillColor: Colors.transparent,
            child: child,
          );
        },
        child: CustomBackground(child: getWidgetByIndex()),
      ),
    );
  }

  Widget getWidgetByIndex() {
    switch (currentIndex) {
      case 0:
        return HomePage();
      case 1:
        return SizedBox();
      default:
        return HomePage();
    }
  }
}
