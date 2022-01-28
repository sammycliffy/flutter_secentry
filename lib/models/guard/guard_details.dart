class GuardModel {
  int? count;
  Null? next;
  Null? previous;
  List<Results>? results;

  GuardModel({this.count, this.next, this.previous, this.results});

  GuardModel.fromJson(Map<String, dynamic> json) {
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['next'] = this.next;
    data['previous'] = this.previous;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  int? id;
  String? guardUser;
  String? guardUserPhoneNumber;
  String? guardUserFullName;
  String? guardUserAddress;
  String? guardUserGender;
  String? guardUserPhone;
  dynamic facilityId;
  String? facilityName;
  String? facilityAddress;
  String? facilityAdminPhone;
  dynamic companyId;
  String? companyName;
  String? companyAddress;
  String? companyAdminPhone;
  bool? disable;
  String? dateCreated;
  String? dateModified;

  Results(
      {this.id,
      this.guardUser,
      this.guardUserPhoneNumber,
      this.guardUserFullName,
      this.guardUserAddress,
      this.guardUserGender,
      this.guardUserPhone,
      this.facilityId,
      this.facilityName,
      this.facilityAddress,
      this.facilityAdminPhone,
      this.companyId,
      this.companyName,
      this.companyAddress,
      this.companyAdminPhone,
      this.disable,
      this.dateCreated,
      this.dateModified});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    guardUser = json['guard_user'];
    guardUserPhoneNumber = json['guard_user_phone_number'];
    guardUserFullName = json['guard_user_full_name'];
    guardUserAddress = json['guard_user_address'];
    guardUserGender = json['guard_user_gender'];
    guardUserPhone = json['guard_user_phone'];
    facilityId = json['facility_id'];
    facilityName = json['facility_name'];
    facilityAddress = json['facility_address'];
    facilityAdminPhone = json['facility_admin_phone'];
    companyId = json['company_id'];
    companyName = json['company_name'];
    companyAddress = json['company_address'];
    companyAdminPhone = json['company_admin_phone'];
    disable = json['disable'];
    dateCreated = json['date_created'];
    dateModified = json['date_modified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['guard_user'] = this.guardUser;
    data['guard_user_phone_number'] = this.guardUserPhoneNumber;
    data['guard_user_full_name'] = this.guardUserFullName;
    data['guard_user_address'] = this.guardUserAddress;
    data['guard_user_gender'] = this.guardUserGender;
    data['guard_user_phone'] = this.guardUserPhone;
    data['facility_id'] = this.facilityId;
    data['facility_name'] = this.facilityName;
    data['facility_address'] = this.facilityAddress;
    data['facility_admin_phone'] = this.facilityAdminPhone;
    data['company_id'] = this.companyId;
    data['company_name'] = this.companyName;
    data['company_address'] = this.companyAddress;
    data['company_admin_phone'] = this.companyAdminPhone;
    data['disable'] = this.disable;
    data['date_created'] = this.dateCreated;
    data['date_modified'] = this.dateModified;
    return data;
  }
}
