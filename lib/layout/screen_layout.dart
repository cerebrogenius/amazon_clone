import 'package:amazon_clone/providers/user_details_provider.dart';
import 'package:amazon_clone/utils/color_themes.dart';
import 'package:amazon_clone/utils/functions_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/constants.dart';

class ScreenLayout extends StatelessWidget {
  const ScreenLayout({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<UserDetailsProvider>(context).getData();
    PageController pageController = PageController();
    changePage(int page) {
      pageController.jumpToPage(page);
      Provider.of<TextFieldProvider>(context, listen: false)
          .setCurrentPage(page);
    }

    int currentPage = Provider.of<TextFieldProvider>(context).currentPage;
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: PageView(
          controller: pageController,
          children: screens,
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey, width: 1))),
          child: TabBar(
              indicatorSize: TabBarIndicatorSize.label,
              indicator: const BoxDecoration(
                  border: Border(
                      top: BorderSide(color: activeCyanColor, width: 4))),
              onTap: changePage,
              tabs: [
                Tab(
                  child: Column(
                    children: [
                      Icon(
                        Icons.home_outlined,
                        color:
                            currentPage == 0 ? activeCyanColor : Colors.black,
                      ),
                    ],
                  ),
                ),
                Tab(
                  child: Column(
                    children: [
                      Icon(Icons.account_circle_outlined,
                          color: currentPage == 1
                              ? activeCyanColor
                              : Colors.black),
                    ],
                  ),
                ),
                Tab(
                  child: Column(
                    children: [
                      Icon(Icons.shopping_cart_outlined,
                          color: currentPage == 2
                              ? activeCyanColor
                              : Colors.black),
                    ],
                  ),
                ),
                Tab(
                  child: Column(
                    children: [
                      Icon(Icons.menu,
                          color: currentPage == 3
                              ? activeCyanColor
                              : Colors.black),
                    ],
                  ),
                )
              ]),
        ),
      ),
    );
  }
}
