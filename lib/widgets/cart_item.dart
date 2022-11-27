import 'package:amazon_clone/MODELS/product_model.dart';
import 'package:amazon_clone/resources/fireStore_class.dart';
import 'package:amazon_clone/screens/products_screen.dart';
import 'package:amazon_clone/utils/color_themes.dart';
import 'package:amazon_clone/widgets/Custom_simple_button.dart';
import 'package:amazon_clone/widgets/increment_button.dart';
import 'package:amazon_clone/widgets/product_info.dart';
import 'package:flutter/material.dart';

import '../screens/results_screen.dart';
import '../utils/constants.dart';
import '../utils/utils.dart';

class CardItem extends StatelessWidget {
  final ProductModel product;
  const CardItem({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return Container(
      padding: const EdgeInsets.all(25),
      height: screenSize.height / 2,
      width: screenSize.width,
      decoration: const BoxDecoration(
          color: backgroundColor,
          border: Border(bottom: BorderSide(color: Colors.grey, width: 1))),
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ProductScreen(
                    productModel: product,
                   
                    );
                }));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: screenSize.width / 3,
                    child: Align(
                        alignment: Alignment.topCenter,
                        child: Center(child: Image.network(product.url))),
                  ),
                  ProductInfo(
                      productName: product.productName,
                      cost: product.cost,
                      sellerName: product.sellerName)
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                CustomIncrementButton(
                  onPressed: () {},
                  color: backgroundColor,
                  dimension: 40,
                  child: const Icon(Icons.remove),
                ),
                CustomIncrementButton(
                  onPressed: () {},
                  color: Colors.grey[200],
                  dimension: 40,
                  child: const Center(
                    child: Text(
                      '0',
                      style: TextStyle(color: activeCyanColor),
                    ),
                  ),
                ),
                CustomIncrementButton(
                  onPressed: () {},
                  color: backgroundColor,
                  dimension: 40,
                  child: const Icon(Icons.add),
                )
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      CustomSimpleButton(
                          onPressed: () async {
                            CloudFireStoreClass()
                                .deleteProductFromCart(uid: product.uid);
                          },
                          text: 'Delete'),
                      const SizedBox(
                        width: 5,
                      ),
                      CustomSimpleButton(
                          onPressed: () {}, text: 'Save For Later')
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 5.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'See More Like This',
                        style: TextStyle(color: activeCyanColor),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
