import 'package:flutter/material.dart';
import 'package:sunapsis_conference18/utils/color_config.dart';

class SideDrawer extends StatelessWidget {
  final int page;

  final List<DrawerItem> drawerItems;

  SideDrawer(this.page, this.drawerItems);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
              decoration: BoxDecoration(color: iuMidnightBlue),
              child: Image.asset(
                'res/sunapsis-conference-logo-01.png',
                fit: BoxFit.contain,
              )),
          Expanded(
            child: ListView.builder(
                itemCount: drawerItems.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: Icon(
                      drawerItems[index].iconData,
                      size: 30.0,
                    ),
                    title: Text(
                      drawerItems[index].label,
                      style: TextStyle(fontSize: 22.0),
                    ),
                    onTap: drawerItems[index].callback,
                    selected: page == index,
                  );
                }),
          ),
        ],
      ),
    );
  }
}

class DrawerItem {
  final IconData iconData;
  final String label;
  final VoidCallback callback;
  final bool isTwitter;
  DrawerItem({this.iconData, this.label, this.isTwitter, this.callback});
}
