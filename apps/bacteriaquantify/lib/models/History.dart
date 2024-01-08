class History {
  int? iD;
  String? sampleName;
  String? localFileImage;

  History({this.iD, this.sampleName, this.localFileImage});

  History.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    sampleName = json['sampleName'];
    localFileImage = json['localFileImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['sampleName'] = this.sampleName;
    data['localFileImage'] = this.localFileImage;
    return data;
  }
}
