import 'package:an_spacex/blocs/launch_list/launch_list_bloc.dart';
import 'package:an_spacex/blocs/launch_list/launch_list_state.dart';
import 'package:an_spacex/widgets/launch_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LaunchListPage extends StatefulWidget {
  const LaunchListPage({Key? key}) : super(key: key);

  @override
  State<LaunchListPage> createState() => _LaunchListPageState();
}

class _LaunchListPageState extends State<LaunchListPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LaunchListBloc, LaunchListState>(
        builder: (context, state) {
      if (state is Fetched) {
        return ListView(
          physics: const BouncingScrollPhysics(),
          children: state.list.map((e) {
            return LaunchListItem(launchData: e);
          }).toList(),
        );
      } else if (state is InitialState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return const Text("Beklenmedik bir hata oldu");
      }
    });
  }
}
