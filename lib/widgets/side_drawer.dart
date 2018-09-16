import 'package:flutter/material.dart';

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
              child: Image.asset(
            'res/sunapsislogo.png',
            fit: BoxFit.cover,
          )),
          Expanded(
            child: ListView.builder(
                itemCount: drawerItems.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: Icon(drawerItems[index].iconData),
                    title: Text(drawerItems[index].label),
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
  DrawerItem({this.iconData, this.label, this.callback});
}
