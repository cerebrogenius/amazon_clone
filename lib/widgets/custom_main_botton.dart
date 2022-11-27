import 'package:flutter/material.dart';
import '../utils/utils.dart';

class CustomMainBotton extends StatelessWidget {
  final Widget child;
  final Color color;
  final bool isLoading;
  final VoidCallback onPressed;

  const CustomMainBotton(
      {super.key,
      required this.color,
      required this.isLoading,
      required this.onPressed,
      required this.child});

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: color,
          fixedSize: Size(screenSize.width*0.5, 40)
          ),
        onPressed: onPressed,
        child: !isLoading?child : const Padding(
          padding: EdgeInsets.symmetric( vertical:5),
          child:  AspectRatio(
            aspectRatio: 1/1,
            child: CircularProgressIndicator(
              color: Colors.white,
            )),
        ));
  }
}