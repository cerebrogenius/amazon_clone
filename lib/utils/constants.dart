import 'package:amazon_clone/screens/accounts_screen.dart';
import 'package:amazon_clone/screens/cart_screen.dart';
import 'package:amazon_clone/screens/home_screen.dart';
import 'package:amazon_clone/screens/more_screen.dart';
import 'package:flutter/material.dart';

import '../MODELS/product_model.dart';
import '../widgets/simple_product_widget.dart';

const double kAppBarHeight = 80;

const String amazonLogoUrl =
    "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4a/Amazon_icon.svg/2500px-Amazon_icon.svg.png";

const List<String> categoriesList = [
  "Prime",
  "Mobiles",
  "Fashion",
  "Electronics",
  "Home",
  "Fresh",
  "Appliances",
  "Books, Toys",
  "Essential"
];

const List<Widget> screens = [
  HomeScreen(),
  AccountsScreen(),
  CartScreen(),
  MoreScreen()
];

const List<String> categoryLogos = [
  "https://m.media-amazon.com/images/I/11uufjN3lYL._SX90_SY90_.png",
  "https://m.media-amazon.com/images/I/116KbsvwCRL._SX90_SY90_.png",
  "https://m.media-amazon.com/images/I/115yueUc1aL._SX90_SY90_.png",
  "https://m.media-amazon.com/images/I/11qyfRJvEbL._SX90_SY90_.png",
  "https://m.media-amazon.com/images/I/11BIyKooluL._SX90_SY90_.png",
  "https://m.media-amazon.com/images/I/11CR97WoieL._SX90_SY90_.png",
  "https://m.media-amazon.com/images/I/01cPTp7SLWL._SX90_SY90_.png",
  "https://m.media-amazon.com/images/I/11yLyO9f9ZL._SX90_SY90_.png",
  "https://m.media-amazon.com/images/I/11M0jYc-tRL._SX90_SY90_.png",
];

const List<String> largeAds = [
  "https://m.media-amazon.com/images/I/51QISbJp5-L._SX3000_.jpg",
  "https://m.media-amazon.com/images/I/61jmYNrfVoL._SX3000_.jpg",
  "https://m.media-amazon.com/images/I/612a5cTzBiL._SX3000_.jpg",
  "https://m.media-amazon.com/images/I/61fiSvze0eL._SX3000_.jpg",
  "https://m.media-amazon.com/images/I/61PzxXMH-0L._SX3000_.jpg",
];

const List<String> smallAds = [
  "https://m.media-amazon.com/images/I/11M5KkkmavL._SS70_.png",
  "https://m.media-amazon.com/images/I/11iTpTDy6TL._SS70_.png",
  "https://m.media-amazon.com/images/I/11dGLeeNRcL._SS70_.png",
  "https://m.media-amazon.com/images/I/11kOjZtNhnL._SS70_.png",
];

const List<String> adItemNames = [
  "Amazon Pay",
  "Recharge",
  "Rewards",
  "Pay Bills"
];

const String amazonLogo =
    "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a9/Amazon_logo.svg/2560px-Amazon_logo.svg.png";

List<Widget> testChildren = [
SimpleProductWidget(productModel:ProductModel(
                    url: "https://m.media-amazon.com/images/I/116KbsvwCRL._SX90_SY90_.png" , 
                    productName: 'productName',
                    cost:  400.0, 
                  discount:   25 ,
                     uid: "userid2", 
                    sellerName:  'sellerName2', 
                    sellerUid:  'sellerUid2', 
                     rating: 2, 
                      noOfRating: 4), ),
                      SimpleProductWidget(productModel:ProductModel(
                    url: "https://m.media-amazon.com/images/I/116KbsvwCRL._SX90_SY90_.png" , 
                    productName: 'productName',
                    cost:  500.0, 
                  discount:   15 ,
                     uid: "userid2", 
                    sellerName:  'sellerName2', 
                    sellerUid:  'sellerUid2', 
                     rating: 4, 
                      noOfRating: 5), ),
                      SimpleProductWidget(productModel:ProductModel(
                    url: "https://m.media-amazon.com/images/I/116KbsvwCRL._SX90_SY90_.png" , 
                    productName: 'productName3',
                    cost:  300.0, 
                  discount:   25 ,
                     uid: "userid3", 
                    sellerName:  'sellerName3', 
                    sellerUid:  'sellerUid3', 
                     rating: 1, 
                      noOfRating: 4), )
];

List<String> keyOfRating = [
  'very bad', 'poor', 'average','good', 'excellent'
];
