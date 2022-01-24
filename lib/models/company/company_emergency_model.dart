class CompanyEmergencyModel {
  CompanyEmergencyModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int? count;
  dynamic next;
  dynamic previous;
  List<Result>? results;

  factory CompanyEmergencyModel.fromJson(Map<String, dynamic> json) =>
      CompanyEmergencyModel(
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
    this.companyId,
    this.contactName,
    this.contactPhone,
    this.contactDesignation,
    this.dateAdded,
  });

  int? id;
  String? companyId;
  String? contactName;
  String? contactPhone;
  String? contactDesignation;
  DateTime? dateAdded;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        companyId: json["estate_id"],
        contactName: json["contact_name"],
        contactPhone: json["contact_phone"],
        contactDesignation: json["contact_designation"],
        dateAdded: DateTime.parse(json["date_added"]),
      );
}
