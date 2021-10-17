import 'package:dar_sllah/blocs/auth_bloc.dart';
import 'package:dar_sllah/providers/box_dish_provider.dart';
import 'package:dar_sllah/providers/comment_provider.dart';
import 'package:dar_sllah/providers/dish_provider.dart';
import 'package:dar_sllah/screens/Bag/tab_screen_bag.dart';
import 'package:dar_sllah/screens/Home%20Main/home_main_screen.dart';
import 'package:dar_sllah/screens/Login.dart';
import 'package:dar_sllah/screens/Shop/shop_detail_screen.dart';
import 'package:dar_sllah/screens/bottom_tab_screen.dart';
import 'package:dar_sllah/screens/box/box_mer/box_mer_detailed.dart';
import 'package:dar_sllah/screens/box/box_page_view.dart';
import 'package:dar_sllah/screens/box/box_terre/box_terre_detailed.dart';
import 'package:dar_sllah/screens/box/box_veggie/box_veggie_detailed.dart';
import 'package:dar_sllah/screens/onBoarding_Screen/OnBoarding_Screen.dart';
import 'package:dar_sllah/screens/payment_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

int _initScreen;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  SharedPreferences preferences = await SharedPreferences.getInstance();
  _initScreen = await preferences.getInt('initScreen');
  await preferences.setInt('initScreen', 1);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.grey,
      statusBarBrightness: Brightness.dark,
    ));
    return MultiProvider(
      providers: [
      ChangeNotifierProvider(create: (_) => DishProvider(),),
      ChangeNotifierProvider(create: (_) => CommentProvider(),),
      ChangeNotifierProvider(create: (_) => BoxDishProvider(),),
      Provider(create: (_) => AuthBloc(),),
      ],
      child: MaterialApp(
        title: 'Dar Sllah',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: HexColor("#FBCE01"),
            backgroundColor: Colors.white,
            accentColor: HexColor("#949494"),
            buttonTheme: ButtonTheme.of(context).copyWith(
              buttonColor: HexColor("#FBCE01"),
              textTheme: ButtonTextTheme.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
            )),
        home: _initScreen == 0 || _initScreen == null
            ? OnBoardingScreen()
            : LoginScreen(),
        routes: {
          LoginScreen.routeName: (ctx) => LoginScreen(),
          HomeMainScreen.routeName: (ctx) => HomeMainScreen(),
          DetailedShopScreen.routeName: (ctx) => DetailedShopScreen(),
          PaymentScreen.routeName: (ctx) => PaymentScreen(),
          BottomTabScreen.routeName: (ctx) => BottomTabScreen(),
          BoxPageViewScreen.routeName: (ctx) => BoxPageViewScreen(),
          BoxDetailedTerre.routeName: (ctx) => BoxDetailedTerre(),
          BoxDetailedMer.routeName: (ctx) => BoxDetailedMer(),
          BoxDetailedVeggie.routeName: (ctx) => BoxDetailedVeggie(),
          TabsScreenBag.routeName: (ctx) => TabsScreenBag(),
        },
      ),
    );
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
