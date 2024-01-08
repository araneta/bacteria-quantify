import 'package:bacteriaquantify/models/Bacteries.dart';

class DetailHistoryResponse {
  List<Bacteries>? message;
  String? status;

  DetailHistoryResponse({this.message, this.status});

  DetailHistoryResponse.fromJson(Map<String, dynamic> json) {
    if (json['message'] != null) {
      message = <Bacteries>[];
      json['message'].forEach((v) {
        message!.add(new Bacteries.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.message != null) {
      data['message'] = this.message!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}
