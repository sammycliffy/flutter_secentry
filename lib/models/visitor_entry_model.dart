class VisitorEntryModel {
  VisitorEntryModel({
    this.estateVisitorName,
    this.estateVisitorAddress,
    this.estateVisitorPhone,
    this.purposeOfVisit,
    this.duration,
    this.visitorId,
    this.itemPass,
    this.visitExpired,
  });

  String? estateVisitorName;
  String? estateVisitorAddress;
  String? estateVisitorPhone;
  String? purposeOfVisit;
  String? duration;
  String? visitorId;
  List<ItemPass>? itemPass;
  bool? visitExpired;

  factory VisitorEntryModel.fromJson(Map<String, dynamic> json) =>
      VisitorEntryModel(
        estateVisitorName: json["estate_visitor_name"],
        estateVisitorAddress: json["estate_visitor_address"],
        estateVisitorPhone: json["estate_visitor_phone"],
        purposeOfVisit: json["purpose_of_visit"],
        duration: json["duration"],
        visitorId: json["visitor_id"],
        itemPass: List<ItemPass>.from(
            json["item_pass"].map((x) => ItemPass.fromJson(x))),
        visitExpired: json["visit_expired"],
      );

  Map<String, dynamic> toJson() => {
        "estate_visitor_name": estateVisitorName,
        "estate_visitor_address": estateVisitorAddress,
        "estate_visitor_phone": estateVisitorPhone,
        "purpose_of_visit": purposeOfVisit,
        "duration": duration,
        "visitor_id": visitorId,
        "item_pass": List<dynamic>.from(itemPass!.map((x) => x.toJson())),
        "visit_expired": visitExpired,
      };
}

class ItemPass {
  ItemPass({
    this.id,
    this.itemName,
    this.quantity,
    this.description,
  });

  int? id;
  String? itemName;
  int? quantity;
  String? description;

  factory ItemPass.fromJson(Map<String, dynamic> json) => ItemPass(
        id: json["id"],
        itemName: json["item_name"],
        quantity: json["quantity"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "item_name": itemName,
        "quantity": quantity,
        "description": description,
      };
}
