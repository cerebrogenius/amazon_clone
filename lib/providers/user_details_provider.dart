import 'package:amazon_clone/MODELS/user_details_model.dart';
import 'package:amazon_clone/resources/fireStore_class.dart';


import 'package:flutter/material.dart';

class UserDetailsProvider extends ChangeNotifier {
  UserDetailsModel? userDetails;
  UserDetailsProvider() : userDetails = UserDetailsModel(name: 'null',address: 'null');
  Future getData() async {
    userDetails = await CloudFireStoreClass().getNameAndAddress();
    notifyListeners();
  }
}
