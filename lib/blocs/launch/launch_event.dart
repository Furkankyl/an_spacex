import 'package:an_spacex/blocs/launch/launch_bloc.dart';
import 'package:an_spacex/models/launch_data.dart';

abstract class LaunchEvent {}

///[launchData] veriyi saklayıp tekrar çekmeden gönderebilmek için
///[LaunchBloc.mapEventToState]
class FetchLaunch extends LaunchEvent{
  LaunchData? launchData;

  FetchLaunch({this.launchData});
}
