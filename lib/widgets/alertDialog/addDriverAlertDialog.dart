import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/constants/fontSize.dart';
import 'package:liveasy/constants/fontWeights.dart';
import 'package:liveasy/constants/radius.dart';
import 'package:liveasy/constants/spaces.dart';
import 'package:liveasy/controller/transporterIdController.dart';
import 'package:liveasy/functions/loadOnGoingDeliveredData.dart';
import 'package:liveasy/providerClass/providerData.dart';
import 'package:liveasy/widgets/buttons/addButton.dart';
import 'package:liveasy/widgets/buttons/cancelButton.dart';
import 'package:permission_handler/permission_handler.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:contact_picker/contact_picker.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AddDriverAlertDialog extends StatefulWidget {
  String? selectedTruckId;

  AddDriverAlertDialog({this.selectedTruckId});

  @override
  _AddDriverAlertDialogState createState() => _AddDriverAlertDialogState();
}

class _AddDriverAlertDialogState extends State<AddDriverAlertDialog> {
  // TextEditingController name = TextEditingController();
  // TextEditingController number = TextEditingController();
  final ContactPicker _contactPicker = new ContactPicker();
  Contact? _contact;
  String? contactName = "";
  String? contactNumber = "";
  String displayContact = "";
  TransporterIdController tIdController = Get.find<TransporterIdController>();

  @override
  Widget build(BuildContext context) {
    var providerData = Provider.of<ProviderData>(context, listen: false);
    return AlertDialog(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "DRIVER NAME",
            style: TextStyle(fontSize: size_9, fontWeight: normalWeight),
          ),
          SizedBox(
            height: space_2,
          ),
          Container(
            height: space_7 + 2,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: darkGreyColor)),
            child: Padding(
              padding: EdgeInsets.only(
                left: space_2 - 2,
                right: space_2 - 2,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextField(
                        // controller: name,
                        decoration: InputDecoration(
                          hintText:
                              contactName != "" ? contactName : "Type here",
                          hintStyle: TextStyle(
                              color: black, fontWeight: mediumBoldWeight),
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          contactName = value;
                        }),
                  ),
                  GestureDetector(
                      onTap: () async {
                        if (await Permission.contacts.request().isGranted) {
                          Contact contact =
                              await _contactPicker.selectContact();
                          setState(() {
                            _contact = contact;
                            contactName = _contact!.fullName.toString();
                            contactNumber =
                                _contact!.phoneNumber.number.toString();
                            displayContact =
                                contactName! + " - " + contactNumber!;
                          });
                        }
                      },
                      child: Image(
                        image:
                            AssetImage("assets/icons/addFromPhoneBookIcon.png"),
                        height: space_5 + 2,
                        width: space_5 + 2,
                      )),
                ],
              ),
            ),
          ),
          SizedBox(
            height: space_2 + 2,
          ),
          Text(
            "DRIVER NUMBER",
            style: TextStyle(fontSize: size_9, fontWeight: normalWeight),
          ),
          SizedBox(
            height: space_2,
          ),
          Container(
            height: space_7 + 2,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: darkGreyColor)),
            child: Padding(
              padding: EdgeInsets.only(
                left: space_2 - 2,
                right: space_2 - 2,
              ),
              child: TextField(
                // controller: number,
                decoration: InputDecoration(
                  hintText: contactNumber == "" ? "Type here" : contactNumber,
                  hintStyle:
                      TextStyle(color: black, fontWeight: mediumBoldWeight),
                  border: InputBorder.none,
                ),
                onChanged: (numberValue) {
                  contactNumber = numberValue;
                },
              ),
            ),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(top: space_11, bottom: space_4 + 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AddButton(
                displayContact: displayContact,
                selectedTruckId: widget.selectedTruckId,
                onTap: addDriverFunction,
              ),
              CancelButton()
            ],
          ),
        )
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(radius_2 - 2)),
      ),
      insetPadding: EdgeInsets.only(left: space_4, right: space_4),
    );
  }
  addDriverFunction(){

    var transporterId = '${tIdController.transporterId}';
    if (displayContact.isEmpty == true || displayContact == "") {
      driverApiCalls.postDriverApi(
          contactName,contactNumber , transporterId, widget.selectedTruckId);
      displayContact="$contactName - $contactNumber";
    } else {
      List listDisplayContact = displayContact.split("-");
      contactName = listDisplayContact[0];
      contactNumber = displayContact.replaceAll(new RegExp(r"\D"), "");
      driverApiCalls.postDriverApi(
          contactName,contactNumber , transporterId, widget.selectedTruckId);
      displayContact="$contactName - $contactNumber";
    }
    Provider.of<ProviderData>(context, listen: false).updateDriverNameList(newValue: displayContact);

  }
}
