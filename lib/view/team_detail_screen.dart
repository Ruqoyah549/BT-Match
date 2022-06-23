import 'package:bt_match/controller/team_controller.dart';
import 'package:bt_match/model/team_details.dart';
import 'package:bt_match/widgets/app_bar_title.dart';
import 'package:bt_match/widgets/landscape_team_details.dart';
import 'package:bt_match/widgets/team_crest.dart';
import 'package:bt_match/widgets/team_full_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TeamDetailScreen extends StatelessWidget {
  TeamDetailScreen(this.teamID, {Key? key}) : super(key: key);

  final int teamID;

  @override
  Widget build(BuildContext context) {
    final teamController = Get.put(TeamController(teamID: teamID));
    return Scaffold(
      backgroundColor: Color(0xFFE5E5E5),
      appBar: AppBar(title: AppBarTitle()),
      body: OrientationBuilder(
        builder: (context, orientation) => orientation == Orientation.portrait
            ? buildPortrait(context, teamController)
            : buildLandscape(context, teamController),
      ),
    );
  }

  Widget buildPortrait(BuildContext context, teamController) => Obx(
        () => Column(
          children: [
            SizedBox(height: 30),
            Expanded(
              child: teamController.isLoadingTeam.value
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : teamController.team == TeamDetails()
                      ? Center(
                          child: Text(
                            "No data found",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700),
                          ),
                        )
                      : Column(
                          children: [
                            TeamCrest(crest: teamController.team.crest!),
                            SizedBox(height: 20),
                            TeamFullDetails(team: teamController.team),
                          ],
                        ),
            ),
          ],
        ),
      );

  Widget buildLandscape(BuildContext context, teamController) => Obx(
        () => Column(
          children: [
            SizedBox(height: 30),
            Expanded(
              child: teamController.isLoadingTeam.value
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : teamController.team == TeamDetails()
                      ? Center(
                          child: Text(
                            "No data found",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700),
                          ),
                        )
                      : SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(height: 30),
                              TeamCrest(crest: teamController.team.crest!),
                              SizedBox(height: 20),
                              LandscapeTeamDetails(team: teamController.team),
                            ],
                          ),
                        ),
            ),
          ],
        ),
      );
}
