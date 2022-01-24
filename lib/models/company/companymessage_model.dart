class CompanyMessage {
  int? count;
  String? next;
  String? previous;
  List<Results>? results;

  CompanyMessage({this.count, this.next, this.previous, this.results});

  CompanyMessage.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
      });
    }
  }
}

class Results {
  int? id;
  String? companyId;
  String? companyUserPhone;
  String? message;
  String? time;

  Results(
      {this.id,
      this.companyId,
      this.companyUserPhone,
      this.message,
      this.time});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyId = json['company_id'];
    companyUserPhone = json['company_user_phone'];
    message = json['message'];
    time = json['time'];
  }
}
