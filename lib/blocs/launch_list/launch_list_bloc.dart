import 'package:an_spacex/blocs/launch_list/launch_list_event.dart';
import 'package:an_spacex/blocs/launch_list/launch_list_state.dart';
import 'package:an_spacex/services/core_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LaunchListBloc extends Bloc<LaunchListEvent, LaunchListState> {
  LaunchListBloc() : super(InitialState()) {
    on<FetchLaunchList>((event, emit) async{
      emit.call(await mapEventToState(event).first);
    });
  }

  Stream<LaunchListState> mapEventToState(LaunchListEvent event) async* {
    if (event is FetchLaunchList) {
      final response = await CoreService.getAllLaunchData();
      if (response != null) {
        yield Fetched(response);
      } else {
        yield Failure();
      }
    }
  }
}
