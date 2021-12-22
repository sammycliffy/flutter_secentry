class EmergencyModel {
  EmergencyModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int? count;
  dynamic next;
  dynamic previous;
  List<Result>? results;

  factory EmergencyModel.fromJson(Map<String, dynamic> json) => EmergencyModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );
}

class Result {
  Result({
    this.id,
    this.estateId,
    this.contactName,
    this.contactPhone,
    this.contactDesignation,
    this.dateAdded,
  });

  int? id;
  String? estateId;
  String? contactName;
  String? contactPhone;
  String? contactDesignation;
  DateTime? dateAdded;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        estateId: json["estate_id"],
        contactName: json["contact_name"],
        contactPhone: json["contact_phone"],
        contactDesignation: json["contact_designation"],
        dateAdded: DateTime.parse(json["date_added"]),
      );
}
