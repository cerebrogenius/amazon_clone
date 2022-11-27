import 'package:amazon_clone/utils/constants.dart';
import 'package:flutter/material.dart';

import '../screens/results_screen.dart';


class CategoriesList extends StatelessWidget {
  const CategoriesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kAppBarHeight,
      width: double.infinity,
      color: Colors.white,
      child: ListView.builder(
        scrollDirection:Axis.horizontal ,
          itemCount: categoriesList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: (){
                 Navigator.push(context, 
        MaterialPageRoute(builder: (context) {
         return ResultsScreen(querry:categoriesList[index]   );
        }));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 5, horizontal: 15
                ),
                child: Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          categoryLogos[index]
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(categoriesList[index]),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
