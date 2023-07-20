import 'package:an_spacex/models/launch_data.dart';
import 'package:an_spacex/widgets/custom_background.dart';
import 'package:flutter/material.dart';

class LaunchDetailPage extends StatelessWidget {
  final LaunchData launchData;

  const LaunchDetailPage({Key? key, required this.launchData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
        child: Scaffold(
      appBar: AppBar(title: Text(launchData.name!)),
    ));
  }
}
