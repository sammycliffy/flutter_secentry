class EstateDetails {
  EstateDetails({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int? count;
  dynamic next;
  dynamic previous;
  List<Result>? results;

  factory EstateDetails.fromJson(Map<String, dynamic> json) => EstateDetails(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );
}

class Result {
  Result({
    this.estateAdminPhone,
    this.estateUserPhone,
    this.estateId,
    this.estateName,
    this.estateAddress,
    this.estateDateCreated,
  });

  String? estateAdminPhone;
  String? estateUserPhone;
  String? estateId;
  String? estateName;
  String? estateAddress;
  DateTime? estateDateCreated;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        estateAdminPhone: json["estate_admin_phone"],
        estateUserPhone: json["estate_user_phone"],
        estateId: json["estate_id"],
        estateName: json["estate_name"],
        estateAddress: json["estate_address"],
        estateDateCreated: DateTime.parse(json["estate_date_created"]),
      );
}
