import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CostWidget extends StatelessWidget {
  final Color color;
  final double cost;
  const CostWidget({Key? key, required this.color, required this.cost})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
      Text('\$',
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontFeatures: const[
            FontFeature.superscripts()
            ]
        ),
        ),
        Text(cost.toInt().toString(),
        style: TextStyle(
          color: color,
          fontSize: 25,
          fontWeight: FontWeight.w800,
        ),
        ),
        Text((cost - cost.toInt()).toString(),
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontFeatures:const [
            FontFeature.superscripts()
          ]
        ),
        )
      ],
    );
  }
}
