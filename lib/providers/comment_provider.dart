import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dar_sllah/classes/comment.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommentProvider with ChangeNotifier {
  List<Comment> _comments = [];
  String description;
  double newRating;

  List<Comment> get comments {
    return [..._comments];
  }

  Future<void> fetchData({
    @required String path,
    @required String dishId,
  }) async {
    _comments.clear();

    final List<Comment> userComments = [];

    try {
      await FirebaseFirestore.instance
          .collection('$path/$dishId/comment')
          .get()
          .then((snapshot) => snapshot.docs.forEach((element) async {
                userComments.add(Comment(
                  id: element['id'],
                  description: element['description'],
                  image: element['image'],
                  name: element['name'],
                  rate: element['rate'],
                ));
              }));
      _comments = userComments;
      notifyListeners();
    } catch (Exeption) {}
  }

  Future<void> addComment(
      String dishId, String path, String description, double rate) async {
    final auth = await FirebaseAuth.instance.currentUser;
    double newRate = 0;
    int counter = 0;

    final img = auth.photoURL;
    final id = auth.uid;
    final name = auth.displayName;

    final comment = new Comment(
      description: description,
      id: id,
      image: img,
      name: name,
      rate: rate,
    );

    print("link  $path/$dishId");

    try {
      FirebaseFirestore.instance
          .collection('$path/$dishId/comment')
          .doc(id)
          .set({
        'id': comment.id,
        'description': comment.description,
        'image': comment.image,
        'name': comment.name,
        'rate': comment.rate,
      });

      await FirebaseFirestore.instance
          .collection('$path/$dishId/comment')
          .get()
          .then((snapshot) => snapshot.docs.forEach((element) async {
                newRate += double.parse(element['rate'].toString());
                counter++;
              }))
          .whenComplete(() {
        newRate /= counter;
        print("new Rateeee $newRate");

        FirebaseFirestore.instance.doc('$path/$dishId').update({
          'rate': newRate,
        });
        newRating = newRate;
        notifyListeners();
      });
    } catch (error) {
      print("error : $error");
      throw (error);
    }
  }

  void setDescription(String descriptionText) {
    description = descriptionText;
  }

  String getDescription() {
    return description;
  }
}
