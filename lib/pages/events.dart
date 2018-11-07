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
    int initialIndex = 0;
    var presentDate = DateTime.now();
    if ((presentDate.month == 9 || presentDate.month == 10) &&
        presentDate.year == 2018) {
      if (presentDate.month == 9) {
        switch (presentDate.day) {
          case 29:
            initialIndex = 1;
            break;
          case 30:
            initialIndex = 2;
            break;
          default:
            break;
        }
      } else if (presentDate.month == 10) {
        switch (presentDate.day) {
          case 1:
            initialIndex = 3;
            break;
          case 2:
            initialIndex = 4;
            break;
          case 3:
            initialIndex = 5;
            break;
          default:
            break;
        }
      }
    }
    _tabController = TabController(
        length: dateTabs.length, vsync: this, initialIndex: initialIndex);
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
