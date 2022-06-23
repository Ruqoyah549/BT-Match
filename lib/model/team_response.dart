import 'match_response.dart';

class TeamResponse {
  int? count;
  Competition? competition;
  List<Team>? teams;

  TeamResponse({this.count, this.competition, this.teams});

  TeamResponse.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    competition = json['competition'] != null
        ? new Competition.fromJson(json['competition'])
        : null;
    if (json['teams'] != null) {
      teams = <Team>[];
      json['teams'].forEach((v) {
        teams!.add(new Team.fromJson(v));
      });
    }
  }
}

class Team {
  int? id;
  String? name;
  String? shortName;
  String? tla;
  String? crest;
  String? address;
  String? website;
  int? founded;
  String? clubColors;
  String? venue;
  String? lastUpdated;

  Team(
      {this.id,
      this.name,
      this.shortName,
      this.tla,
      this.crest,
      this.address,
      this.website,
      this.founded,
      this.clubColors,
      this.venue,
      this.lastUpdated});

  Team.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    shortName = json['shortName'];
    tla = json['tla'];
    crest = json['crest'];
    address = json['address'];
    website = json['website'];
    founded = json['founded'];
    clubColors = json['clubColors'];
    venue = json['venue'];
    lastUpdated = json['lastUpdated'];
  }
}
