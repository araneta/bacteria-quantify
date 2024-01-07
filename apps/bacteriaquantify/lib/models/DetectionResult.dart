import 'Bacteries.dart';

class DetectionResult {
  String? imageID;
  List<Bacteries>? bacteries;

  DetectionResult({this.imageID, this.bacteries});

  DetectionResult.fromJson(Map<String, dynamic> json) {
    imageID = json['imageID'];
    if (json['bacteries'] != null) {
      bacteries = <Bacteries>[];
      json['bacteries'].forEach((v) {
        bacteries!.add(new Bacteries.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageID'] = this.imageID;
    if (this.bacteries != null) {
      data['bacteries'] = this.bacteries!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
