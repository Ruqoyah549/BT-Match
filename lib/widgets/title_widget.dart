import 'package:bt_match/utils/constants.dart';
import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: kPrimaryColor, borderRadius: BorderRadius.circular(25)),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(
              "https://crests.football-data.org/PL.png",
              height: 40,
              color: Colors.white,
            ),
            SizedBox(width: 10),
            const Text(
              "Premier League 2021/2022",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}
