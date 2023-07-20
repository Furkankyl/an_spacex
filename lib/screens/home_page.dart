import 'package:an_spacex/models/launch_data.dart';
import 'package:an_spacex/services/core_service.dart';
import 'package:an_spacex/widgets/launch_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rive/rive.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CoreService core = CoreService();

  List<LaunchData>? list;

  @override
  void initState() {
    core.getAllLaunchData().then((value) {
      setState(() {
        list = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: list == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              physics: const BouncingScrollPhysics(),
              children: list!.map((e) {
                return LaunchListItem(launchData: e);
              }).toList(),
            ),
    );
  }

}
