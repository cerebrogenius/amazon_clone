import 'package:amazon_clone/utils/color_themes.dart';
import 'package:amazon_clone/widgets/loading_widget.dart';
import 'package:amazon_clone/widgets/results_widget.dart';
import 'package:amazon_clone/widgets/search_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../MODELS/product_model.dart';

class ResultsScreen extends StatelessWidget {
  final String querry;
  const ResultsScreen({Key? key, required this.querry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: SearchBar(isReadOnly: false, hasBackButton: true),
        body: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal:15.0,
                  vertical: 10
                  ),
                child: RichText(text: TextSpan(
                  children: [
                   const TextSpan(
                      text: 'Showing Results For ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17
                      )
                    ),
                    TextSpan(text: querry,
                    style:const TextStyle(
                      color: activeCyanColor,
                      fontSize: 17,
                      fontStyle: FontStyle.italic
                    )
                    )
                    ]
                ),),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: FirebaseFirestore.instance.collection("products").where("products",isEqualTo: querry).get(),
                builder: (
                  context, AsyncSnapshot<QuerySnapshot<Map<String,dynamic>>>snapshot
                ){
                  if(snapshot.connectionState==ConnectionState.waiting){
                    return const LoadingWidget();
                  }else{
                    return GridView.builder(
                      gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 2/4
                  ),
                  itemCount:snapshot.data!.docs.length, 
                  itemBuilder: (context,index){
                    ProductModel product = ProductModel.getModelFromJson(json: snapshot.data!.docs[index].data());
                    return ResultsWidget(product: product);
                  });
                  }
                })
            )
          ],
        ),
      ),
    );
  }
}
