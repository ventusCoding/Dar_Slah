import 'package:dar_sllah/classes/about_card_class.dart';
import 'package:dar_sllah/classes/comment.dart';
import 'package:dar_sllah/classes/dish.dart';
import 'package:dar_sllah/classes/includes.dart';
import 'package:dar_sllah/providers/comment_provider.dart';
import 'package:dar_sllah/providers/dish_provider.dart';
import 'package:dar_sllah/screens/Home%20Main/home_main_screen.dart';
import 'package:dar_sllah/screens/box/box_mer/box_mer_detailed.dart';
import 'package:dar_sllah/widgets/Shop/include_card_widget.dart';
import 'package:dar_sllah/widgets/Shop/review_card_widget.dart';
import 'package:dar_sllah/widgets/about_card_widget.dart';
import 'package:dar_sllah/widgets/dialogs/add_comment_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../../main.dart';

class DetailedShopScreen extends StatefulWidget {
  static String routeName = "DetailedShopScreen";

  @override
  _DetailedShopScreenState createState() => _DetailedShopScreenState();
}

class _DetailedShopScreenState extends State<DetailedShopScreen> {
  int _quantity = 1;
  String path;
  var commentBool = false;
  Future func;

  CommentProvider commentsData;
  List<Comment> comments;

  Future<void> _refreshComments(BuildContext context) async {
    await Provider.of<CommentProvider>(context, listen: false)
        .fetchData(
            path: path,
            dishId: Provider.of<DishProvider>(context, listen: false)
                .getIdSelected())
        .whenComplete(() {
      commentBool = false;
      comments = commentsData.comments;
    });
  }

  @override
  void initState() {
    print('this is the init state');

    path = Provider.of<DishProvider>(context, listen: false).getPath();

    commentsData = Provider.of<CommentProvider>(context, listen: false);

    Provider.of<DishProvider>(context, listen: false).dishes.forEach((element) {
      element.total = element.price;
    });

    func = _refreshComments(context);
    super.initState();
  }

  final List<AboutCardClass> aboutList = [
    AboutCardClass("assets/images/moto_icon.png", "Home delivery",
        "We Deliver the best quality food at your doorsteps\nfor 7DT extra cost for each delivery past 60 DT"),
    AboutCardClass("assets/images/vegetable_icon.png", "Fresh Fodd",
        "Sadri goes to the Central Market of Tunis to select\nthe best products, the freshest, the seasonal"),
    AboutCardClass("assets/images/bag_food_icon.png", "48H Of Resistance ",
        "with our special packaging, you can save the food\nin your fridge for 48 hours and find as it is"),
  ];

