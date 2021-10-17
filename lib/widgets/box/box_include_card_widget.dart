import 'package:dar_sllah/providers/box_dish_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BoxIncludesCard extends StatefulWidget {
  String dishId;
  String id;
  String name;
  String image;
  double price;
  int quantity;
  VoidCallback onQuantityChangeAdd;
  VoidCallback onQuantityChangeSub;

  BoxIncludesCard({
    @required this.dishId,
    @required this.id,
    @required this.name,
    @required this.image,
    @required this.price,
    this.quantity,
    @required this.onQuantityChangeAdd,
    @required this.onQuantityChangeSub,
  });

  @override
  _BoxIncludesCardState createState() => _BoxIncludesCardState();
}

class _BoxIncludesCardState extends State<BoxIncludesCard> {
  int _quantity = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            width: 125, height: 125, child: Image.network("${widget.image}")),
        Text('${widget.name}'),
        Text(
          '${widget.price}',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 24, color: Colors.green),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            MaterialButton(
              height: 20,
              minWidth: 20,
              onPressed: () {
                if (_quantity > 0) {
                  setState(() {
                    _quantity--;
                    Provider.of<BoxDishProvider>(context, listen: false)
                        .findById(widget.dishId)
                        .includes
                        .firstWhere((element) => element.id == widget.id)
                        .quantity = _quantity;
                        widget.onQuantityChangeSub();
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
                    color: Colors.yellow, width: 1, style: BorderStyle.solid),
                borderRadius: new BorderRadius.circular(5.0),
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
                  Provider.of<BoxDishProvider>(context, listen: false)
                      .findById(widget.dishId)
                      .includes
                      .firstWhere((element) => element.id == widget.id)
                      .quantity = _quantity;
                      widget.onQuantityChangeAdd();
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
                    color: Colors.yellow, width: 1, style: BorderStyle.solid),
                borderRadius: new BorderRadius.circular(5.0),
              ),
            )
          ],
        )
      ],
    );
  }
}
