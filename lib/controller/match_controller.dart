import 'dart:convert';
import 'dart:core';

import 'package:bt_match/model/match_response.dart';
import 'package:bt_match/model/team_details.dart';
import 'package:bt_match/model/team_result.dart';
import 'package:bt_match/services/base_client.dart';
import 'package:bt_match/utils/constants.dart';
import 'package:get/get.dart';

import 'base_controller.dart';
import 'home_controller.dart';

class MatchController extends GetxController with BaseController {
  var isLoadingMatch = false.obs;
  var isLoadingDetails = false.obs;

  var filteredResults = <TeamResult>[];

  var finalResult = TeamResult(name: "");

  DateTime? thirtyDaysAgo;

  TeamDetails teamDetails = TeamDetails();

  final homeController = Get.find<HomeController>();

  @override
  void onInit() {
    fetchMatch();
    super.onInit();
  }

  // Add leading zero to single digit month or day as requested by API resources
  String addLeadingZero(DateTime date) {
    var month =
        date.month.toString().length == 1 ? "0${date.month}" : date.month;

    var day = date.day.toString().length == 1 ? "0${date.day}" : date.day;

    var formattedDate = "${date.year}-$month-$day";

    return formattedDate;
  }

  // Fetch match competitions from 30 days ago with selected date
  fetchMatch() async {
    var matches = <Match>[];

    finalResult = TeamResult(name: "");

    // Premier League 2021/2022 last game date was May 22, 2022
    // Last date game will be used if user select any date after May 22, 2022
    if (homeController.selectedDate!.isAfter(DateTime(2022, 05, 22))) {
      homeController.selectedDate = DateTime(2022, 05, 22);
    }

    // calculate 30days ago from selected date
    thirtyDaysAgo =
        homeController.selectedDate!.subtract(new Duration(days: 30));

    String dateFrom = addLeadingZero(thirtyDaysAgo!);
    String dateTo = addLeadingZero(homeController.selectedDate!);

    // Populate filteredResults with a fresh list of team with 0 values
    filteredResults = homeController.allTeam
        .map((element) => TeamResult(
              id: element.id,
              name: element.name,
              crest: element.crest,
              wonMatches: element.wonMatches,
              goalFor: element.goalFor,
              goalAgainst: element.goalAgainst,
            ))
        .toList();

    isLoadingMatch(true);

    var response = await BaseClient()
        .get(MATCH_API + "&dateFrom=$dateFrom&dateTo=$dateTo")
        .catchError(handleError);

    if (response == null) {
      isLoadingMatch(false);
      return;
    }

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      matches = MatchResponse.fromJson(body).matches!;

      // Loop through matches result
      matches.forEach((match) {
        if (match.score!.winner == "HOME_TEAM") {
          updateHomeWinTeam(match.homeTeam!, match.score!);
          updateAwayLoseTeam(match.awayTeam!, match.score!);
        } else if (match.score!.winner == "AWAY_TEAM") {
          updateAwayWinTeam(match.awayTeam!, match.score!);
          updateHomeLoseTeam(match.homeTeam!, match.score!);
        } else {
          updateHomeDrawTeam(match.homeTeam!, match.score!);
          updateAwayDrawTeam(match.awayTeam!, match.score!);
        }
      });

      // Sort the list in descending order with won_matches property
      // then goal difference (if 2 0r more teams has same number of matches)
      // to get winning team
      filteredResults.sort((b, a) {
        if (a.wonMatches! == b.wonMatches!) {
          return (a.goalFor! - a.goalAgainst!)
              .compareTo(b.goalFor! - b.goalAgainst!);
        } else {
          return a.wonMatches!.compareTo(b.wonMatches!);
        }
      });

      // Select the first item in the sorted list as the winner
      finalResult = TeamResult(
        id: filteredResults[0].id,
        name: filteredResults[0].name,
        crest: filteredResults[0].crest,
        wonMatches: filteredResults[0].wonMatches,
        goalFor: filteredResults[0].goalFor,
        goalAgainst: filteredResults[0].goalAgainst,
      );

      // Fetch team details of the winner
      await fetchTeamDetails(finalResult.id!);
      isLoadingMatch(false);
    }
  }

  // Update the filteredResults when Home Team wins
  void updateHomeWinTeam(HomeTeam team, Score score) {
    filteredResults.forEach((element) {
      if (element.name == team.name) {
        element.wonMatches = element.wonMatches! + 1;
        element.goalFor = (element.goalFor! + score.fullTime!.home!);
        element.goalAgainst = element.goalAgainst! + score.fullTime!.away!;
      }
    });
  }

  // Update the filteredResults when Away Team lose
  void updateAwayLoseTeam(HomeTeam team, Score score) {
    filteredResults.forEach((element) {
      if (element.name == team.name) {
        element.goalFor = element.goalFor! + score.fullTime!.away!;
        element.goalAgainst = element.goalAgainst! + score.fullTime!.home!;
      }
    });
  }

  // Update the filteredResults when Away Team wins
  void updateAwayWinTeam(HomeTeam team, Score score) {
    filteredResults.forEach((element) {
      if (element.name == team.name) {
        element.wonMatches = element.wonMatches! + 1;
        element.goalFor = element.goalFor! + score.fullTime!.away!;
        element.goalAgainst = element.goalAgainst! + score.fullTime!.home!;
      }
    });
  }

  // Update the filteredResults when Home Team lose
  void updateHomeLoseTeam(HomeTeam team, Score score) {
    filteredResults.forEach((element) {
      if (element.name == team.name) {
        element.goalFor = element.goalFor! + score.fullTime!.home!;
        element.goalAgainst = element.goalAgainst! + score.fullTime!.away!;
      }
    });
  }

  // Update the filteredResults when Home Team draws
  void updateHomeDrawTeam(HomeTeam team, Score score) {
    filteredResults.forEach((element) {
      if (element.name == team.name) {
        element.goalFor = element.goalFor! + score.fullTime!.home!;
        element.goalAgainst = element.goalAgainst! + score.fullTime!.away!;
      }
    });
  }

  // Update the filteredResults when Away Team draws
  void updateAwayDrawTeam(HomeTeam team, Score score) {
    filteredResults.forEach((element) {
      if (element.name == team.name) {
        element.goalFor = element.goalFor! + score.fullTime!.away!;
        element.goalAgainst = element.goalAgainst! + score.fullTime!.home!;
      }
    });
  }

  //Fetch details of a football team
  fetchTeamDetails(int teamID) async {
    isLoadingDetails(true);

    teamDetails = TeamDetails();

    var response =
        await BaseClient().get("/v4/teams/$teamID").catchError(handleError);

    isLoadingDetails(false);

    if (response == null) return;

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      teamDetails = TeamDetails.fromJson(body);
    }
  }
}
