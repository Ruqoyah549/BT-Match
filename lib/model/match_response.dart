class MatchResponse {
  Competition? competition;
  List<Match>? matches;

  MatchResponse({this.competition, this.matches});

  MatchResponse.fromJson(Map<String, dynamic> json) {
    competition = json['competition'] != null
        ? new Competition.fromJson(json['competition'])
        : null;
    if (json['matches'] != null) {
      matches = <Match>[];
      json['matches'].forEach((v) {
        matches!.add(new Match.fromJson(v));
      });
    }
  }
}

class Competition {
  int? id;
  String? name;
  String? code;
  String? type;
  String? emblem;

  Competition({this.id, this.name, this.code, this.type, this.emblem});

  Competition.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    type = json['type'];
    emblem = json['emblem'];
  }
}

class Match {
  Area? area;
  Competition? competition;
  int? id;
  String? utcDate;
  String? status;
  int? matchDay;
  String? stage;
  String? group;
  String? lastUpdated;
  HomeTeam? homeTeam;
  HomeTeam? awayTeam;
  Score? score;

  Match({
    this.area,
    this.competition,
    this.id,
    this.utcDate,
    this.status,
    this.matchDay,
    this.stage,
    this.group,
    this.lastUpdated,
    this.homeTeam,
    this.awayTeam,
    this.score,
  });

  Match.fromJson(Map<String, dynamic> json) {
    area = json['area'] != null ? new Area.fromJson(json['area']) : null;
    competition = json['competition'] != null
        ? new Competition.fromJson(json['competition'])
        : null;
    id = json['id'];
    utcDate = json['utcDate'];
    status = json['status'];
    matchDay = json['matchday'];
    stage = json['stage'];
    group = json['group'];
    lastUpdated = json['lastUpdated'];
    homeTeam = json['homeTeam'] != null
        ? new HomeTeam.fromJson(json['homeTeam'])
        : null;
    awayTeam = json['awayTeam'] != null
        ? new HomeTeam.fromJson(json['awayTeam'])
        : null;
    score = json['score'] != null ? new Score.fromJson(json['score']) : null;
  }
}

class Area {
  int? id;
  String? name;
  String? code;
  String? flag;

  Area({this.id, this.name, this.code, this.flag});

  Area.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    flag = json['flag'];
  }
}

class HomeTeam {
  int? id;
  String? name;
  String? shortName;
  String? tla;
  String? crest;

  HomeTeam({this.id, this.name, this.shortName, this.tla, this.crest});

  HomeTeam.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    shortName = json['shortName'];
    tla = json['tla'];
    crest = json['crest'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['shortName'] = this.shortName;
    data['tla'] = this.tla;
    data['crest'] = this.crest;
    return data;
  }
}

class Score {
  String? winner;
  String? duration;
  FullTime? fullTime;
  FullTime? halfTime;

  Score({this.winner, this.duration, this.fullTime, this.halfTime});

  Score.fromJson(Map<String, dynamic> json) {
    winner = json['winner'];
    duration = json['duration'];
    fullTime = json['fullTime'] != null
        ? new FullTime.fromJson(json['fullTime'])
        : null;
    halfTime = json['halfTime'] != null
        ? new FullTime.fromJson(json['halfTime'])
        : null;
  }
}

class FullTime {
  int? home;
  int? away;

  FullTime({this.home, this.away});

  FullTime.fromJson(Map<String, dynamic> json) {
    home = json['home'];
    away = json['away'];
  }
}
