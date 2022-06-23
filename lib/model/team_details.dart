import 'match_response.dart';

class TeamDetails {
  Area? area;
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
  List<Competition>? runningCompetitions;

  TeamDetails({
    this.area,
    this.id,
    this.name,
    this.shortName,
    this.tla,
    this.crest,
    this.address,
    this.website,
    this.founded,
    this.clubColors,
    this.venue,
    this.runningCompetitions,
  });

  TeamDetails.fromJson(Map<String, dynamic> json) {
    area = json['area'] != null ? new Area.fromJson(json['area']) : null;
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
    if (json['runningCompetitions'] != null) {
      runningCompetitions = <Competition>[];
      json['runningCompetitions'].forEach((v) {
        runningCompetitions!.add(new Competition.fromJson(v));
      });
    }
  }
}
