import 'package:amazon_clone/providers/user_details_provider.dart';
import 'package:amazon_clone/resources/fireStore_class.dart';
import 'package:amazon_clone/utils/constants.dart';
import 'package:amazon_clone/widgets/banner_add_widget.dart';
import 'package:amazon_clone/widgets/categories_list.dart';
import 'package:amazon_clone/widgets/loading_widget.dart';
import 'package:amazon_clone/widgets/products_listview.dart';
import 'package:amazon_clone/widgets/search_bar.dart';

import 'package:amazon_clone/widgets/user_detailsBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double offset = 0;
  ScrollController controller = ScrollController();

  List<Widget>? discount70;
  List<Widget>? discount60;
  List<Widget>? discount50;
  List<Widget>? discount0;

  @override
  void initState() {
    super.initState();
    Provider.of<UserDetailsProvider>(context, listen: false).getData();
    getData();
    controller.addListener(() {
      setState(() {
        offset = controller.position.pixels;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void getData() async {
    List<Widget> temp70 =
        await CloudFireStoreClass().getProductsFromDiscount(70);
    List<Widget> temp60 =
        await CloudFireStoreClass().getProductsFromDiscount(60);
    List<Widget> temp50 =
        await CloudFireStoreClass().getProductsFromDiscount(50);
    List<Widget> temp0 = 
        await CloudFireStoreClass().getProductsFromDiscount(0);

    setState(() {
      discount70 = temp70;
      discount60 = temp60;
      discount50 = temp50;
      discount0 = temp0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: SearchBar(
            isReadOnly: true,
            hasBackButton: false,
          ),
          body: discount70 != null &&
                  discount60 != null &&
                  discount50 != null &&
                  discount0 != null
              ? Stack(
                  children: [
                    SingleChildScrollView(
                      controller: controller,
                      child: Column(children: [
                        const SizedBox(height: kAppBarHeight / 2),
                        const CategoriesList(),
                        const BannerAddWidget(),
                        ProductsListView(
                            title: 'up to 70% off', children: discount70!),
                        ProductsListView(
                            title: 'up to 60% off', children: discount60!),
                        ProductsListView(
                            title: 'up to 50% off', children: discount50!),
                        ProductsListView(title: 'Explore', children: discount0!)
                      ]),
                    ),
                    UserDetailsBar(offset: -offset)
                  ],
                )
              : const LoadingWidget()),
    );
  }
}
