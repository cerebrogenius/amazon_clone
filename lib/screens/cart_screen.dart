import 'package:amazon_clone/MODELS/product_model.dart';
import 'package:amazon_clone/MODELS/user_details_model.dart';
import 'package:amazon_clone/providers/user_details_provider.dart';
import 'package:amazon_clone/resources/fireStore_class.dart';

import 'package:amazon_clone/utils/color_themes.dart';
import 'package:amazon_clone/utils/utils.dart';

import 'package:amazon_clone/widgets/cart_item.dart';
import 'package:amazon_clone/widgets/custom_main_botton.dart';
import 'package:amazon_clone/widgets/search_bar.dart';
import 'package:amazon_clone/widgets/user_detailsBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: SearchBar(isReadOnly: true, hasBackButton: false),
        body: Column(children: [
          UserDetailsBar(
            position: false,
            offset: 0,
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("users")
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection("cart")
                      .snapshots(),
                  builder: (context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CustomMainBotton(
                          color: yellowColor,
                          isLoading: true,
                          onPressed: () {},
                          child: const Text("loading"));
                    } else {
                      return CustomMainBotton(
                          color: yellowColor,
                          isLoading: false,
                          onPressed: () async {
                            await CloudFireStoreClass().buyAllItemsInCart(
                              userDetailsModel: Provider.of<UserDetailsProvider>(context,listen:false).userDetails??UserDetailsModel(name: "loading", address: "loading")
                            );
                            Utils().showSnackBar(
                                context: context, content: "done");
                          },
                          child: Text(
                              "proceed to buy ${snapshot.data!.docs.length} items"));
                    }
                  })),
          Expanded(
              child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("users")
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection("cart")
                .snapshots(),
            builder: (context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container();
              } else {
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      ProductModel model = ProductModel.getModelFromJson(
                          json: snapshot.data!.docs[index].data() as dynamic);
                      return CardItem(
                        product: model,
                      );
                    });
              }
            },
          ))
        ]),
      ),
    );
  }
}
