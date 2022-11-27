import 'package:amazon_clone/utils/color_themes.dart';
import 'package:amazon_clone/utils/constants.dart';
import 'package:flutter/material.dart';
import '../utils/utils.dart';

class BannerAddWidget extends StatefulWidget {
  const BannerAddWidget({Key? key}) : super(key: key);

  @override
  State<BannerAddWidget> createState() => _BannerAddWidgetState();
}

class _BannerAddWidgetState extends State<BannerAddWidget> {
  

  @override
  Widget build(BuildContext context) {
    int currentAdd = 0;

    Size screenSize = Utils().getScreenSize();
    double smallAddHeight = screenSize.width/5;
    return GestureDetector(
      onHorizontalDragEnd: (_) {
        if (currentAdd == (largeAds.length-1) ) {
          currentAdd = 0;
        }
        setState(() {
          currentAdd++;
        });
      },
      child: Column(
        children: [
          Stack(
            children: [
              Image.network(
                largeAds[currentAdd],
                width: double.infinity,
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: screenSize.width,
                  height: 100,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                        backgroundColor,
                        backgroundColor.withOpacity(0)
                      ])),
                ),
              )
            ],
          ),
          Container(
              color: backgroundColor,
              width: screenSize.width,
              height: smallAddHeight+20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  getSmallAdds(0, smallAddHeight),
                  getSmallAdds(1, smallAddHeight),
                  getSmallAdds(2, smallAddHeight),
                  getSmallAdds(3, smallAddHeight),
                  // getSmallAdds(4, smallAddHeight),
                  
                ],
              ))
        ],
      ),
    );
  }

  Widget getSmallAdds(int index, double height) {
    return Container(
      height: height+18,
      width: height+10,
      decoration: ShapeDecoration(
        color: Colors.white,
        shadows:[ BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 5,spreadRadius: 1)],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        )
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(top:1.0),
              child: Image.network(smallAds[index]),
            ),
            const SizedBox(height:5),
            Text(adItemNames[index])
          ],
        ),
      ),
    );
  }
}
