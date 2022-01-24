class CompanyDetails {
  int? count;
  dynamic next;
  dynamic previous;
  List<Results>? results;

  CompanyDetails({this.count, this.next, this.previous, this.results});

  CompanyDetails.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(new Results.fromJson(v));
      });
    }
  }
}

class Results {
  int? id;
  String? companyUser;
  String? companyUserCode;
  String? companyId;
  String? companyName;
  String? companyAddress;
  String? companyUserPhone;
  String? companyUserFullName;
  String? companyUserAddress;
  String? companyAdminPhone;
  String? companyDateCreated;
  bool? accepted;
  bool? exit;
  String? dateJoined;

  Results(
      {this.id,
      this.companyUser,
      this.companyUserCode,
      this.companyId,
      this.companyName,
      this.companyAddress,
      this.companyUserPhone,
      this.companyUserFullName,
      this.companyUserAddress,
      this.companyAdminPhone,
      this.companyDateCreated,
      this.accepted,
      this.exit,
      this.dateJoined});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyUser = json['company_user'];
    companyUserCode = json['company_user_code'];
    companyId = json['company_id'];
    companyName = json['company_name'];
    companyAddress = json['company_address'];
    companyUserPhone = json['company_user_phone'];
    companyUserFullName = json['company_user_full_name'];
    companyUserAddress = json['company_user_address'];
    companyAdminPhone = json['company_admin_phone'];
    companyDateCreated = json['company_date_created'];
    accepted = json['accepted'];
    exit = json['exit'];
    dateJoined = json['date_joined'];
  }
}
