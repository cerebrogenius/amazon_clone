import 'package:amazon_clone/utils/color_themes.dart';
import 'package:amazon_clone/widgets/cost_widget.dart';
import 'package:flutter/material.dart';

import '../utils/utils.dart';

class ProductInfo extends StatelessWidget {
  final String productName;
  final double cost;
  final String sellerName;
  const ProductInfo(
      {Key? key,
      required this.productName,
      required this.cost,
      required this.sellerName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizedBox space =const SizedBox(height: 7,);
    Size screenSize = Utils().getScreenSize();
    return SizedBox(
        width: screenSize.width / 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                productName,
                maxLines: 2,
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    letterSpacing: 0.9,
                    overflow: TextOverflow.ellipsis),
              ),
            ),
            space,
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 7.0),
                child: CostWidget(color: Colors.black, cost: cost),
              ),
            ),
            space,
            Align(
              alignment: Alignment.centerLeft,
              child: RichText(
                  text: TextSpan(children: [
                TextSpan(
                  text: 'Sold By ',
                  style: TextStyle(color: Colors.grey[700], fontSize: 14),
                ),
                TextSpan(
                  text: sellerName,
                  style: const TextStyle(color: activeCyanColor, fontSize: 14),
                )
              ])),
            )
          ],
        ));
  }
}
