import 'package:amazon_clone/MODELS/review_model.dart';
import 'package:amazon_clone/providers/user_details_provider.dart';
import 'package:amazon_clone/resources/fireStore_class.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rating_dialog/rating_dialog.dart';

class ReviewDialogue extends StatelessWidget {
  final String productUid;
  const ReviewDialogue({Key? key, required this.productUid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RatingDialog(
      // your app's name?
      title: const Text(
        'Type Review',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      // encourage your user to leave a high rating?

      // your app's logo?

      submitButtonText: 'Send Review',
      commentHint: 'Type Review Here',

      onSubmitted: (RatingDialogResponse response) async {
        CloudFireStoreClass().uploadReviewToDatabase(
            productUid: productUid,
            model:ReviewModel(
              senderName:  Provider.of<UserDetailsProvider>(context, listen: false)
                .userDetails!.name, 
                description:response.comment , 
                rating: response.rating.toInt()),
                
                );
      },
    );
  }
}
