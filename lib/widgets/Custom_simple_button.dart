import 'package:flutter/material.dart';


class CustomSimpleButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  const CustomSimpleButton(
      {Key? key, required this.onPressed, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color:Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color:Colors.grey, width: 1 )
        ),
        child: Text(text)
      ),
    );
  }
}
