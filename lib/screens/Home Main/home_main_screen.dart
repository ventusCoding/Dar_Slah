import 'package:dar_sllah/classes/dish.dart';
import 'package:dar_sllah/providers/dish_provider.dart';
import 'package:dar_sllah/widgets/Home%20Main%20Widgets/today_dishes_card_widget.dart';
import 'package:dar_sllah/widgets/Home%20Main%20Widgets/search_bar_widget.dart';
import 'package:dar_sllah/widgets/Home%20Main%20Widgets/votre_cuisine_txt_and_reservervation_btn.dart';
import 'package:dar_sllah/widgets/Shop/shop_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeMainScreen extends StatefulWidget {
  static String routeName = "HomeMainScreen";

  @override
  _HomeMainScreenState createState() => _HomeMainScreenState();
}

class _HomeMainScreenState extends State<HomeMainScreen> {
  bool _isLoading = true;
  var _isInit = true;
  List<Dish> dishesForDisplay;

  @override
  void initState() {
    Provider.of<DishProvider>(context, listen: false).setPath("Today Dish");

    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<DishProvider>(context)
          .fetchData("Today Dish")
          .whenComplete(() {
        setState(() {
          _isLoading = !_isLoading;
        });
      });
    }
    dishesForDisplay = Provider.of<DishProvider>(context, listen: false).dishes;
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final dishesData = Provider.of<DishProvider>(context, listen: false);
    var dishes = dishesData.dishes;

    final deviceSize = MediaQuery.of(context).size;
    double cardHeight = 200.0 * dishesForDisplay.length;

    return Scaffold(
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: VotreCuisineTxtAndReservationBtn(),
                  ),
                  SearchBarWidget(dishes, (list) {
                    setState(() {
                      dishesForDisplay = list;
                    });
                  }),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Text(
                      'Today\'s Dishes',
                      style: TextStyle(
                        fontFamily: 'Open Sans',
                        fontSize: MediaQuery.of(context).size.width / 15,
                        color: const Color(0xff1d2126),
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(
                    width: deviceSize.width,
                    height: MediaQuery.of(context).size.width ,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (ctx, i) => TodayDishesCardWidget(
                        id: dishesForDisplay[i].id,
                        description: dishesForDisplay[i].description,
                        image: dishesForDisplay[i].image,
                        includes: dishesForDisplay[i].includes,
                        name: dishesForDisplay[i].name,
                        price: dishesForDisplay[i].price,
                        quantity: dishesForDisplay[i].quantity,
                        rate: dishesForDisplay[i].rate,
                      ),
                      itemCount: dishesForDisplay.length,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Text(
                      'Most Popular',
                      style: TextStyle(
                        fontFamily: 'Open Sans',
                        fontSize: MediaQuery.of(context).size.width / 16,
                        color: const Color(0xff1d2126),
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(
                    height: cardHeight,
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (ctx, i) => ShopCard(
                        id: dishesForDisplay[i].id,
                        description: dishesForDisplay[i].description,
                        image: dishesForDisplay[i].image,
                        includes: dishesForDisplay[i].includes,
                        name: dishesForDisplay[i].name,
                        price: dishesForDisplay[i].price,
                        quantity: dishesForDisplay[i].quantity,
                        rate: dishesForDisplay[i].rate,
                      ),
                      itemCount: dishesForDisplay.length,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
