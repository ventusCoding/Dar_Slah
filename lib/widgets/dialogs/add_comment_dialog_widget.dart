import 'package:dar_sllah/providers/comment_provider.dart';
import 'package:dar_sllah/providers/dish_provider.dart';
import 'package:dar_sllah/screens/Shop/shop_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rating_bar/rating_bar.dart';

import '../../main.dart';

class AddCommentDialogWidget extends StatefulWidget {
  double _rating = 0;
  String id;
  String path;
  VoidCallback onAddComment;

  AddCommentDialogWidget({
    @required this.id,
    @required this.path,
    @required this.onAddComment,
  });

  @override
  _AddCommentDialogWidgetState createState() => _AddCommentDialogWidgetState();
}

class _AddCommentDialogWidgetState extends State<AddCommentDialogWidget> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final _descriptionController = TextEditingController();

    if (_descriptionController.text.length == 0) {
      _descriptionController.text =
          Provider.of<CommentProvider>(context, listen: false).getDescription();
      _descriptionController.selection =
          TextSelection.collapsed(offset: _descriptionController.text.length);
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
            Provider.of<CommentProvider>(context, listen: false)
                .setDescription('');
          },
          child: Container(
            margin: EdgeInsets.only(right: 20, top: 20),
            alignment: Alignment.centerRight,
            child: Image.asset("assets/images/close.png"),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0, 1.0), //(x,y)
                blurRadius: 5.0,
                spreadRadius: -2,
              ),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              10,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: TextField(
              keyboardType: TextInputType.text,
              maxLines: null,
              controller: _descriptionController,
              maxLength: 50,
              decoration: InputDecoration(
                hintText: "Description",
                icon: Icon(
                  Icons.edit,
                ),
                border: InputBorder.none,
              ),
              onChanged: (value) {
                Provider.of<CommentProvider>(context, listen: false)
                    .setDescription(value);
              },
            ),
          ),
        ),
        RatingBar(
          onRatingChanged: (rating) {
            setState(() => widget._rating = rating.toDouble());
          },
          filledIcon: Icons.star,
          emptyIcon: Icons.star_border,
          halfFilledIcon: Icons.star_half,
          isHalfAllowed: true,
          filledColor: Theme.of(context).primaryColor,
          emptyColor: Theme.of(context).primaryColor,
          halfFilledColor: Theme.of(context).primaryColor,
          size: size.width * 0.08,
        ),
        Container(
          margin: EdgeInsets.only(
            bottom: 10,
          ),
          child: TextButton(
            onPressed: () {
              if (widget._rating == null) {
                return;
              }

              Provider.of<CommentProvider>(context, listen: false).addComment(
                widget.id,
                widget.path,
                _descriptionController.text,
                widget._rating,
              );
              Provider.of<CommentProvider>(context, listen: false)
                  .setDescription('');

              Navigator.of(context).pop();

              widget.onAddComment();

            },
            child: Text(
              'Add Your Rate',
              style: TextStyle(
                fontFamily: 'Raleway',
                fontSize: 20,
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.left,
            ),
          ),
        )
      ],
    );
  }
}
