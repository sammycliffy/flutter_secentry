class EstateInformation {
  int? id;
  String? estateUser;
  String? estateUserPhoneNumber;
  String? estateUserFullName;
  String? estateUserAddress;
  String? estateUserGender;
  String? estateUserRole;
  String? estateId;
  String? estateUserCode;
  bool? accepted;
  bool? exit;
  String? dateJoined;

  EstateInformation(
      {this.id,
      this.estateUser,
      this.estateUserPhoneNumber,
      this.estateUserFullName,
      this.estateUserAddress,
      this.estateUserGender,
      this.estateUserRole,
      this.estateId,
      this.estateUserCode,
      this.accepted,
      this.exit,
      this.dateJoined});

  factory EstateInformation.fromJson(Map<String, dynamic> json) =>
      EstateInformation(
        id: json['id'],
        estateUser: json['estate_user'],
        estateUserPhoneNumber: json['estate_user_phone_number'],
        estateUserFullName: json['estate_user_full_name'],
        estateUserAddress: json['estate_user_address'],
        estateUserGender: json['estate_user_gender'],
        estateUserRole: json['estate_user_role'],
        estateId: json['estate_id'],
        estateUserCode: json['estate_user_code'],
        accepted: json['accepted'],
        exit: json['exit'],
        dateJoined: json['date_joined'],
      );
}
