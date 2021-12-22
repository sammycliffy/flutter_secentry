class EstateMessage {
  int? count;
  String? next;
  String? previous;
  List<Results>? results;

  EstateMessage({this.count, this.next, this.previous, this.results});

  EstateMessage.fromJson(Map<String, dynamic> json) {
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
  String? estateId;
  String? estateUserPhone;
  String? message;
  String? time;

  Results(
      {this.id, this.estateId, this.estateUserPhone, this.message, this.time});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    estateId = json['estate_id'];
    estateUserPhone = json['estate_user_phone'];
    message = json['message'];
    time = json['time'];
  }
}
