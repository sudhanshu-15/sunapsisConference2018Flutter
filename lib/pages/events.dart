import 'package:flutter/material.dart';
import 'package:sunapsis_conference18/widgets/event_list.dart';
import 'package:sunapsis_conference18/widgets/side_drawer.dart';

class Events extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => EventsState();
}

class EventsState extends State<Events> with SingleTickerProviderStateMixin {
  bool isFavorite = false;
  TabController _tabController;
  final List<Tab> dateTabs = <Tab>[
    Tab(
      text: 'All',
      icon: Icon(Icons.all_inclusive),
    ),
    Tab(
      text: 'Sep 29',
      icon: Icon(Icons.event),
    ),
    Tab(
      text: 'Sep 30',
      icon: Icon(Icons.event),
    ),
    Tab(
      text: 'Oct 1',
      icon: Icon(Icons.event),
    ),
    Tab(
      text: 'Oct 2',
      icon: Icon(Icons.event),
    ),
    Tab(
      text: 'Oct 3',
      icon: Icon(Icons.event),
    )
  ];

  final List<DrawerItem> drawerList = [
    DrawerItem(iconData: Icons.event, label: 'Schedules', callback: () {}),
    DrawerItem(iconData: Icons.mic, label: 'Speakers', callback: () {}),
    DrawerItem(
        iconData: Icons.launch,
        isTwitter: true,
        label: 'Twitter',
        callback: () {},
        isExternal: true),
    DrawerItem(
        iconData: Icons.map,
        label: 'Explore Indy',
        callback: () {},
        isExternal: true)
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: dateTabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          "res/sunapsislogo.png",
          fit: BoxFit.cover,
        ),
        bottom: TabBar(
          isScrollable:
              MediaQuery.of(context).orientation == Orientation.portrait,
          tabs: dateTabs,
          controller: _tabController,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          EventList(0),
          EventList(1),
          EventList(2),
          EventList(3),
          EventList(4),
          EventList(5),
        ],
      ),
      drawer: SideDrawer(0),
    );
  }
}
