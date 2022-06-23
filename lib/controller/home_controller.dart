import 'dart:convert';
import 'dart:core';

import 'package:bt_match/model/team_response.dart';
import 'package:bt_match/model/team_result.dart';
import 'package:bt_match/services/base_client.dart';
import 'package:get/get.dart';

import 'base_controller.dart';

class HomeController extends GetxController with BaseController {
  var isLoading = false.obs;

  var teams = <Team>[];

  var allTeam = <TeamResult>[];

  DateTime? selectedDate;

  @override
  void onInit() {
    // Initialized selected date with today's date
    selectedDate = DateTime.now();

    fetchTeam();
    super.onInit();
  }

  // Add Team to a list if it does not exist in the list
  void addItemToList(TeamResult data) async {
    bool exist = checkIfExist(data);
    if (!exist) {
      allTeam.add(data);
    }
  }

  // Check if a team exist in the list
  bool checkIfExist(TeamResult data) {
    bool exist = false;
    allTeam.forEach((element) {
      if (element.name == data.name) {
        exist = true;
      }
    });
    return exist;
  }

  // Get list of all teams in 2021/2022 Premier League
  fetchTeam() async {
    isLoading(true);

    var response = await BaseClient()
        .get("/v4/competitions/PL/teams?season=2021")
        .catchError(handleError);

    isLoading(false);

    if (response == null) return;

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      teams = TeamResponse.fromJson(body).teams!;

      // Populate each team with an initial won match of 0, goalFor 0 and goalAgainst 0
      teams.forEach((team) {
        var item = TeamResult(
          name: team.name,
          id: team.id,
          crest: team.crest,
          wonMatches: 0,
          goalFor: 0,
          goalAgainst: 0,
        );
        addItemToList(item);
      });
    }
  }
}
