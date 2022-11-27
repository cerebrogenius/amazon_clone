import 'package:amazon_clone/utils/constants.dart';
import 'package:amazon_clone/widgets/big_category.dart';
import 'package:amazon_clone/widgets/search_bar.dart';
import 'package:flutter/material.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: SearchBar(isReadOnly: false, hasBackButton: false),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
                gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 2.2 / 3.5,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15
                ),
                itemCount: categoriesList.length,
                itemBuilder: (context, index) {
                  return BigCategory(index: index);
                }),
          )),
    );
  }
}
