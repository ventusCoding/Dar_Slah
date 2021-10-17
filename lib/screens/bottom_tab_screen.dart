import 'package:dar_sllah/blocs/auth_bloc.dart';
import 'package:dar_sllah/screens/Home%20Main/home_main_screen.dart';
import 'package:dar_sllah/screens/Login.dart';
import 'package:dar_sllah/screens/Shop/shop_screen.dart';
import 'package:dar_sllah/screens/about_screen.dart';
import 'package:dar_sllah/screens/box/box_page_view.dart';
import 'package:dar_sllah/widgets/dialogs/rate_us_dialog_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Bag/tab_screen_bag.dart';

class BottomTabScreen extends StatefulWidget {
  static String routeName = "BottomTabScreen";

  @override
  _BottomTabScreenState createState() => _BottomTabScreenState();
}

class _BottomTabScreenState extends State<BottomTabScreen> {
  int dialogShowInt;

  // @override
  // void initState() {
  //   var authBloc = Provider.of<AuthBloc>(context, listen: false);
  //   authBloc.currentUser.listen((fbUser) {
  //     if (fbUser == null) {
  //       try {
  //         Navigator.of(context).pushReplacement(
  //             MaterialPageRoute(builder: (context) => LoginScreen()));
  //       } catch (Exeption) {}
  //     }
  //   });

  //   super.initState();
  // }

  Widget lastWidget;

  List<Widget> _pages = [
    HomeMainScreen(),
    BoxPageViewScreen(),
    TabsScreenBag(),
    ShopScreen(),
    AboutScreen(),
  ];

  int _selectedPageIndex = 0;

  void _selectPage(int index) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    dialogShowInt = await preferences.getInt('dialogShowInt');

    setState(() {
      if (index == 1) {
        Navigator.pushNamed(context, BoxPageViewScreen.routeName);
      }

      _pages[1] = _pages[_selectedPageIndex];

      _selectedPageIndex = index;

      if (_selectedPageIndex == 4) {
        if (dialogShowInt == 0 || dialogShowInt == null) {
          showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Container(
                    width: 500,
                    height: 500,
                    child: RateUsDialogCardWidget(),
                  ),
                );
              });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        backgroundColor: Colors.white,
        fixedColor: Colors.yellow,
        items: [
          BottomNavigationBarItem(
              icon: Image.asset("assets/images/home_icon.png"),
              label: "Home",
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Image.asset("assets/images/take_away_icon.png"),
              label: "Take away",
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Image.asset("assets/images/shopping_icon.png"),
              label: "Shopping",
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Image.asset("assets/images/restaurant_icon.png"),
              label: "Restaurant",
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Image.asset("assets/images/about_icon.png"),
              label: "About",
              backgroundColor: Colors.white),
        ],
      ),
      body: _pages[_selectedPageIndex],
    );
  }
}
