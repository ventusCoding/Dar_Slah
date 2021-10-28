import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CustomerReviewComment extends StatelessWidget {
  String id;
  String description;
  String image;
  String name;
  double rate;

  CustomerReviewComment({
    @required this.id,
    @required this.description,
    @required this.image,
    @required this.name,
    @required this.rate,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100.0),
            child: Image.network("$image",
                height: MediaQuery.of(context).size.height / 7.5, width: MediaQuery.of(context).size.height / 7.5, fit: BoxFit.cover),
          ),
        ),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text('$name',style: TextStyle(fontSize: MediaQuery.of(context).size.height / 53),),
                RatingBarIndicator(
                  itemBuilder: (context, index) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  rating: rate,
                  itemCount: 5,
                  itemSize: 12.5,
                  unratedColor: Colors.amber.withAlpha(50),
                ),
              ],
            ),
            Text(
              '$description',
              style: TextStyle(fontSize: MediaQuery.of(context).size.height / 53,height: 2, color: Colors.grey),
            )
          ],
        ))
      ],
    );
  }
}
