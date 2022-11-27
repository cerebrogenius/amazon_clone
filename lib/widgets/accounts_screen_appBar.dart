import 'package:amazon_clone/screens/search_screen.dart';
import 'package:amazon_clone/utils/constants.dart';

import 'package:flutter/material.dart';

import '../utils/color_themes.dart';
import '../utils/utils.dart';

class AccountScreenAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;
  AccountScreenAppBar({Key? key})
      : preferredSize = const Size.fromHeight(kAppBarHeight),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return SafeArea(
      child: Container(
        height: kAppBarHeight,
        width: screenSize.width,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: backgroundGradient,
                begin: Alignment.centerLeft,
                end: Alignment.bottomRight)),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Image.network(amazonLogoUrl, height: kAppBarHeight * 0.8),
          ),
          Row(children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_outlined,
                color: Colors.black,
              ),
            ),
            IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const SearchScreen();
                  }));
                },
                icon: const Icon(
                  Icons.search_outlined,
                  color: Colors.black,
                ))
          ])
        ]),
      ),
    );
  }
}
