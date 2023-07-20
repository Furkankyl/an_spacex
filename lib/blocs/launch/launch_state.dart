import 'package:an_spacex/models/launch_data.dart';

abstract class LaunchState {}

class InitialState extends LaunchState{}

class Failure extends LaunchState{}

class Fetched extends LaunchState{
  LaunchData launchData;
  Fetched(this.launchData);
}
