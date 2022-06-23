import 'dart:convert';
import 'dart:core';

import 'package:bt_match/model/team_details.dart';
import 'package:bt_match/services/base_client.dart';
import 'package:get/get.dart';

import 'base_controller.dart';

class TeamController extends GetxController with BaseController {
  final int teamID;

  TeamController({required this.teamID});

  var isLoadingTeam = false.obs;

  TeamDetails team = TeamDetails();

  @override
  void onInit() {
    fetchTeamDetails(teamID);
    super.onInit();
  }

  fetchTeamDetails(int teamID) async {
    isLoadingTeam(true);

    team = TeamDetails();

    var response =
        await BaseClient().get("/v4/teams/$teamID").catchError(handleError);

    isLoadingTeam(false);

    if (response == null) return;

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      team = TeamDetails.fromJson(body);
    }
  }
}
