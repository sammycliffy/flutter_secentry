class EstateDetails {
  int? count;
  dynamic next;
  dynamic previous;
  List<Results>? results;

  EstateDetails({this.count, this.next, this.previous, this.results});

  EstateDetails.fromJson(Map<String, dynamic> json) {
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
  String? estateUser;
  String? estateUserCode;
  String? estateId;
  String? estateName;
  String? estateAddress;
  String? estateUserPhone;
  String? estateUserFullName;
  String? estateUserAddress;
  String? estateAdminPhone;
  String? estateDateCreated;
  bool? accepted;
  bool? exit;
  String? dateJoined;

  Results(
      {this.id,
      this.estateUser,
      this.estateUserCode,
      this.estateId,
      this.estateName,
      this.estateAddress,
      this.estateUserPhone,
      this.estateUserFullName,
      this.estateUserAddress,
      this.estateAdminPhone,
      this.estateDateCreated,
      this.accepted,
      this.exit,
      this.dateJoined});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    estateUser = json['estate_user'];
    estateUserCode = json['estate_user_code'];
    estateId = json['estate_id'];
    estateName = json['estate_name'];
    estateAddress = json['estate_address'];
    estateUserPhone = json['estate_user_phone'];
    estateUserFullName = json['estate_user_full_name'];
    estateUserAddress = json['estate_user_address'];
    estateAdminPhone = json['estate_admin_phone'];
    estateDateCreated = json['estate_date_created'];
    accepted = json['accepted'];
    exit = json['exit'];
    dateJoined = json['date_joined'];
  }
}
