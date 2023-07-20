import 'package:an_spacex/blocs/launch/launch_bloc.dart';
import 'package:an_spacex/blocs/launch/launch_state.dart';
import 'package:an_spacex/widgets/launch_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LaunchDetailPage extends StatefulWidget {
  const LaunchDetailPage({Key? key}) : super(key: key);

  @override
  State<LaunchDetailPage> createState() => _LaunchDetailPageState();
}

class _LaunchDetailPageState extends State<LaunchDetailPage>
    with SingleTickerProviderStateMixin {
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
        return detailWidget(state);
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
        collapsedHeight: 100,
        backgroundColor: Colors.transparent,
        title: Text(
          state.launchData.name!,
          style: Theme.of(context)
              .textTheme
              .displaySmall!
              .copyWith(color: _isScrolled ? Colors.white : Colors.transparent),
        ),
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: BackButton(
              color: Colors.black,
            ),
          ),
        ),
        flexibleSpace: FlexibleSpaceBar(
          collapseMode: CollapseMode.parallax,
          background: Hero(
            tag: state.launchData.id!,
            child: Image.network(
              state.launchData.links?.patch?.large ??
                  "https://www.spacex.com/static/images/share.jpg",
              // Fotoğrafın URL'si
              fit: BoxFit.cover, // Boyutlandırma seçeneği
            ),
          ),
        ),
      ),
      SliverToBoxAdapter(
        child: SizedBox(
          height: MediaQuery.of(context).size.height -
              (MediaQuery.of(context).padding.top +
                  AppBar().preferredSize.height),
          child: LaunchItem(
            launchData: state.launchData,
            showName: !_isScrolled,
          ),
        ),
      ),
    ]);
  }
}
