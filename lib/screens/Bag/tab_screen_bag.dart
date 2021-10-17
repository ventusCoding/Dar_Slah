import 'package:dar_sllah/main.dart';
import 'package:dar_sllah/screens/Bag/bag_screen.dart';
import 'package:dar_sllah/screens/Bag/traking_screen.dart';
import 'package:flutter/material.dart';

class TabsScreenBag extends StatefulWidget {
  static String routeName = "TabsScreenBag";

  @override
  _TabsScreenBagState createState() => _TabsScreenBagState();
}

class _TabsScreenBagState extends State<TabsScreenBag> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          bottom: TabBar(
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            indicatorColor: HexColor("#FBD524"),
            labelColor: HexColor("#FBD524"),
            unselectedLabelColor: HexColor("#A8A8A8"),
            indicatorWeight: 2,
            indicatorSize: TabBarIndicatorSize.label,
            tabs: [
              Tab(
                text: "Your bag",
                icon: Container(
                  width: 30,
                  height: 30,
                  child: _currentIndex == 0
                      ? Image.asset("assets/images/shopping-bag_active.png")
                      : Image.asset("assets/images/shopping-bag_inactive.png"),
                ),
              ),
              Tab(
                text: "Tracking",
                icon: Container(
                  width: 35,
                  height: 35,
                  child: _currentIndex == 1
                      ? Image.asset("assets/images/track_active.png")
                      : Image.asset("assets/images/track_inactive.png"),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(children: [
          BagScreen(),
          TrakingScreen(),
        ]),
      ),
    );
  }
}
