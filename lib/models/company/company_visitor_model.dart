class CompanyVisitorModel {
  int? count;
  dynamic next;
  dynamic previous;
  List<Results>? results;

  CompanyVisitorModel({this.count, this.next, this.previous, this.results});

  CompanyVisitorModel.fromJson(Map<String, dynamic> json) {
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
  String? companyId;
  String? companyUserFullname;
  String? companyUserAddress;
  String? companyUserGender;
  String? companyUserRole;
  String? companyUserPhoneNumber;
  List<ItemPass>? itemPass;
  String? visitorId;
  String? companyUserPhone;
  String? companyVisitorName;
  String? companyVisitorAddress;
  String? country;
  String? state;
  String? companyVisitorPhone;
  String? purposeOfVisit;
  String? vehicleModel;
  String? vehicleColor;
  String? vehiclePlate;
  int? duration;
  bool? approved;
  bool? checkOut;
  String? dateJoined;
  String? timeApproved;
  String? timeCheckout;

  Results(
      {this.id,
      this.companyUser,
      this.companyId,
      this.companyUserFullname,
      this.companyUserAddress,
      this.companyUserGender,
      this.companyUserRole,
      this.companyUserPhoneNumber,
      this.itemPass,
      this.visitorId,
      this.companyUserPhone,
      this.companyVisitorName,
      this.companyVisitorAddress,
      this.country,
      this.state,
      this.companyVisitorPhone,
      this.purposeOfVisit,
      this.vehicleModel,
      this.vehicleColor,
      this.vehiclePlate,
      this.duration,
      this.approved,
      this.checkOut,
      this.dateJoined,
      this.timeApproved,
      this.timeCheckout});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyUser = json['company_user'];
    companyId = json['company_id'];
    companyUserFullname = json['company_user_fullname'];
    companyUserAddress = json['company_user_address'];
    companyUserGender = json['company_user_gender'];
    companyUserRole = json['company_user_role'];
    companyUserPhoneNumber = json['company_user_phone_number'];
    if (json['item_pass'] != null) {
      itemPass = <ItemPass>[];
      json['item_pass'].forEach((v) {
        itemPass!.add(new ItemPass.fromJson(v));
      });
    }
    visitorId = json['visitor_id'];
    companyUserPhone = json['company_user_phone'];
    companyVisitorName = json['company_visitor_name'];
    companyVisitorAddress = json['company_visitor_address'];
    country = json['country'];
    state = json['state'];
    companyVisitorPhone = json['company_visitor_phone'];
    purposeOfVisit = json['purpose_of_visit'];
    vehicleModel = json["vehicle_model"];
    vehicleColor = json['vehicle_color'];
    vehiclePlate = json['vehicle_plate_number'];
    duration = json['duration'];
    approved = json['approved'];
    checkOut = json['check_out'];
    dateJoined = json['date_joined'];
    timeApproved = json['time_approved'];
    timeCheckout = json['time_checkout'];
  }
}

class ItemPass {
  int? id;
  String? itemName;
  int? quantity;
  String? description;

  ItemPass({this.id, this.itemName, this.quantity, this.description});

  ItemPass.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemName = json['item_name'];
    quantity = json['quantity'];
    description = json['description'];
  }
}
