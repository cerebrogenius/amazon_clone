import 'package:amazon_clone/widgets/search_bar.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: SearchBar(
          isReadOnly: false, 
          hasBackButton: true),
      ),
    );
  }
}
