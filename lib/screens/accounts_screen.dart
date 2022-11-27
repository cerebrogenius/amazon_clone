

import 'package:amazon_clone/MODELS/product_model.dart';
import 'package:amazon_clone/MODELS/request.dart';
import 'package:amazon_clone/resources/fireStore_class.dart';
import 'package:amazon_clone/screens/sell_screen.dart';
import 'package:amazon_clone/screens/signIn_screens.dart';
import 'package:amazon_clone/utils/constants.dart';
import 'package:amazon_clone/utils/utils.dart';
import 'package:amazon_clone/widgets/accounts_screen_appBar.dart';
import 'package:amazon_clone/widgets/custom_main_botton.dart';
import 'package:amazon_clone/widgets/products_listview.dart';
import 'package:amazon_clone/widgets/simple_product_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../providers/user_details_provider.dart';
import '../utils/color_themes.dart';

class AccountsScreen extends StatefulWidget {
  const AccountsScreen({Key? key}) : super(key: key);

  @override
  State<AccountsScreen> createState() => _AccountsScreenState();
}

class _AccountsScreenState extends State<AccountsScreen> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AccountScreenAppBar(),
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenSize.height - (kAppBarHeight / 2),
          width: screenSize.width,
          child: Column(
            children: [
              const AboutOwner(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomMainBotton(
                    color: Colors.orange,
                    isLoading: false,
                    onPressed: () {
                      CloudFireStoreClass().signOutUser();
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return const SignInScreen();
                      }));
                    },
                    child: const Text(
                      'Sign Out',
                      style: TextStyle(color: Colors.black),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomMainBotton(
                    color: Colors.orange,
                    isLoading: false,
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const SellScreen();
                      }));
                    },
                    child: const Text(
                      'Sell',
                      style: TextStyle(color: Colors.black),
                    )),
              ),
              FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection("users")
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection("orders")
                      .get(),
                  builder: (context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container();
                    } else {
                      List<Widget> children = [];
                      for (int i = 0; i < snapshot.data!.docs.length; i++) {
                        ProductModel model = ProductModel.getModelFromJson(
                            json: snapshot.data!.docs[i].data());
                        children.add(SimpleProductWidget(productModel: model));
                      }
                      return ProductsListView(
                          title: "Your Orders", children: children);
                    }
                  }),
              const Padding(
                padding: EdgeInsets.all(15.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Order Requests',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    )),
              ),
              Expanded(
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("users")
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .collection("requests")
                          .snapshots(),
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                              snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Container();
                        } else {
                          return ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                OrderRequestModel model =
                                    OrderRequestModel.getModelFromJson(
                                        json:
                                            snapshot.data!.docs[index].data());
                                return ListTile(
                                    title: Text("order: ${model.orderName}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500)),
                                    subtitle:
                                        Text("Address: ${model.buyerAddress}"),
                                    trailing: IconButton(
                                      icon: const Icon(Icons.check),
                                      onPressed: () {
                                        FirebaseFirestore.instance
                                            .collection("users")
                                            .doc(FirebaseAuth
                                                .instance.currentUser!.uid)
                                            .collection("orderRequests")
                                            .doc(snapshot.data!.docs[index].id)
                                            .delete();
                                      },
                                    ));
                              });
                        }
                      }))
            ],
          ),
        ),
      ),
    );
  }
}

class AboutOwner extends StatelessWidget {
  const AboutOwner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String name =
        Provider.of<UserDetailsProvider>(context).userDetails!.name;
    return Container(
      height: kAppBarHeight / 2,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: backgroundGradient,
            begin: Alignment.centerLeft,
            end: Alignment.bottomRight),
      ),
      child: Container(
        height: kAppBarHeight / 2,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.white, Colors.white.withOpacity(0.00000000001)],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Hello,',
                      style: TextStyle(color: Colors.grey[800], fontSize: 26),
                    ),
                    TextSpan(
                      text: name,
                      style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 27,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://m.media-amazon.com/images/I/11uufjN3lYL._SX90_SY90_.png"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
