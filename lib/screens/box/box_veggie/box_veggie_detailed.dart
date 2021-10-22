import 'package:dar_sllah/classes/about_card_class.dart';
import 'package:dar_sllah/classes/comment.dart';
import 'package:dar_sllah/classes/dish.dart';
import 'package:dar_sllah/classes/includes.dart';
import 'package:dar_sllah/classes/overview.dart';
import 'package:dar_sllah/providers/box_dish_provider.dart';
import 'package:dar_sllah/providers/comment_provider.dart';
import 'package:dar_sllah/providers/dish_provider.dart';
import 'package:dar_sllah/screens/Bag/tab_screen_bag.dart';
import 'package:dar_sllah/widgets/Shop/include_card_widget.dart';
import 'package:dar_sllah/widgets/Shop/review_card_widget.dart';
import 'package:dar_sllah/widgets/about_card_widget.dart';
import 'package:dar_sllah/widgets/box/box_include_card_widget.dart';
import 'package:dar_sllah/widgets/box/overview_card_widget.dart';
import 'package:dar_sllah/widgets/dialogs/add_comment_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class BoxDetailedVeggie extends StatefulWidget {
  static String routeName = "BoxVeggieDetailedScreen";
  @override
  _BoxDetailedVeggie createState() => _BoxDetailedVeggie();
}

class _BoxDetailedVeggie extends State<BoxDetailedVeggie> {
  int _quantity = 1;
  String path;
  Dish loadedBoxDish;
  String id;
  var commentBool = false;
  Future func;

  CommentProvider commentsData;
  List<Comment> comments;

  final List<AboutCardClass> aboutList = [
    AboutCardClass("assets/images/moto_icon.png", "Home delivery",
        "We Deliver the best quality food at your doorsteps\nfor 7DT extra cost for each delivery past 60 DT"),
    AboutCardClass("assets/images/vegetable_icon.png", "Fresh Fodd",
        "Sadri goes to the Central Market of Tunis to select\nthe best products, the freshest, the seasonal"),
    AboutCardClass("assets/images/bag_food_icon.png", "48H Of Resistance ",
        "with our special packaging, you can save the food\nin your fridge for 48 hours and find as it is"),
  ];

  final List<OverView> overviewList = [
    OverView(
      name: 'Salade',
      image: 'assets/images/icon_salade.png',
    ),
    OverView(
      name: 'Plat Végétarien',
      image: 'assets/images/icon_salade.png',
    ),
    OverView(
      name: 'Fruit',
      image: 'assets/images/icon_fruit.png',
    ),
    OverView(
      name: 'Petit Pain',
      image: 'assets/images/icon_pain.png',
    ),
  ];

  Future<void> _refreshComments(BuildContext context) async {
    await Provider.of<CommentProvider>(context, listen: false)
        .fetchData(path: path, dishId: loadedBoxDish.id)
        .whenComplete(() {
      commentBool = false;
      comments = commentsData.comments;
    });
  }

