import 'package:dar_sllah/classes/dish.dart';
import 'package:dar_sllah/providers/dish_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BagCardWidget extends StatefulWidget {
  String id;
  String image;
  String name;
  double total;
  int quantity;

  BagCardWidget({
    @required this.id,
    @required this.image,
    @required this.name,
    @required this.total,
    @required this.quantity,
  });

  @override
  _BagCardWidgetState createState() => _BagCardWidgetState();
}

class _BagCardWidgetState extends State<BagCardWidget> {
  Dish loadedPackedDish;
  bool isEmpty = true;

  @override
  void initState() {
    loadedPackedDish = Provider.of<DishProvider>(context, listen: false)
        .packedFindById(widget.id);

    loadedPackedDish.includes.forEach((element) {
      if (element.quantity > 0) {
        isEmpty = false;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final heigthDialogList = 20 * loadedPackedDish.includes.length;

    return GestureDetector(
      onTap: () {
        // show the dialog
        showDialog(
          context: context,
          builder: (BuildContext alertContext) {
            return AlertDialog(
              title: Center(child: Text("${widget.name}")),
              content: Container(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("name"),
                          Text("${widget.name}"),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Quantity"),
                          Text("${widget.quantity}"),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Price"),
                          Text(
                              "${loadedPackedDish.price.toStringAsFixed(2)} DT"),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Divider(
                        color: Colors.black,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      isEmpty
                          ? SizedBox()
                          : Center(
                              child: Text(
                                "Includes",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                      isEmpty
                          ? SizedBox()
                          : SizedBox(
                              height: 10,
                            ),
                      isEmpty
                          ? SizedBox()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Name"),
                                Text("Quantity"),
                                Text("Price"),
                              ],
                            ),
                      isEmpty
                          ? SizedBox()
                          : Divider(
                              color: Colors.black,
                            ),
                      isEmpty
                          ? SizedBox()
                          : Container(
                              width: MediaQuery.of(alertContext).size.width,
                              height: double.parse(heigthDialogList.toString()),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (ctx, index) {
                                  return loadedPackedDish
                                              .includes[index].quantity ==
                                          0
                                      ? SizedBox()
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                "${loadedPackedDish.includes[index].name}"),
                                            Text(
                                                "${loadedPackedDish.includes[index].quantity}"),
                                            Text(
                                                "${loadedPackedDish.includes[index].price.toStringAsFixed(2)}"),
                                          ],
                                        );
                                },
                                itemCount: loadedPackedDish.includes.length,
                              ),
                            ),
                      isEmpty
                          ? SizedBox()
                          : Divider(
                              color: Colors.black,
                            ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total'),
                          Text(
                              '${loadedPackedDish.total.toStringAsFixed(2)} DT'),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              actions: [
                FlatButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.of(alertContext).pop();
                  },
                ),
              ],
            );
            ;
          },
        );
      },
      child: Dismissible(
        key: ValueKey(widget.id),
        direction: DismissDirection.up,
        confirmDismiss: (direction) {
          return showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                    title: Text('Are you sure?'),
                    content:
                        Text('Do you want to remove the item from the cart?'),
                    actions: [
                      FlatButton(
                          onPressed: () {
                            Navigator.of(ctx).pop(false);
                          },
                          child: Text('No')),
                      FlatButton(
                          onPressed: () {
                            Navigator.of(ctx).pop(true);
                          },
                          child: Text('Yes'))
                    ],
                  ));
        },
        onDismissed: (direction) {
          //delete here

          Provider.of<DishProvider>(context, listen: false)
              .deletePackedDishes(widget.id);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  SizedBox(
                    width: 200,
                    height: 300, //change this
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 60,
                      ),
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        color: Colors.white,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 100, // change this
                            ),
                            Container(
                              width: 100,
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                '${widget.name}',
                                style: TextStyle(
                                  fontFamily: 'Open Sans',
                                  fontSize: 15,
                                  color: const Color(0xff000000),
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 0),
                              child: Text(
                                '${widget.total.toStringAsFixed(2)} DT',
                                style: TextStyle(
                                  fontFamily: 'Raleway',
                                  fontSize: 15,
                                  color: const Color(0xff000000),
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                MaterialButton(
                                  height: 20,
                                  minWidth: 20,
                                  onPressed: () {
                                    if (widget.quantity > 0) {
                                      setState(() {
                                        loadedPackedDish.quantity--;
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
                                  '${loadedPackedDish.quantity}',
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
                                      loadedPackedDish.quantity++;
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
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(100),
                      ),
                    ),
                    width: 150,
                    height: 150,
                    child: Image.network("${widget.image}"),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                return showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                          title: Text('Are you sure?'),
                          content: Text(
                              'Do you want to remove the item from the cart?'),
                          actions: [
                            FlatButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop(false);
                                },
                                child: Text('No')),
                            FlatButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop(true);

                                  Provider.of<DishProvider>(context,
                                          listen: false)
                                      .packedDishes
                                      .forEach((element) {
                                    print("ddddddddd    ${element.id}");
                                  });

                                  print("key   ${widget.id}");
                                  Provider.of<DishProvider>(context,
                                          listen: false)
                                      .deletePackedDishes(widget.id);
                                  setState(() {});
                                },
                                child: Text('Yes'))
                          ],
                        ));
              },
              child: Container(
                padding: EdgeInsets.only(top: 10),
                width: 50,
                height: 50,
                child: Image.asset("assets/images/delete_btn.png"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
