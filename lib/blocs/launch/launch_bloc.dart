import 'package:an_spacex/blocs/launch/launch_event.dart';
import 'package:an_spacex/blocs/launch/launch_state.dart';
import 'package:an_spacex/services/core_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LaunchBloc extends Bloc<LaunchEvent, LaunchState> {
  LaunchBloc() : super(InitialState()) {
    on<FetchLaunch>((event, emit) async {
        emit.call(await mapEventToState(event).first);
    });
  }

  Stream<LaunchState> mapEventToState(LaunchEvent event) async* {
    if (event is FetchLaunch) {
      if(event.launchData != null) {
        yield Fetched(event.launchData!);
      }

      final response = await CoreService.getLatestLaunchData();
      if (response != null) {
        yield Fetched(response);
      } else {
        yield Failure();
      }
    }
  }
}
