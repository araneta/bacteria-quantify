class Bacteries {
  int? iD;
  String? species;
  int? totalColony;

  Bacteries({this.iD, this.species, this.totalColony});

  Bacteries.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    species = json['species'];
    totalColony = json['totalColony'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['species'] = this.species;
    data['totalColony'] = this.totalColony;
    return data;
  }
}
