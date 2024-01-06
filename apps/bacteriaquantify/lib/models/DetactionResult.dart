import 'Bacteries.dart';

class DetectionResult {
  int? status;
  Message? message;

  DetectionResult({this.status, this.message});

  DetectionResult.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message =
        json['message'] != null ? new Message.fromJson(json['message']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.message != null) {
      data['message'] = this.message!.toJson();
    }
    return data;
  }
}

class Message {
  String? imageID;
  List<Bacteries>? bacteries;

  Message({this.imageID, this.bacteries});

  Message.fromJson(Map<String, dynamic> json) {
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