  @override
  void initState() {
    loadedBoxDish =
        Provider.of<BoxDishProvider>(context, listen: false).findById("Veggie");

    path = "box";
    id = loadedBoxDish.id;

    Provider.of<BoxDishProvider>(context, listen: false)
        .boxDishes
        .forEach((element) {
      element.total = element.price;
    });

    func = _refreshComments(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    final loadedBoxDish =
        Provider.of<BoxDishProvider>(context, listen: false).findById("Veggie");

    commentsData = Provider.of<CommentProvider>(context, listen: false);

    if (Provider.of<CommentProvider>(context, listen: false).newRating !=
        null) {
      loadedBoxDish.rate =
          Provider.of<CommentProvider>(context, listen: false).newRating;

      Provider.of<CommentProvider>(context, listen: false).newRating = null;
    }

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RaisedButton.icon(
                    elevation: 0,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    label: Text(
                      'BACK',
                      style: TextStyle(color: Colors.black),
                    ),
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                    textColor: Colors.black,
                    color: Colors.white,
                  ),
                  Stack(
                    children: [
                      IconButton(
                          icon: Icon(
                            Icons.shopping_bag_outlined,
                            size: 30,
                          ),
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(TabsScreenBag.routeName);
                          }),
                      Positioned(
                          top: 25,
                          left: 25,
                          child: Container(
                            alignment: Alignment.center,
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                                color: Colors.orange, shape: BoxShape.circle),
                            child: Text(
                              "${Provider.of<DishProvider>(context, listen: false).packedDishes.length}",
                              style:
                                  TextStyle(fontSize: 10, color: Colors.white),
                            ),
                          ))
                    ],
                  )
                ],
              ),
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 16, top: 16),
                    width: size.width * 0.75,
                    height: size.height * 0.45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.25),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            "la box",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                          Text(
                            "${loadedBoxDish.name}",
                            style: TextStyle(fontSize: size.width * 0.125),
                          ),
                          RatingBarIndicator(
                            itemBuilder: (context, index) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            rating: loadedBoxDish.rate,
                            itemCount: 5,
                            itemSize: 12.5,
                            unratedColor: Colors.amber.withAlpha(50),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    "(1200) reviews",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 14),
                                  ),
                                  Column(
                                    children: [
                                      MaterialButton(
                                        height: 40,
                                        minWidth: 40,
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return Dialog(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  child: Container(
                                                    width: 500,
                                                    height: 300,
                                                    child:
                                                        AddCommentDialogWidget(
                                                            id: loadedBoxDish
                                                                .id,
                                                            path: path,
                                                            onAddComment: () {
                                                              setState(() {
                                                                commentBool =
                                                                    true;
                                                              });
                                                            }),
                                                  ),
                                                );
                                              });
                                        },
                                        color: Colors.white,
                                        textColor: Colors.black,
                                        child: Icon(
                                          Icons.edit,
                                        ),
                                        padding: EdgeInsets.all(8),
                                        shape: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black,
                                              width: 1,
                                              style: BorderStyle.solid),
                                          borderRadius:
                                              new BorderRadius.circular(60.0),
                                        ),
                                      ),
                                      Text(
                                        'Rate',
                                        style: TextStyle(fontSize: 10),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${loadedBoxDish.price} DT",
                                    style: TextStyle(
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Delivery costs 7 DT",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.grey),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      MaterialButton(
                                        height: 20,
                                        minWidth: 20,
                                        onPressed: () {
                                          if (_quantity > 1) {
                                            setState(() {
                                              _quantity--;
                                              loadedBoxDish.total -=
                                                  loadedBoxDish.price;
                                            });
                                          }
                                        },
                                        color: Colors.white,
                                        textColor: Colors.black,
                                        child: Icon(
                                          Icons.remove,
                                          size: 10,
                                        ),
                                        padding: EdgeInsets.all(8),
                                        shape: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.yellow,
                                              width: 1,
                                              style: BorderStyle.solid),
                                          borderRadius:
                                              new BorderRadius.circular(5.0),
                                        ),
                                      ),
                                      Text(
                                        '$_quantity',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Colors.black),
                                      ),
                                      MaterialButton(
                                        height: 20,
                                        minWidth: 20,
                                        onPressed: () {
                                          setState(() {
                                            _quantity++;
                                            loadedBoxDish.total +=
                                                loadedBoxDish.price;
                                          });
                                        },
                                        color: Colors.white,
                                        textColor: Colors.black,
                                        child: Icon(
                                          Icons.add,
                                          size: 10,
                                        ),
                                        padding: EdgeInsets.all(8),
                                        shape: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.yellow,
                                              width: 1,
                                              style: BorderStyle.solid),
                                          borderRadius:
                                              new BorderRadius.circular(5.0),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(size.width * 0.60, size.height * 0.085),
                    child: Container(
                      width: size.width * 0.33,
                      child: Image.network(
                        "${loadedBoxDish.image}",
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
              loadedBoxDish.overviewList.length == 0
                  ? SizedBox()
                  : Container(
                      margin: EdgeInsets.only(
                        left: 20,
                        top: 20,
                      ),
                      child: Text(
                        'OverView',
                        style: TextStyle(
                          fontFamily: 'Raleway',
                          fontSize: 27,
                          color: const Color(0xff000000),
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
              loadedBoxDish.overviewList.length == 0
                  ? SizedBox()
                  : GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 2.5,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20),
                      itemCount: loadedBoxDish.overviewList.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return OverViewCardWidget(
                          id: loadedBoxDish.overviewList[index].id,
                          image: loadedBoxDish.overviewList[index].image,
                          name: loadedBoxDish.overviewList[index].name,
                        );
                      }),
              Container(
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.only(top: 16),
                  child: Text(
                    'Description',
                    style: TextStyle(fontSize: size.width * 0.05),
                  )),
              Container(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    '${loadedBoxDish.description}',
                    style: TextStyle(
                        fontSize: size.width * 0.033,
                        color: Colors.grey,
                        height: 3),
                  )),
              loadedBoxDish.includes.length == 0
                  ? SizedBox()
                  : Container(
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.only(top: 16),
                      child: Text(
                        'Includes',
                        style: TextStyle(fontSize: size.width * 0.05),
                      )),
              loadedBoxDish.includes.length == 0
                  ? SizedBox()
                  : GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: loadedBoxDish.includes.length,
                      itemBuilder: (_, index) {
                        return BoxIncludesCard(
                          dishId: loadedBoxDish.id,
                          id: loadedBoxDish.includes[index].id,
                          name: loadedBoxDish.includes[index].name,
                          price: loadedBoxDish.includes[index].price,
                          image: loadedBoxDish.includes[index].image,
                          onQuantityChangeAdd: () {
                            loadedBoxDish.total +=
                                loadedBoxDish.includes[index].price;
                            setState(() {});
                          },
                          onQuantityChangeSub: () {
                            loadedBoxDish.total -=
                                loadedBoxDish.includes[index].price;
                            setState(() {});
                          },
                        );
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: MediaQuery.of(context).size.width /
                            (MediaQuery.of(context).size.height),
                      ),
                    ),
              Container(
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.only(top: 16),
                  child: Text(
                    'Why dar sllah',
                    style: TextStyle(fontSize: size.width * 0.075),
                  )),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  height: 350,
                  width: double.infinity,
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: aboutList.length,
                    itemBuilder: (context, index) => AboutCardWidget(
                        aboutList[index].image,
                        aboutList[index].name,
                        aboutList[index].description),
                  ),
                ),
              ),
              Container(
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.only(top: 16),
                  child: Text(
                    'Customers review',
                    style: TextStyle(fontSize: size.width * 0.075),
                  )),
              FutureBuilder(
                future: commentBool
                    ? _refreshComments(context).then((value) {
                        setState(() {});
                      })
                    : func,
                builder: (ctx, snapshot) => snapshot.connectionState ==
                        ConnectionState.waiting
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: comments.length,
                        itemBuilder: (context, index) => CustomerReviewComment(
                          id: comments[index].id,
                          description: comments[index].description,
                          image: comments[index].image,
                          name: comments[index].name,
                          rate: comments[index].rate,
                        ),
                      ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            boxShadow: [
              BoxShadow(
                color: Colors.black87,
                blurRadius: 4,
                spreadRadius: -2,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(30.0),
              topRight: const Radius.circular(30.0),
            ),
            child: Container(
              height: 150.0,
              width: double.infinity,
              color: Colors.white,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total:',
                            style: TextStyle(
                              fontFamily: 'Raleway',
                              fontSize: 25,
                              color: const Color(0xff707070),
                              fontWeight: FontWeight.w400,
                              height: 1.8181818181818181,
                            ),
                            textHeightBehavior: TextHeightBehavior(
                                applyHeightToFirstAscent: false),
                            textAlign: TextAlign.left,
                          ),
                          Column(
                            children: [
                              Text(
                                '${loadedBoxDish.total.toStringAsFixed(2)} DT',
                                style: TextStyle(
                                  fontFamily: 'Raleway',
                                  fontSize: 25,
                                  color: const Color(0xff000000),
                                  fontWeight: FontWeight.w400,
                                  height: 2,
                                ),
                                textHeightBehavior: TextHeightBehavior(
                                    applyHeightToFirstAscent: false),
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                'Delivery cost 7 DT ',
                                style: TextStyle(
                                  fontFamily: 'Raleway',
                                  fontSize: 12,
                                  color: const Color(0xff7e7e7e),
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            //do something
                          },
                          child: SizedBox(
                            width: 270,
                            height: 70,
                            child:
                                Image.asset("assets/images/check_out_btn.png"),
                          ),
                        ),
                        ButtonWidget(
                          loadedDish: loadedBoxDish,
                          quantity: _quantity,
                          onQuantityChangeAdd: () {
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ButtonWidget extends StatelessWidget {
  ButtonWidget({
    Key key,
    @required this.onQuantityChangeAdd,
    @required this.loadedDish,
    @required int quantity,
  })  : _quantity = quantity,
        super(key: key);

  final Dish loadedDish;
  final int _quantity;
  VoidCallback onQuantityChangeAdd;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Scaffold.of(context).hideCurrentSnackBar();
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Added Item to  cart!'),
          duration: Duration(seconds: 2),
          action: SnackBarAction(
            label: 'UNDO',
            onPressed: () {
              // do something
            },
          ),
        ));

        final savedDish = new Dish(
          description: loadedDish.description,
          id: loadedDish.id + DateTime.now().toString(),
          image: loadedDish.image,
          name: loadedDish.name,
          price: loadedDish.price,
          quantity: _quantity,
          rate: loadedDish.rate,
          total: loadedDish.total,
        );

        savedDish.includes = new List();

        loadedDish.includes.forEach((element) {
          Includes includes = new Includes(
            id: element.id + DateTime.now().toString(),
            image: element.image,
            name: element.name,
            price: element.price,
            quantity: element.quantity,
          );

          savedDish.includes.add(includes);
        });

        Provider.of<DishProvider>(context, listen: false)
            .addPackedDishes(savedDish);

        onQuantityChangeAdd();
      },
      child: SizedBox(
        width: 50,
        height: 50,
        child: Image.asset("assets/images/sac_btn.png"),
      ),
    );
  }
}
