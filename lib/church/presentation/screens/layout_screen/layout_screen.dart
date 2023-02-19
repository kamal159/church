import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

import '../../../../core/services/sevices_locator.dart';
import '../../../../profile.dart';
import '../../controller/layout/layout_bloc.dart';
import '../../controller/layout/layout_event.dart';
import '../../controller/layout/layout_state.dart';
import '../settings_screen/settings_screen.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.animateTo(0);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<LayoutBloc>()..add(GetUserDataEvent()),
      child: BlocConsumer<LayoutBloc, LayoutState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: DefaultTabController(
              length: 3,
              child: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      systemOverlayStyle: const SystemUiOverlayStyle(
                          statusBarColor: Colors.transparent,
                          statusBarIconBrightness: Brightness.light),
                      scrolledUnderElevation: 0,
                      expandedHeight: 49 * 2,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15.0),
                          bottomRight: Radius.circular(15.0),
                        ),
                      ),
                      floating: true,
                      pinned: true,
                      primary: true,
                      leading: IconButton(
                          onPressed: () {},
                          icon: const Icon(IconlyBroken.profile)),
                      centerTitle: true,
                      actions: [
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(IconlyBroken.notification))
                      ],
                      title: const Text('كنيستي'),
                      bottom: TabBar(
                        controller: _tabController,
                        onTap: (value) {
                          debugPrint(value.toString());
                        },
                        tabs: const [
                          Tab(icon: Icon(IconlyBroken.home)),
                          Tab(icon: Icon(IconlyBroken.user_2)),
                          Tab(icon: Icon(IconlyBroken.setting)),
                        ],
                      ),
                    ),
                  ];
                },
                body: TabBarView(
                  controller: _tabController,
                  children: const [
                    SingleChildScrollView(child: Profile()),
                    Profile(),
                    SettingsScreen(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
