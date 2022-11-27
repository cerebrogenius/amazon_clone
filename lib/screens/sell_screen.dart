import 'dart:typed_data';

import 'package:amazon_clone/providers/user_details_provider.dart';
import 'package:amazon_clone/resources/fireStore_class.dart';
import 'package:amazon_clone/utils/color_themes.dart';
import 'package:amazon_clone/widgets/custom_main_botton.dart';
import 'package:amazon_clone/widgets/loading_widget.dart';
import 'package:amazon_clone/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/utils.dart';

class SellScreen extends StatefulWidget {
  const SellScreen({Key? key}) : super(key: key);

  @override
  State<SellScreen> createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController costController = TextEditingController();
  int selected = 1;
  List<int> discountKey = [0, 70, 60, 50];

  bool isLoading = false;

  Uint8List? image;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    costController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    Provider.of<UserDetailsProvider>(context).getData();
    return SafeArea(
        child: Scaffold(
            body: !isLoading
                ? SingleChildScrollView(
                    child: SizedBox(
                      height: screenSize.height,
                      width: screenSize.width,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20.0),
                        child: Center(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Stack(
                                  children: [
                                    image == null
                                        ? Image.network(
                                            'https://media.istockphoto.com/vectors/male-profile-flat-blue-simple-icon-with-long-shadow-vector-id522855255?k=20&m=522855255&s=612x612&w=0&h=fLLvwEbgOmSzk1_jQ0MgDATEVcVOh_kqEe0rqi7aM5A=',
                                            height: screenSize.height / 10,
                                          )
                                        : Stack(
                                            children: [
                                              Image.memory(
                                                image!,
                                                height: screenSize.height / 10,
                                              ),
                                              IconButton(
                                                  onPressed: () async {
                                                    Uint8List? holder =
                                                        await Utils()
                                                            .pickImage();
                                                    if (holder != null) {
                                                      setState(() {
                                                        image = holder;
                                                      });
                                                    }
                                                  },
                                                  icon: const Icon(
                                                      Icons.file_upload))
                                            ],
                                          ),
                                    IconButton(
                                        onPressed: () async {
                                          Uint8List? holder =
                                              await Utils().pickImage();
                                          if (holder != null) {
                                            setState(() {
                                              image = holder;
                                            });
                                          }
                                        },
                                        icon: const Icon(Icons.file_upload))
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 35, vertical: 10),
                                  height: screenSize.height * 0.7,
                                  width: screenSize.width * 0.7,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey, width: 1)),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Item Details",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 24),
                                        ),
                                        TextFieldWidget(
                                            title: "Name",
                                            controller: nameController,
                                            obscureText: false,
                                            hintText: "Enter The Name Of Item"),
                                        TextFieldWidget(
                                            title: "Cost",
                                            controller: costController,
                                            obscureText: false,
                                            hintText: "Enter The Cost Of Item"),
                                        const Text(
                                          "Discount",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17),
                                        ),
                                        ListTile(
                                          title: const Text("None"),
                                          leading: Radio(
                                              value: 1,
                                              groupValue: selected,
                                              onChanged: (int? i) {
                                                setState(() {
                                                  selected = i!;
                                                });
                                              }),
                                        ),
                                        ListTile(
                                          title: const Text("70%"),
                                          leading: Radio(
                                              value: 2,
                                              groupValue: selected,
                                              onChanged: (int? i) {
                                                setState(() {
                                                  selected = i!;
                                                });
                                              }),
                                        ),
                                        ListTile(
                                          title: const Text("60%"),
                                          leading: Radio(
                                              value: 3,
                                              groupValue: selected,
                                              onChanged: (int? i) {
                                                setState(() {
                                                  selected = i!;
                                                });
                                              }),
                                        ),
                                        ListTile(
                                          title: const Text("50%"),
                                          leading: Radio(
                                              value: 4,
                                              groupValue: selected,
                                              onChanged: (int? i) {
                                                setState(() {
                                                  selected = i!;
                                                });
                                              }),
                                        ),
                                      ]),
                                ),
                                CustomMainBotton(
                                    color: yellowColor,
                                    isLoading: isLoading,
                                    onPressed: () async {
                                      String output =
                                          await CloudFireStoreClass()
                                              .upLoadProductToFirebase(
                                        image: image,
                                        productName: nameController.text,
                                        rawCost: costController.text,
                                        discount: discountKey[selected - 1],
                                        sellerName:
                                            Provider.of<UserDetailsProvider>(
                                                    context,
                                                    listen: false)
                                                .userDetails!
                                                .name,
                                        sellerUid: FirebaseAuth
                                            .instance.currentUser!.uid,
                                            
                                      );
                                      if (output == "success") {
                                        Utils().showSnackBar(
                                            context: context,
                                            content: "Posted Product");
                                      } else {
                                        Utils().showSnackBar(
                                            context: context, content: output);
                                      }
                                    },
                                    child: const Text(
                                      'Sell',
                                      style: TextStyle(color: Colors.black),
                                    )),
                                CustomMainBotton(
                                    color: Colors.grey[300]!,
                                    isLoading: isLoading,
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      'Back',
                                      style: TextStyle(color: Colors.black),
                                    ))
                              ]),
                        ),
                      ),
                    ),
                  )
                : const LoadingWidget()));
  }
}
