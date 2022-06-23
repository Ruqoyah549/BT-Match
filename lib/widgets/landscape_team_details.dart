import 'package:bt_match/model/match_response.dart';
import 'package:bt_match/model/team_details.dart';
import 'package:bt_match/widgets/sized_image.dart';
import 'package:bt_match/widgets/team_label.dart';
import 'package:flutter/material.dart';

class LandscapeTeamDetails extends StatelessWidget {
  const LandscapeTeamDetails({
    Key? key,
    required this.team,
  }) : super(key: key);

  final TeamDetails team;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 50, right: 50.0),
      child: Column(
        children: [
          Text(
            "${team.name}",
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: 20),
          TeamLabel(
            label: "Founded: ",
            content: "${team.founded}",
          ),
          TeamLabel(
            label: "Address: ",
            content: "${team.address}",
          ),
          TeamLabel(
            label: "Website: ",
            content: "${team.website}",
          ),
          TeamLabel(
            label: "Stadium: ",
            content: "${team.venue}",
          ),
          SizedBox(height: 20),
          Text(
            "Running Competitions",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),
          team.runningCompetitions!.isEmpty
              ? Text(
                  "No running competitions found",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    Competition competition = team.runningCompetitions![index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Row(
                        children: [
                          SizedImage(
                            imageUrl: competition.emblem!,
                            size: 40,
                          ),
                          SizedBox(width: 30),
                          Text(
                            "${competition.name}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: team.runningCompetitions!.length,
                ),
        ],
      ),
    );
  }
}
