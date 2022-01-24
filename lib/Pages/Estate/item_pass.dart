import 'package:flutter/material.dart';
import 'package:flutter_secentry/Pages/Estate/item_list.dart';
import 'package:flutter_secentry/constants/colors.dart';
import 'package:flutter_secentry/constants/images.dart';
import 'package:flutter_secentry/constants/spaces.dart';
import 'package:flutter_secentry/helpers/formvalidation.dart';
import 'package:flutter_secentry/helpers/providers/invitation.dart';
import 'package:flutter_secentry/helpers/providers/profile.dart';
import 'package:flutter_secentry/services/auth_service.dart';
import 'package:flutter_secentry/widget/button.dart';
import 'package:flutter_secentry/widget/loading.dart';
import 'package:provider/provider.dart';

class AddItemPass extends StatefulWidget {
  const AddItemPass({Key? key}) : super(key: key);

  @override
  State<AddItemPass> createState() => _AddItemPassState();
}

class _AddItemPassState extends State<AddItemPass> {
  final title = TextEditingController();
  final quantity = TextEditingController();
  final description = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final AuthServices _authServices = AuthServices();
  InvitationNotifier? _invitationNotifier;
  List<Item> listofItems = [
    Item(description: 'first item', quantity: 0, itemName: 'no title')
  ];
  @override
  Widget build(BuildContext context) {
    _invitationNotifier = context.watch<InvitationNotifier>();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    heightSpace(60),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Icons.arrow_back_ios)),
                        widthSpace(40),
                        const Text(
                          'Item pass',
                          style: TextStyle(fontSize: 25),
                        ),
                        widthSpace(40),
                        GestureDetector(
                          onTap: () {
                            listofItems.removeAt(0);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ItemList(
                                          listofItems: listofItems,
                                        )));
                          },
                          child: Container(
                            width: 80,
                            height: 30,
                            decoration: BoxDecoration(
                                color: kGreen,
                                borderRadius: BorderRadius.circular(5)),
                            child: Center(
                              child: Text(
                                (listofItems.length - 1).toString(),
                                style: TextStyle(color: kWhite),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    heightSpace(23),
                    SizedBox(
                        height: 40,
                        width: 500,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: listofItems.length,
                            itemBuilder: (context, index) {
                              return index == 0
                                  ? Container()
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6),
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                          bottom: 6,
                                          left: 5,
                                        ),
                                        width: 70,
                                        height: 30,
                                        decoration: BoxDecoration(
                                            color: kPrimary,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '${listofItems.indexOf(listofItems[index])}',
                                              style: const TextStyle(
                                                  color: kWhite, fontSize: 18),
                                            ),
                                            IconButton(
                                                onPressed: () => setState(() {
                                                      listofItems
                                                          .removeAt(index);
                                                    }),
                                                icon: const Icon(
                                                  Icons.delete,
                                                  color: kWhite,
                                                ))
                                          ],
                                        ),
                                      ),
                                    );
                            })),
                    heightSpace(23),
                    titleText(),
                    heightSpace(20),
                    quantityText(),
                    heightSpace(20),
                    descriptionText(),
                    heightSpace(50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [blueButton(), whiteButton()],
                    ),
                  ],
                ),
              ),
            ),
            Align(alignment: Alignment.bottomRight, child: background)
          ],
        ),
      ),
    );
  }

  addItem() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        listofItems.add(Item(
            itemName: title.text,
            quantity: int.parse(quantity.text),
            description: description.text));
      });
      title.clear();
      quantity.clear();
      description.clear();
    }
  }

  blueButton() => InkWell(
        onTap: () => addItem(),
        child: Container(
          width: 150,
          height: 40,
          decoration: BoxDecoration(
              color: kPrimary, borderRadius: BorderRadius.circular(5)),
          child: const Center(
            child: Text(
              'Add',
              style: TextStyle(color: kWhite, fontSize: 18),
            ),
          ),
        ),
      );

  whiteButton() => InkWell(
        onTap: () => validate(),
        child: Container(
          width: 150,
          height: 40,
          decoration: BoxDecoration(
              color: kWhite,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: kPrimary, width: 3)),
          child: const Center(
            child: Text(
              'Continue',
              style: TextStyle(color: kPrimary, fontSize: 18),
            ),
          ),
        ),
      );
  titleText() => TextFormField(
      controller: title,
      validator: (value) => FormValidation().stringValidation(title.text),
      decoration: const InputDecoration(
          fillColor: kGrayLight,
          filled: true,
          contentPadding: EdgeInsets.all(12),
          border: InputBorder.none,
          hintText: 'Item name'));

  quantityText() => TextFormField(
      controller: quantity,
      keyboardType: TextInputType.number,
      validator: (value) => FormValidation().stringValidation(quantity.text),
      decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(12),
          fillColor: kGrayLight,
          filled: true,
          border: InputBorder.none,
          hintText: 'Quantity'));

  descriptionText() => TextFormField(
      maxLines: 5,
      controller: description,
      keyboardType: TextInputType.text,
      validator: (value) => FormValidation().stringValidation(description.text),
      decoration: const InputDecoration(
          fillColor: kGrayLight,
          filled: true,
          contentPadding: EdgeInsets.all(12),
          border: InputBorder.none,
          hintText: 'Description'));
  validate() async {
    listofItems.removeAt(0);
    _invitationNotifier!.setItemPass(
        _invitationNotifier!.fullName,
        _invitationNotifier!.phoneNumber,
        _invitationNotifier!.duration,
        listofItems,
        null,
        null,
        null,
        _invitationNotifier!.purposeOfVisit);
    Navigator.pushNamed(context, '/visitor_info');
  }
}

class Item {
  String? itemName;
  int? quantity;
  String? description;

  Item({this.itemName, this.description, this.quantity});
  Map<String, dynamic> toJson() => {
        "item_name": itemName,
        "quantity": quantity,
        "description": description,
      };
}
