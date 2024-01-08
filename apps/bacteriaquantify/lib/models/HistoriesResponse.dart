import "History.dart";

class HistoriesResponse {
  List<History>? message;
  String? status;

  HistoriesResponse({this.message, this.status});

  HistoriesResponse.fromJson(Map<String, dynamic> json) {
    if (json['message'] != null) {
      message = <History>[];
      json['message'].forEach((v) {
        message!.add(new History.fromJson(v));
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
