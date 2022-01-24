class VisitorModel {
  int? count;
  dynamic next;
  dynamic previous;
  List<Results>? results;

  VisitorModel({this.count, this.next, this.previous, this.results});

  VisitorModel.fromJson(Map<String, dynamic> json) {
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
  String? estateId;
  String? estateUserFullname;
  String? estateUserAddress;
  String? estateUserGender;
  String? estateUserRole;
  String? estateUserPhoneNumber;
  List<ItemPass>? itemPass;
  String? visitorId;
  String? estateUserPhone;
  String? estateVisitorName;
  String? estateVisitorAddress;
  String? country;
  String? state;
  String? estateVisitorPhone;
  String? purposeOfVisit;
  int? duration;
  bool? approved;
  bool? checkOut;
  String? dateJoined;
  String? timeApproved;
  String? timeCheckout;

  Results(
      {this.id,
      this.estateUser,
      this.estateId,
      this.estateUserFullname,
      this.estateUserAddress,
      this.estateUserGender,
      this.estateUserRole,
      this.estateUserPhoneNumber,
      this.itemPass,
      this.visitorId,
      this.estateUserPhone,
      this.estateVisitorName,
      this.estateVisitorAddress,
      this.country,
      this.state,
      this.estateVisitorPhone,
      this.purposeOfVisit,
      this.duration,
      this.approved,
      this.checkOut,
      this.dateJoined,
      this.timeApproved,
      this.timeCheckout});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    estateUser = json['estate_user'];
    estateId = json['estate_id'];
    estateUserFullname = json['estate_user_fullname'];
    estateUserAddress = json['estate_user_address'];
    estateUserGender = json['estate_user_gender'];
    estateUserRole = json['estate_user_role'];
    estateUserPhoneNumber = json['estate_user_phone_number'];
    if (json['item_pass'] != null) {
      itemPass = <ItemPass>[];
      json['item_pass'].forEach((v) {
        itemPass!.add(new ItemPass.fromJson(v));
      });
    }
    visitorId = json['visitor_id'];
    estateUserPhone = json['estate_user_phone'];
    estateVisitorName = json['estate_visitor_name'];
    estateVisitorAddress = json['estate_visitor_address'];
    country = json['country'];
    state = json['state'];
    estateVisitorPhone = json['estate_visitor_phone'];
    purposeOfVisit = json['purpose_of_visit'];
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
