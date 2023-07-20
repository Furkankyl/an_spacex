import 'package:an_spacex/models/launch_data.dart';

abstract class LaunchListState {}

class InitialState extends LaunchListState{}

class Failure extends LaunchListState{}

class Fetched extends LaunchListState{
  List<LaunchData> list;
  Fetched(this.list);
}
