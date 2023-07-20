import 'package:an_spacex/blocs/launch_list/launch_list_bloc.dart';
import 'package:an_spacex/blocs/launch_list/launch_list_event.dart';
import 'package:an_spacex/blocs/launch_list/launch_list_state.dart';
import 'package:an_spacex/widgets/launch_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

  late ScrollController _scrollController;
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    setState(() {
      _isScrolled = _scrollController.offset > 200; // Kaydırma eşiği
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: !_isScrolled
          ? null
          : FloatingActionButton(
              child: const Icon(FontAwesomeIcons.chevronUp),
              onPressed: () {
                _scrollController.animateTo(0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.fastLinearToSlowEaseIn);
              },
            ),
      body: SafeArea(
        child: BlocBuilder<LaunchListBloc, LaunchListState>(
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
        }),
      ),
    );
  }

  Widget refreshWidget(Fetched state) {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      //TODO CREATE CUSTOM HEADER
      header: CustomHeader(
        builder: (context, RefreshStatus? status) {
          return const SizedBox(
            height: 100,
            width: 100,
            child: RiveAnimation.asset("assets/rocket.riv"),
          );
        },
        height: 100,
      ),
      footer: CustomFooter(
        builder: (BuildContext context, LoadStatus? mode) {
          Widget body;
          if (mode == LoadStatus.idle) {
            body = const Text("pull up load");
          } else if (mode == LoadStatus.loading) {
            body = const RiveAnimation.asset(
              "assets/rocket.riv",
              animations: ["Flying"],
            );
          } else if (mode == LoadStatus.failed) {
            body = const Text("Load Failed!Click retry!");
          } else if (mode == LoadStatus.canLoading) {
            body = const Text("release to load more");
          } else {
            body = const Text("No more Data");
          }

          return SizedBox(
            height: 100.0,
            child: Center(child: body),
          );
        },
        height: 100,
      ),
      controller: _refreshController,
      onRefresh: _refresh,
      onLoading: () {
        _loadMore(state);
      },
      child: ListView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        children: state.list.map((e) {
          return LaunchListItem(launchData: e);
        }).toList(),
      ),
    );
  }

  void _refresh() async {
    context.read<LaunchListBloc>().add(FetchLaunchList());
    await Future.delayed(const Duration(milliseconds: 500));
    _refreshController.refreshCompleted();
  }

  void _loadMore(Fetched state) async {
    context
        .read<LaunchListBloc>()
        .add(FetchLaunchList(count: state.list.length + 5));
    await Future.delayed(const Duration(milliseconds: 1000));
    _refreshController.loadComplete();
  }
}
