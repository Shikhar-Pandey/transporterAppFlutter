import 'package:flutter/material.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/constants/fontSize.dart';
import 'package:liveasy/constants/fontWeights.dart';
import 'package:liveasy/constants/spaces.dart';
import 'package:liveasy/screens/orderScreens/BiddingsScreen.dart';

class ViewBidButton extends StatelessWidget {
  String? loadFrom;
  int? load;
  String? loadTo;
  ViewBidButton({Key? key, this.load, this.loadTo, this.loadFrom})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: space_2, left: space_4),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BiddingsScreen(
                loadTo: loadTo,
                loadFrom: loadFrom,
                load: load,
              ),
            ),
          );
        },
        child: Container(
          width: 86,
          height: 31,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(size_10),
            color: bidBackground,
          ),
          child: Center(
            child: Text(
              "View bids",
              style: TextStyle(
                  fontWeight: mediumBoldWeight,
                  fontSize: size_6,
                  color: white,
                  fontFamily: "Montserrat"),
            ),
          ),
        ),
      ),
    );
  }
}
