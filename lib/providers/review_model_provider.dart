import 'package:amazon_clone/MODELS/review_model.dart';
import 'package:amazon_clone/resources/fireStore_class.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class ReviewModelProvider extends ChangeNotifier {
  ReviewModel? reviewModel;

  ReviewModelProvider();
  updateReview() {
    CloudFireStoreClass().changeAverageRating(
        productUid: FirebaseFirestore.instance.collection("products").id,
        reviewModel: reviewModel ??
            ReviewModel(
                senderName: "loading", description: "loading", rating: 0));
    notifyListeners();
  }
}
