import 'package:flutter/material.dart';
import 'package:liveasy/constants/fontSize.dart';
import 'package:liveasy/constants/fontWeights.dart';
import 'package:liveasy/widgets/buttons/callButton.dart';

// ignore: must_be_immutable
class CardLowerWidget extends StatelessWidget {
  String? loadPosterCompanyName;
  String? loadPosterPhoneNo;

  CardLowerWidget({this.loadPosterCompanyName, this.loadPosterPhoneNo});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 47,
      padding: EdgeInsets.symmetric(horizontal: 15),
      color: Colors.blueGrey[100],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image(
                image: AssetImage("assets/icons/buildingIconBlack.png"),
                height: size_8,
                width: size_8 - 1,
              ),
              Text(
                "$loadPosterCompanyName",
                style:
                    TextStyle(fontSize: size_7, fontWeight: mediumBoldWeight),
              )
            ],
          ),
          CallButton(loadPosterPhoneNo: "$loadPosterPhoneNo"),
        ],
      ),
    );
  }
}