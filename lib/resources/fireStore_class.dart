import 'dart:typed_data';

import 'package:amazon_clone/MODELS/product_model.dart';
import 'package:amazon_clone/MODELS/review_model.dart';
import 'package:amazon_clone/MODELS/user_details_model.dart';
import 'package:amazon_clone/widgets/simple_product_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../MODELS/request.dart';
import '../utils/utils.dart';

class CloudFireStoreClass {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future uploadNameAndAddress({required UserDetailsModel user}) async {
    await firebaseFirestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .set(user.getJson());
  }

  Future<UserDetailsModel> getNameAndAddress() async {
    DocumentSnapshot results = await firebaseFirestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .get();
    UserDetailsModel userModel =
        UserDetailsModel.getModelFromJson((results.data() as dynamic));
    return userModel;
  }

  Future<String> upLoadProductToFirebase({
    required Uint8List? image,
    required String productName,
    required String rawCost,
    required int discount,
    required String sellerName,
    required String sellerUid,
  }) async {
    productName.trim();
    rawCost.trim();
    String output = "something went wrong";
    if (image != null && productName != null && rawCost != null) {
      try {
        String uid = Utils().getUid();
        String url =
            await uploadImageToFirebase(image: image, uid: Utils().getUid());
        double cost = double.parse(rawCost);
        cost = cost - (cost * (discount) / 100);
        ProductModel product = ProductModel(
            url: url,
            productName: productName,
            cost: cost,
            discount: discount,
            uid: uid,
            sellerName: sellerName,
            sellerUid: sellerUid,
            rating: 5,
            noOfRating: 0);
        firebaseFirestore
            .collection("products")
            .doc(uid)
            .set(product.getJson());
        output = "success";
      } catch (e) {
        output = e.toString();
      }
    } else {
      output = "fill all fields";
    }
    return output;
  }

  Future<String> uploadImageToFirebase(
      {required Uint8List image, required String uid}) async {
    Reference storageRef =
        FirebaseStorage.instance.ref().child("products").child(uid);
    UploadTask uploadTask = storageRef.putData(image);
    TaskSnapshot task = await uploadTask;
    return task.ref.getDownloadURL();
  }

  Future<List<Widget>> getProductsFromDiscount(int discount) async {
    List<Widget> children = [];
    QuerySnapshot<Map<String, dynamic>> snap = await firebaseFirestore
        .collection("products")
        .where("discount", isEqualTo: discount)
        .get();
    for (int i = 0; i < snap.docs.length; i++) {
      DocumentSnapshot docSnap = snap.docs[i];
      ProductModel model =
          ProductModel.getModelFromJson(json: docSnap.data() as dynamic);
      children.add(SimpleProductWidget(productModel: model));
    }
    return children;
  }

  Future uploadReviewToDatabase(
      {required String productUid, required ReviewModel model}) async {
    firebaseFirestore
        .collection("products")
        .doc(productUid)
        .collection("reviews")
        .add(model.getJson());
    await changeAverageRating(productUid: productUid, reviewModel: model);
  }

  signOutUser() {
    FirebaseAuth.instance.signOut();
  }

  Future addModelToCart({required ProductModel model}) async {
    FirebaseFirestore.instance
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("cart")
        .doc(model.uid)
        .set(model.getJson());
  }

  Future deleteProductFromCart({required String uid}) async {
    await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("cart")
        .doc(uid)
        .delete();
  }

  Future buyAllItemsInCart({required UserDetailsModel userDetailsModel}) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("cart")
        .get();
    for (int i = 0; i < snapshot.docs.length; i++) {
      ProductModel model =
          ProductModel.getModelFromJson(json: snapshot.docs[i].data());
      addProductToOrders(model: model, userDetailsModel: userDetailsModel);
      await deleteProductFromCart(uid: model.uid);
    }
  }

  Future addProductToOrders(
      {required ProductModel model,
      required UserDetailsModel userDetailsModel}) async {
    firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("orders")
        .add(model.getJson());
    await sendOrderRequest(model: model, userDetails: userDetailsModel);
  }

  Future sendOrderRequest({
    required ProductModel model,
    required UserDetailsModel userDetails,
  }) async {
    OrderRequestModel orderRequestModel = OrderRequestModel(
        orderName: model.productName, buyerAddress: userDetails.address);
    await firebaseFirestore
        .collection("users")
        .doc(model.sellerUid)
        .collection("orderRequests")
        .add(orderRequestModel.getJson());
  }

  Future changeAverageRating(
      {required String productUid, required ReviewModel reviewModel}) async {
    DocumentSnapshot snapshot =
        await firebaseFirestore.collection("products").doc(productUid).get();
    ProductModel model =
        ProductModel.getModelFromJson(json: (snapshot.data() as dynamic)??{});
    int currentRating = model.rating;
    int newRating = ((currentRating + reviewModel.rating) / 2).toInt();
    await firebaseFirestore
        .collection("products")
        .doc(productUid)
        .update({"rating": newRating});
  }
}
