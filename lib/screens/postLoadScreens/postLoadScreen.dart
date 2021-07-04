import 'package:flutter/material.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/constants/spaces.dart';
import 'package:liveasy/providerClass/providerData.dart';
import 'package:liveasy/screens/myLoadPages/deliveredScreen.dart';

import 'package:liveasy/screens/myLoadPages/myLoadsScreen.dart';
import 'package:liveasy/screens/myLoadPages/onGoingScreen.dart';

import 'package:liveasy/widgets/Header.dart';
import 'package:liveasy/widgets/OrderScreenNavigationBarButton.dart';
import 'package:liveasy/widgets/buttons/postLoadButton.dart';

import 'package:provider/provider.dart';

class PostLoadScreen extends StatefulWidget {
  const PostLoadScreen({Key? key}) : super(key: key);

  @override
  _PostLoadScreenState createState() => _PostLoadScreenState();
}

class _PostLoadScreenState extends State<PostLoadScreen> {

  //Page Controller
  PageController pageController = PageController(initialPage: 0);

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    ProviderData providerData = Provider.of<ProviderData>(context);
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(space_4, space_4, space_4, space_2),
          child: Column(
            children: [
              Header(reset: false, text: 'Loads', backButton: false),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OrderScreenNavigationBarButton(
                      text: 'My Loads',
                      value: 0,
                      pageController: pageController),
                  OrderScreenNavigationBarButton(
                      text: 'On-going',
                      value: 1,
                      pageController: pageController),
                  OrderScreenNavigationBarButton(
                      text: 'Delivered',
                      value: 2,
                      pageController: pageController)
                ],
              ),
              Divider(
                color: textLightColor,
                thickness: 1,
              ),
              Stack(
                // alignment: Alignment.center,
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.75,
                    child: PageView(
                      controller: pageController,
                      onPageChanged: (value) {
                        setState(() {
                          providerData.updateUpperNavigatorIndex(value);
                        });
                      },
                      children: [
                        MyLoadsScreen(),
                        OngoingScreen(),
                        DeliveredScreen(),
                      ],
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(bottom: 50),
                      child: PostButtonLoad()),
                  // Positioned.fill(
                  //   top: 550,
                  //   child: Align(
                  //       alignment: Alignment.center, child: PostButtonLoad()),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// OngoingCardOrders(
//   loadingPoint: "l",
//   unloadingPoint: "l",
//   companyName: "l",
//   vehicleNo: "l",
//   driverName: "l",
//   startedOn: "l",
//   bookingId: "l",
//   endedOn: "l",
//   imei: "l",
//   driverPhoneNum: "l",
//   transporterPhoneNumber: "l",
//   // transporterName : snapshot.data['transporterName'],
// ),
