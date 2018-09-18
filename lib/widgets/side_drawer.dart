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
                    leading: !drawerItems[index].isTwitter
                        ? Icon(
                            drawerItems[index].iconData,
                            size: 30.0,
                          )
                        : Image.asset(
                            'res/twitter.png',
                            width: 40.0,
                            height: 40.0,
                            fit: BoxFit.contain,
                          ),
                    title: Text(
                      drawerItems[index].label,
                      style: TextStyle(fontSize: 22.0),
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed('/speakers');
                    },
                    selected: page == index,
                    trailing: drawerItems[index].isExternal
                        ? Icon(
                            Icons.launch,
                            color: iuMint,
                          )
                        : null,
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
  final bool isExternal;
  DrawerItem(
      {this.iconData,
      this.label,
      this.isTwitter = false,
      this.callback,
      this.isExternal = false});
}
