class TeamResult {
  int? id;
  String? name;
  String? crest;
  int? wonMatches;
  int? goalFor;
  int? goalAgainst;

  TeamResult({
    this.id,
    this.name,
    this.crest,
    this.wonMatches,
    this.goalFor = 0,
    this.goalAgainst = 0,
  });

  TeamResult.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    crest = json['crest'];
    wonMatches = json['won_matches'];
    goalFor = json['goal_for'];
    goalAgainst = json['goal_against'];
  }
}
