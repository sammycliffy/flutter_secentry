class UserModel {
  String? key;
  String? status;
  String? userId;
  String? email;
  String? fullName;
  String? phoneNumber;
  String? address;
  String? gender;
  String? role;
  bool? isEstateuser;
  bool? isCompanyuser;
  bool? isGuard;
  String? belongEstateId;
  String? belongEstateName;
  String? belongCompanyId;
  String? belongCompanyName;
  String? belongCompanyEstateId;
  String? createdFacilityId;
  String? createdFacilityName;
  String? createdCompanyId;
  String? createdCompanyName;
  String? createdCompanyEstateId;
  bool? createdFacility;
  bool? belongToEstate;
  String? belongToEstateidGuard;
  String? belongToEstatenameGuard;
  String? belongToEstateaddressGuard;
  String? belongToEstateadminphoneGuard;
  String? activeSubscription;
  String? verified;

  UserModel({
    required this.key,
    required this.status,
    required this.userId,
    required this.email,
    required this.fullName,
    required this.phoneNumber,
    required this.address,
    required this.gender,
    required this.role,
    required this.isEstateuser,
    required this.isCompanyuser,
    required this.isGuard,
    required this.belongEstateId,
    required this.belongEstateName,
    required this.belongCompanyId,
    required this.belongCompanyName,
    required this.belongCompanyEstateId,
    required this.createdFacilityId,
    required this.createdFacilityName,
    required this.createdCompanyId,
    required this.createdCompanyName,
    required this.createdCompanyEstateId,
    required this.createdFacility,
    required this.belongToEstate,
    required this.belongToEstateidGuard,
    required this.belongToEstatenameGuard,
    required this.belongToEstateaddressGuard,
    required this.belongToEstateadminphoneGuard,
    required this.activeSubscription,
    required this.verified,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    status = json['status'];
    userId = json['user_id'];
    email = json['email'];
    fullName = json['full_name'];
    phoneNumber = json['phone_number'];
    address = json['address'];
    gender = json['gender'];
    role = json['role'];
    isEstateuser = json['is_estateuser'];
    isCompanyuser = json['is_companyuser'];
    isGuard = json['is_guard'];
    belongEstateId = json['belong_estate_id'];
    belongEstateName = json['belong_estate_name'];
    belongCompanyId = json['belong_company_id'];
    belongCompanyName = json['belong_company_name'];
    belongCompanyEstateId = json['belong_company_estate_id'];
    createdFacilityId = json['created_facility_id'];
    createdFacilityName = json['created_facility_name'];
    createdCompanyId = json['created_company_id'];
    createdCompanyName = json['created_company_name'];
    createdCompanyEstateId = json['created_company_estate_id'];
    createdFacility = json['created_facility'];
    belongToEstate = json['belong_to_estate'];
    belongToEstateidGuard = json['belong_to_estateid_guard'];
    belongToEstatenameGuard = json['belong_to_estatename_guard'];
    belongToEstateaddressGuard = json['belong_to_estateaddress_guard'];
    belongToEstateadminphoneGuard = json['belong_to_estateadminphone_guard'];
    activeSubscription = json['active_subscription'];
    verified = json['verified'];
  }
}
