class EstateNews {
  EstateNews({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int? count;
  String? next;
  String? previous;
  List<Result>? results;

  factory EstateNews.fromJson(Map<String, dynamic> json) => EstateNews(
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
    this.subject,
    this.body,
    this.dateAdded,
  });

  int? id;
  String? estateId;
  String? subject;
  String? body;
  DateTime? dateAdded;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        estateId: json["estate_id"],
        subject: json["subject"],
        body: json["body"],
        dateAdded: DateTime.parse(json["date_added"]),
      );
}
