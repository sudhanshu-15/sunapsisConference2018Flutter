import 'package:flutter/material.dart';
import 'package:sunapsis_conference18/utils/color_config.dart';
import 'package:url_launcher/url_launcher.dart';

class SideDrawer extends StatelessWidget {
  final int page;
  final String _twitterFeed =
      "https://twitter.com/search?l=&q=%23sunapsis18&src=typd";
  final String _exploreIndy = "http://www.sunapsis.iu.edu/conference-maps.html";
  SideDrawer(this.page);

  @override
  Widget build(BuildContext context) {
    final List<DrawerItem> drawerList = [
      DrawerItem(
          iconData: Icons.event,
          label: 'Schedules',
          callback: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/events', ModalRoute.withName('/speaker'));
          }),
      DrawerItem(
          iconData: Icons.mic,
          label: 'Speakers',
          callback: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/speakers', ModalRoute.withName('/events'));
          }),
      DrawerItem(
          iconData: Icons.launch,
          isTwitter: true,
          label: 'Twitter',
          callback: () async {
            if (await canLaunch(_twitterFeed)) {
              await launch(_twitterFeed);
            }
          },
          isExternal: true),
      DrawerItem(
          iconData: Icons.map,
          label: 'Explore Indy',
          callback: () async {
            if (await canLaunch(_exploreIndy)) {
              await launch(_exploreIndy);
            }
          },
          isExternal: true)
    ];
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
                itemCount: drawerList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: !drawerList[index].isTwitter
                        ? Icon(
                            drawerList[index].iconData,
                            size: 30.0,
                          )
                        : Image.asset(
                            'res/twitter.png',
                            width: 40.0,
                            height: 40.0,
                            fit: BoxFit.contain,
                          ),
                    title: Text(
                      drawerList[index].label,
                      style: TextStyle(fontSize: 22.0),
                    ),
                    onTap: () => drawerList[index].callback(),
                    selected: page == index,
                    trailing: drawerList[index].isExternal
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
