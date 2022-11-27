import 'package:amazon_clone/utils/constants.dart';
import 'package:amazon_clone/widgets/rating_star_widget.dart';
import 'package:flutter/material.dart';

import '../MODELS/review_model.dart';
import '../utils/utils.dart';

class ReviewWidget extends StatelessWidget {
  final ReviewModel review;
  const ReviewWidget({Key? key, required this.review}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            review.senderName,
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical:10.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right:10.0),
                  child: SizedBox(width: screenSize.width/4,
                  child: FittedBox(
                    child: RatingStarWidget(
                      rating: review.rating),
                  ),
                  ),
                ),
                Text(keyOfRating[review.rating-1])
              ],
            ),
          ),
          Text(review.description,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
