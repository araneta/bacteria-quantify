import 'Bacteries.dart';
import 'DetectionResult.dart';

class DetectionResultResponse {
  int? status;
  DetectionResult? message;

  DetectionResultResponse({this.status, this.message});

  DetectionResultResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'] != null
        ? new DetectionResult.fromJson(json['message'])
        : null;
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
