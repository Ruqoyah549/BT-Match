import 'package:bt_match/model/team_details.dart';
import 'package:bt_match/widgets/team_details_widget.dart';
import 'package:flutter/material.dart';

class TeamFullDetails extends StatelessWidget {
  const TeamFullDetails({
    Key? key,
    required this.team,
  }) : super(key: key);

  final TeamDetails team;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: TeamDetailsWidget(team: team),
      ),
    );
  }
}
