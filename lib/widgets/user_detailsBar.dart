import 'package:amazon_clone/MODELS/user_details_model.dart';
import 'package:amazon_clone/providers/user_details_provider.dart';
import 'package:amazon_clone/utils/color_themes.dart';
import 'package:amazon_clone/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/utils.dart';

class UserDetailsBar extends StatelessWidget {
  bool position;
  final double offset;

  UserDetailsBar({Key? key, required this.offset, this.position = true});

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
  UserDetailsModel? userDetails =
        Provider.of<UserDetailsProvider>(context).userDetails ;
    return position
        ? Positioned(
            top: offset / 3,
            child: Container(
              height: kAppBarHeight / 2,
              width: screenSize.width,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: lightBackgroundaGradient,
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight)),
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 3, horizontal: 20),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Icon(
                          Icons.location_on_outlined,
                          color: Colors.grey[900],
                        ),
                      ),
                      SizedBox(
                        width: screenSize.width * 0.7,
                        child: Text(
                          'deliver to ${userDetails!.name} at ${userDetails.address}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.grey[900]),
                        ),
                      )
                    ],
                  )),
            ),
          )
        : Container(
            height: kAppBarHeight / 2,
            width: screenSize.width,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: lightBackgroundaGradient,
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight)),
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 3, horizontal: 20),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Icon(
                        Icons.location_on_outlined,
                        color: Colors.grey[900],
                      ),
                    ),
                    SizedBox(
                      width: screenSize.width * 0.7,
                      child: Text(
                        'deliver to ${userDetails!.name} at ${userDetails.address}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.grey[900]),
                      ),
                    )
                  ],
                )),
          );
  }
}
