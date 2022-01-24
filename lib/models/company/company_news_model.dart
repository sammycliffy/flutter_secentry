class CompanyNewsModel {
  CompanyNewsModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int? count;
  String? next;
  String? previous;
  List<Result>? results;

  factory CompanyNewsModel.fromJson(Map<String, dynamic> json) =>
      CompanyNewsModel(
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
    this.subject,
    this.body,
    this.dateAdded,
  });

  int? id;
  String? companyId;
  String? subject;
  String? body;
  DateTime? dateAdded;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        companyId: json["estate_id"],
        subject: json["subject"],
        body: json["body"],
        dateAdded: DateTime.parse(json["date_added"]),
      );
}
