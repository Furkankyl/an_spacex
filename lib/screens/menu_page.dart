import 'package:an_spacex/blocs/launch/launch_bloc.dart';
import 'package:an_spacex/blocs/launch/launch_event.dart';
import 'package:an_spacex/blocs/launch_list/launch_list_bloc.dart';
import 'package:an_spacex/blocs/launch_list/launch_list_event.dart';
import 'package:an_spacex/screens/last_launch/last_launch_page.dart';
import 'package:an_spacex/screens/list/launch_list_page.dart';
import 'package:an_spacex/widgets/custom_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.shuttleSpace), label: "Son Görev"),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.rocket), label: "Görevler"),
        ],
      ),
      body: CustomBackground(child: getWidgetByIndex()),
    );
  }

  Widget getWidgetByIndex() {
    switch (currentIndex) {
      case 0:
        return BlocProvider<LaunchBloc>(
          create: (context) => LaunchBloc()..add(FetchLaunch()),
          child: const LastLaunchPage(),
        );
      case 1:
        return BlocProvider<LaunchListBloc>(
          create: (context) => LaunchListBloc()..add(FetchLaunchList()),
          child: const LaunchListPage(),
        );
      default:
        return const LaunchListPage();
    }
  }
}
