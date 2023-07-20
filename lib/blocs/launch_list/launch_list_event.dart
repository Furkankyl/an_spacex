abstract class LaunchListEvent {}

class FetchLaunchList extends LaunchListEvent{
  int count = 5;

  FetchLaunchList({this.count = 5});
}
