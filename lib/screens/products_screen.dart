import 'package:amazon_clone/MODELS/product_model.dart';
import 'package:amazon_clone/MODELS/review_model.dart';
import 'package:amazon_clone/providers/review_model_provider.dart';
import 'package:amazon_clone/resources/fireStore_class.dart';
import 'package:amazon_clone/utils/color_themes.dart';
import 'package:amazon_clone/utils/constants.dart';
import 'package:amazon_clone/widgets/Custom_simple_button.dart';
import 'package:amazon_clone/widgets/cost_widget.dart';
import 'package:amazon_clone/widgets/custom_main_botton.dart';
import 'package:amazon_clone/widgets/rating_star_widget.dart';
import 'package:amazon_clone/widgets/review_dialogue.dart';
import 'package:amazon_clone/widgets/review_widget.dart';
import 'package:amazon_clone/widgets/search_bar.dart';
import 'package:amazon_clone/widgets/user_detailsBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../MODELS/user_details_model.dart';
import '../providers/user_details_provider.dart';
import '../utils/utils.dart';

class ProductScreen extends StatefulWidget {
  final ProductModel productModel;
  const ProductScreen({Key? key, required this.productModel}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  Expanded spaceBox = Expanded(
    child: Container(
      height: 10,
    ),
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ReviewModelProvider>(context,listen: false).updateReview();
  }
  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    
    UserDetailsModel? userDetails =
        Provider.of<UserDetailsProvider>(context).userDetails;
    return SafeArea(
      child: Scaffold(
        appBar: SearchBar(isReadOnly: true, hasBackButton: true),
        body: SingleChildScrollView(
          child: SizedBox(
            height: screenSize.height + screenSize.height,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: screenSize.height + screenSize.height,
                        child:
                            Column(mainAxisSize: MainAxisSize.min, children: [
                          const SizedBox(
                            height: kAppBarHeight / 2,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 5.0),
                                      child: Text(
                                        widget.productModel.sellerName,
                                        style: const TextStyle(
                                            color: activeCyanColor,
                                            fontSize: 16),
                                      ),
                                    ),
                                    Text(
                                      widget.productModel.productName,
                                      style: const TextStyle(),
                                    )
                                  ],
                                ),
                                RatingStarWidget(
                                      rating: Provider.of<ReviewModelProvider>(
                                              context,listen: false)
                                          .reviewModel!
                                          .rating),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Container(
                              height: screenSize.height / 3,
                              constraints: BoxConstraints(
                                maxHeight: screenSize.height / 3,
                              ),
                              child: Image.network(widget.productModel.url),
                            ),
                          ),
                          spaceBox,
                          CostWidget(
                              color: Colors.black,
                              cost: widget.productModel.cost),
                          spaceBox,
                          CustomMainBotton(
                            color: Colors.orange,
                            isLoading: false,
                            onPressed: () async {
                              await CloudFireStoreClass().addProductToOrders(
                                  userDetailsModel:
                                      Provider.of<UserDetailsProvider>(context,
                                                  listen: false)
                                              .userDetails ??
                                          UserDetailsModel(
                                              name: "loading",
                                              address: "loading"),
                                  model: widget.productModel);
                              Utils().showSnackBar(
                                  context: context, content: "Done");
                            },
                            child: const Text(
                              'buy now',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          spaceBox,
                          CustomMainBotton(
                            color: yellowColor,
                            isLoading: false,
                            onPressed: () async {
                              await CloudFireStoreClass()
                                  .addModelToCart(model: widget.productModel);
                              Utils().showSnackBar(
                                  context: context, content: "Added to cart");
                            },
                            child: const Text(
                              'Add To Cart',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          spaceBox,
                          CustomSimpleButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: ((context) => ReviewDialogue(
                                          productUid: widget.productModel.uid,
                                        )));
                                Provider.of<ReviewModelProvider>(context)
                                    .updateReview();
                              },
                              text: 'add a review'),
                          Container(
                              height: screenSize.height,
                              child: StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection("products")
                                    .doc(widget.productModel.uid)
                                    .collection("reviews")
                                    .snapshots(),
                                builder: (context,
                                    AsyncSnapshot<
                                            QuerySnapshot<Map<String, dynamic>>>
                                        snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Container();
                                  } else {
                                    return ListView.builder(
                                        itemCount: snapshot.data!.docs.length,
                                        itemBuilder: (context, index) {
                                          ReviewModel model =
                                              ReviewModel.getModelFromJson(
                                                  json: snapshot
                                                      .data!.docs[index]
                                                      .data());
                                          return ReviewWidget(review: model);
                                        });
                                  }
                                },
                              )),
                        ]),
                      )
                    ],
                  ),
                ),
                UserDetailsBar(
                  offset: 0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
