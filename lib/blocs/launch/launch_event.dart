import 'package:an_spacex/models/launch_data.dart';

abstract class LaunchEvent {}

class FetchLaunch extends LaunchEvent{
  LaunchData? launchData;

  FetchLaunch({this.launchData});
}
