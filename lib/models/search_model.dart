class SearchModel {
  int? count;
  dynamic next;
  dynamic previous;
  List<Results>? results;

  SearchModel({this.count, this.next, this.previous, this.results});

  SearchModel.fromJson(Map<String, dynamic> json) {
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
  String? fullName;
  String? email;
  String? phoneNumber;
  String? gender;
  String? role;
  String? address;
  bool? isEstateuser;
  bool? isEstateguard;

  Results(
      {this.fullName,
      this.email,
      this.phoneNumber,
      this.gender,
      this.address,
      this.role,
      this.isEstateuser,
      this.isEstateguard});

  Results.fromJson(Map<String, dynamic> json) {
    fullName = json['full_name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    gender = json['gender'];
    role = json['role'];
    address = json['address'];
    isEstateuser = json['is_estateuser'];
    isEstateguard = json['is_estateguard'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['full_name'] = this.fullName;
    data['email'] = this.email;
    data['phone_number'] = this.phoneNumber;
    data['gender'] = this.gender;
    data['role'] = this.role;
    data['address'] = this.address;
    data['is_estateuser'] = this.isEstateuser;
    data['is_estateguard'] = this.isEstateguard;
    return data;
  }
}
