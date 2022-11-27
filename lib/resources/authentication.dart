import 'package:amazon_clone/MODELS/user_details_model.dart';
import 'package:amazon_clone/resources/fireStore_class.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationMethods {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  CloudFireStoreClass cloudFireStoreClass = CloudFireStoreClass();
  Future<String?> signUpUser({
    required String name,
    required String address,
    required String email,
    required String password,
  }) async {
    String? user = '';
    name.trim();
    address.trim();
    email.trim();
    password.trim();
    String output = 'All Fields Are Required';
    if (name != '' && address != '' && email != '' && password != '') {
      try {
        await firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password);
        UserDetailsModel user = UserDetailsModel(name:name, address:address);
        await cloudFireStoreClass.uploadNameAndAddress(user: user);
        output = 'success';
      } on FirebaseException catch (e) {
        output = e.message.toString();
      }
    }
    return output;
  }

  Future<String?> signInUser({
    required String email,
    required String password,
  }) async {
    String? user = '';

    email.trim();
    password.trim();
    String output = 'All Fields Are Required';
    if (email != '' && password != '') {
      try {
        await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        output = 'success';
      } on FirebaseException catch (e) {
        output = e.message.toString();
      }
    }
    return output;
  }
}
