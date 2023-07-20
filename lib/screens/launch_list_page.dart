import 'package:an_spacex/blocs/launch_list/launch_list_bloc.dart';
import 'package:an_spacex/blocs/launch_list/launch_list_event.dart';
import 'package:an_spacex/blocs/launch_list/launch_list_state.dart';
import 'package:an_spacex/widgets/launch_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rive/rive.dart';

class LaunchListPage extends StatefulWidget {
  const LaunchListPage({Key? key}) : super(key: key);

  @override
  State<LaunchListPage> createState() => _LaunchListPageState();
}

class _LaunchListPageState extends State<LaunchListPage> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LaunchListBloc, LaunchListState>(
        builder: (context, state) {
      if (state is Fetched) {
        return refreshWidget(state);
      } else if (state is InitialState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return const Text("Beklenmedik bir hata oldu");
      }
    });
  }

  Widget refreshWidget(Fetched state) {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      //TODO CREATE CUSTOM HEADER
      header: CustomHeader(builder: (context, RefreshStatus? status) {
        return SizedBox(
          height: 50,
          width: 50,
          child: RiveAnimation.asset("assets/space_coffee.riv"),
        );
      }),
      footer: CustomFooter(
        builder: (BuildContext context, LoadStatus? mode) {
          Widget body;
          if (mode == LoadStatus.idle) {
            body = Text("pull up load");
          } else if (mode == LoadStatus.loading) {
            body = CircularProgressIndicator();
          } else if (mode == LoadStatus.failed) {
            body = Text("Load Failed!Click retry!");
          } else if (mode == LoadStatus.canLoading) {
            body = Text("release to load more");
          } else {
            body = Text("No more Data");
          }

          return Container(
            height: 55.0,
            child: Center(child: body),
          );
        },
      ),
      controller: _refreshController,
      onRefresh: _refresh,
      onLoading: () {},
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: state.list.map((e) {
          return LaunchListItem(launchData: e);
        }).toList(),
      ),
    );
  }

  void _refresh() async {
    context.read<LaunchListBloc>().add(FetchLaunchList());
    await Future.delayed(Duration(milliseconds: 500));
    _refreshController.refreshCompleted();
  }
}
