import 'package:bt_match/controller/home_controller.dart';
import 'package:bt_match/utils/constants.dart';
import 'package:bt_match/view/winner_team_screen.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DateWidget extends StatelessWidget {
  const DateWidget({Key? key, required this.homeController}) : super(key: key);

  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Align(
            child: DateTimePicker(
              dateMask: 'd MMM, yyyy',
              initialValue: DateTime.now().toString(),
              firstDate: DateTime(2021, 8, 14),
              lastDate: DateTime.now(),
              icon: Icon(Icons.event, color: kPrimaryColor),
              dateLabelText: 'Choose Date',
              onChanged: (val) {
                homeController.selectedDate = DateTime.parse(val);
              },
              validator: (val) {
                if (val!.isEmpty) {
                  return "Date is required";
                }
                return null;
              },
            ),
          ),
        ),
        SizedBox(width: 30),
        GestureDetector(
          onTap: () => Get.to(() => WinnerTeamScreen()),
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                "Go",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              )),
        ),
      ],
    );
  }
}
