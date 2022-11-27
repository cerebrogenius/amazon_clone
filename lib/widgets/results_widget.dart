import 'package:amazon_clone/MODELS/product_model.dart';
import 'package:amazon_clone/screens/products_screen.dart';
import 'package:amazon_clone/utils/color_themes.dart';
import 'package:amazon_clone/widgets/cost_widget.dart';
import 'package:flutter/material.dart';

import '../utils/utils.dart';
import 'rating_star_widget.dart';

class ResultsWidget extends StatelessWidget {
  final ProductModel product;
  const ResultsWidget({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ProductScreen(productModel: product);
        }));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: screenSize.width / 3,
              child: Image.network(product.url),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Expanded(
                child: Text(
                  product.productName,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                children: [
                  SizedBox(
                    width: screenSize.width / 5,
                    child: FittedBox(
                      child: RatingStarWidget(
                        rating: product.rating,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      product.noOfRating.toString(),
                      style: const TextStyle(color: activeCyanColor),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
                height: 20,
                child: FittedBox(
                    child: CostWidget(
                  color: Color.fromARGB(255, 92, 3, 3),
                  cost: product.cost,
                ))),
          ],
        ),
      ),
    );
  }
}
