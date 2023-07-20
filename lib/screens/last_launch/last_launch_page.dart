import 'package:an_spacex/blocs/launch/launch_bloc.dart';
import 'package:an_spacex/blocs/launch/launch_event.dart';
import 'package:an_spacex/blocs/launch/launch_state.dart';
import 'package:an_spacex/widgets/launch_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rive/rive.dart';

class LastLaunchPage extends StatefulWidget {
  const LastLaunchPage({Key? key}) : super(key: key);

  @override
  State<LastLaunchPage> createState() => _LastLaunchPageState();
}

class _LastLaunchPageState extends State<LastLaunchPage>
    with SingleTickerProviderStateMixin {
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
      _isScrolled = _scrollController.offset > 150; // Kaydırma eşiği
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LaunchBloc, LaunchState>(builder: (context, state) {
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

  Widget detailWidget(Fetched state) {
    return CustomScrollView(controller: _scrollController, slivers: [
      SliverAppBar(
        expandedHeight: 250,
        floating: true,
        pinned: true,
        backgroundColor: Colors.transparent,
        title: Text(
          state.launchData.name!,
          style: Theme.of(context)
              .textTheme
              .displaySmall!
              .copyWith(color: _isScrolled ? Colors.white : Colors.transparent),
        ),
        flexibleSpace: FlexibleSpaceBar(
          collapseMode: CollapseMode.parallax,
          background: Hero(
            tag: state.launchData.id!,
            child: Image.network(
              state.launchData.links?.patch?.large ??
                  "https://www.spacex.com/static/images/share.jpg",
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      SliverToBoxAdapter(
        child: SizedBox(
          height: MediaQuery.of(context).size.height -
              (MediaQuery.of(context).padding.top +
                  AppBar().preferredSize.height +
                  kBottomNavigationBarHeight),
          child: LaunchItem(
            launchData: state.launchData,
            showName: !_isScrolled,
          ),
        ),
      ),
    ]);
  }

  Widget refreshWidget(Fetched state) {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: false,
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
      controller: _refreshController,
      onRefresh: _refresh,
      child: detailWidget(state),
    );
  }

  void _refresh() async {
    context.read<LaunchBloc>().add(FetchLaunch());
    await Future.delayed(const Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }
}
