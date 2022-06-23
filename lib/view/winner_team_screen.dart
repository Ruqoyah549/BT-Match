import 'package:bt_match/controller/home_controller.dart';
import 'package:bt_match/controller/match_controller.dart';
import 'package:bt_match/utils/constants.dart';
import 'package:bt_match/widgets/app_bar_title.dart';
import 'package:bt_match/widgets/landscape_team_details.dart';
import 'package:bt_match/widgets/team_crest.dart';
import 'package:bt_match/widgets/team_full_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WinnerTeamScreen extends StatelessWidget {
  WinnerTeamScreen({Key? key}) : super(key: key);

  final matchController = Get.put(MatchController());
  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE5E5E5),
      appBar: AppBar(title: AppBarTitle()),
      body: OrientationBuilder(
        builder: (context, orientation) => orientation == Orientation.portrait
            ? buildPortrait(context)
            : buildLandscape(context),
      ),
    );
  }

  Widget buildPortrait(BuildContext context) =>
      Obx(() => matchController.isLoadingMatch.value
          ? Center(
              child: CircularProgressIndicator(),
            )
          : matchController.finalResult.wonMatches == 0
              ? Center(
                  child: Text(
                    "No data found for this date range. Kindly select an earlier date",
                  ),
                )
              : Column(
                  children: [
                    SizedBox(height: 30),
                    if (!matchController.isLoadingMatch.value &&
                        matchController.finalResult.wonMatches! > 0)
                      Align(
                        child: Text(
                          "${matchController.finalResult.wonMatches} Match(es) won between\n"
                          "${kFormatDate.format(matchController.thirtyDaysAgo!)} and ${kFormatDate.format(homeController.selectedDate!)}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                      ),
                    SizedBox(height: 20),
                    Expanded(
                      child: matchController.finalResult.name!.isEmpty
                          ? Center(
                              child: Text(
                                "No data found for this date range. Kindly select an earlier date",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w700),
                              ),
                            )
                          : Column(
                              children: [
                                TeamCrest(
                                    crest: matchController.finalResult.crest!),
                                SizedBox(height: 20),
                                TeamFullDetails(
                                    team: matchController.teamDetails),
                              ],
                            ),
                    ),
                  ],
                ));

  Widget buildLandscape(BuildContext context) => Obx(
        () => matchController.isLoadingMatch.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : matchController.finalResult.wonMatches == 0
                ? Center(
                    child: Text(
                        "No data found for this date range. Kindly select an earlier date"),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 30),
                        if (!matchController.isLoadingMatch.value &&
                            matchController.finalResult.wonMatches! > 0)
                          Align(
                            child: Text(
                              "${matchController.finalResult.wonMatches} Match(es) won between\n"
                              "${kFormatDate.format(matchController.thirtyDaysAgo!)} and ${kFormatDate.format(homeController.selectedDate!)}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w700),
                            ),
                          ),
                        SizedBox(height: 20),
                        TeamCrest(crest: matchController.finalResult.crest!),
                        SizedBox(height: 20),
                        LandscapeTeamDetails(team: matchController.teamDetails),
                      ],
                    ),
                  ),
      );
}