  @override
  Widget build(BuildContext context) {
    final dishId = ModalRoute.of(context).settings.arguments as String;

    final loadedDish =
        Provider.of<DishProvider>(context, listen: false).findById(dishId);

    if (Provider.of<CommentProvider>(context, listen: false).newRating !=
        null) {
      loadedDish.rate =
          Provider.of<CommentProvider>(context, listen: false).newRating;

      Provider.of<CommentProvider>(context, listen: false).newRating = null;
    }

    final Size size = MediaQuery.of(context).size;

    final path = Provider.of<DishProvider>(context, listen: false).getPath();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  RaisedButton.icon(
                    elevation: 0,
                    onPressed: () {
                      Navigator.of(context).pop();
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
                ],
              ),
              Container(
                width: size.width,
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.only(top: size.width * 0.15),
                child: Stack(
                  children: [
                    Container(
                      width: size.width * 0.66,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${loadedDish.name}",
                            style: TextStyle(fontSize: 32),
                          ),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  RatingBarIndicator(
                                    itemBuilder: (context, index) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    rating: loadedDish.rate,
                                    itemCount: 5,
                                    itemSize: size.width * 0.05,
                                    unratedColor: Colors.amber.withAlpha(50),
                                  ),
                                  Text(
                                    '1200 review',
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.grey),
                                  )
                                ],
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
                                                child: AddCommentDialogWidget(
                                                    id: loadedDish.id,
                                                    path: path,
                                                    onAddComment: () {
                                                      setState(() {
                                                        commentBool = true;
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
                                    '${loadedDish.rate}',
                                    style: TextStyle(fontSize: 10),
                                  )
                                ],
                              )
                            ],
                          ),
                          Text(
                            '${loadedDish.price.toStringAsFixed(2)} DT',
                            style: TextStyle(
                                fontSize: size.width * 0.075,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 16, bottom: 16),
                              child: Text(
                                'Delivery costs 7 DT',
                                style: TextStyle(
                                    fontSize: size.width * 0.02,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500),
                              )),
                          Row(
                            children: [
                              MaterialButton(
                                height: 20,
                                minWidth: 20,
                                onPressed: () {
                                  if (_quantity > 1) {
                                    setState(() {
                                      _quantity--;
                                      loadedDish.total -= loadedDish.price;
                                    });
                                  }
                                },
                                color: Colors.white,
                                textColor: Colors.black,
                                child: Icon(
                                  Icons.remove,
                                ),
                                padding: EdgeInsets.all(8),
                                shape: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.yellow,
                                      width: 1,
                                      style: BorderStyle.solid),
                                  borderRadius: new BorderRadius.circular(5.0),
                                ),
                              ),
                              Container(
                                  margin: EdgeInsets.only(left: 16, right: 16),
                                  child: Text(
                                    '$_quantity',
                                    style: TextStyle(
                                        fontSize: size.width * 0.05,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  )),
                              MaterialButton(
                                height: 20,
                                minWidth: 20,
                                onPressed: () {
                                  setState(() {
                                    _quantity++;
                                    loadedDish.total += loadedDish.price;
                                  });
                                },
                                color: Colors.white,
                                textColor: Colors.black,
                                child: Icon(
                                  Icons.add,
                                ),
                                padding: EdgeInsets.all(8),
                                shape: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.yellow,
                                      width: 1,
                                      style: BorderStyle.solid),
                                  borderRadius: new BorderRadius.circular(5.0),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                        width: size.width * 0.75,
                        height: size.width * 0.75,
                        child: Transform.translate(
                            offset: Offset(size.width / 1.75, 0),
                            child: Image.network("${loadedDish.image}")))
                  ],
                ),
              ),
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
                    '${loadedDish.description}',
                    style: TextStyle(
                        fontSize: size.width * 0.033,
                        color: Colors.grey,
                        height: 3),
                  )),
              loadedDish.includes.length == 0
                  ? SizedBox()
                  : Container(
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.only(top: 16),
                      child: Text(
                        'Includes',
                        style: TextStyle(fontSize: size.width * 0.05),
                      )),
              loadedDish.includes.length == 0
                  ? SizedBox()
                  : GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: loadedDish.includes.length,
                      itemBuilder: (_, index) {
                        return IncludesCard(
                          dishId: loadedDish.id,
                          id: loadedDish.includes[index].id,
                          name: loadedDish.includes[index].name,
                          price: loadedDish.includes[index].price,
                          image: loadedDish.includes[index].image,
                          onQuantityChangeAdd: () {
                            loadedDish.total +=
                                loadedDish.includes[index].price;
                            setState(() {});
                          },
                          onQuantityChangeSub: () {
                            loadedDish.total -=
                                loadedDish.includes[index].price;
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
              SizedBox(
                height: 40,
              ),
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
                                '${loadedDish.total.toStringAsFixed(2)} DT',
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
                            print(Provider.of<DishProvider>(context,
                                    listen: false)
                                .findById(dishId)
                                .name);
                            print(Provider.of<DishProvider>(context,
                                    listen: false)
                                .findById(dishId)
                                .includes[0]
                                .name);
                            print(Provider.of<DishProvider>(context,
                                    listen: false)
                                .findById(dishId)
                                .includes[0]
                                .quantity);
                            print(Provider.of<DishProvider>(context,
                                    listen: false)
                                .findById(dishId)
                                .includes[1]
                                .name);
                            print(Provider.of<DishProvider>(context,
                                    listen: false)
                                .findById(dishId)
                                .includes[1]
                                .quantity);
                          },
                          child: SizedBox(
                            width: 270,
                            height: 70,
                            child:
                                Image.asset("assets/images/check_out_btn.png"),
                          ),
                        ),
                        ButtonWidget(
                            loadedDish: loadedDish, quantity: _quantity),
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
  const ButtonWidget({
    Key key,
    @required this.loadedDish,
    @required int quantity,
  })  : _quantity = quantity,
        super(key: key);

  final Dish loadedDish;
  final int _quantity;

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
      },
      child: SizedBox(
        width: 50,
        height: 50,
        child: Image.asset("assets/images/sac_btn.png"),
      ),
    );
  }
}
