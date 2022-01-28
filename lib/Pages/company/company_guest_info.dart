import 'package:flutter/material.dart';
import 'package:flutter_secentry/constants/colors.dart';
import 'package:flutter_secentry/constants/spaces.dart';
import 'package:flutter_secentry/helpers/providers/profile.dart';
import 'package:flutter_secentry/models/company/company_visitor_model.dart';
import 'package:flutter_secentry/models/visitor_model.dart';
import 'package:flutter_secentry/services/guard/guard_services.dart';
import 'package:flutter_secentry/widget/button.dart';
import 'package:flutter_secentry/widget/loading.dart';
import 'package:provider/src/provider.dart';

class CompanyGuestInfo extends StatefulWidget {
  final CompanyVisitorModel? visitorModel;
  final int? index;
  const CompanyGuestInfo({Key? key, this.visitorModel, this.index})
      : super(key: key);

  @override
  _CompanyGuestInfoState createState() => _CompanyGuestInfoState();
}

class _CompanyGuestInfoState extends State<CompanyGuestInfo> {
  final GuardServices _guardServices = GuardServices();
  ProfileDataNotifier? _profileDataNotifier;
  @override
  Widget build(BuildContext context) {
    _profileDataNotifier = context.watch<ProfileDataNotifier>();
    return Scaffold(
        body: _profileDataNotifier!.loading
            ? const LoadingScreen()
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          heightSpace(80),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                    onPressed: () => Navigator.pop(context),
                                    icon: Icon(Icons.arrow_back_ios)),
                                heightSpace(50),
                                const Text(
                                  'Guest Info',
                                  style: TextStyle(fontSize: 25),
                                ),
                                widthSpace(60),
                              ]),

                          heightSpace(30),

                          text('Visitor name',
                              '${widget.visitorModel!.results?[widget.index!].companyVisitorName}'),
                          const Divider(),
                          heightSpace(20),
                          text('Host name',
                              '${widget.visitorModel!.results?[widget.index!].companyUserFullname}'),
                          const Divider(),
                          heightSpace(20),
                          text('Host phone',
                              '${widget.visitorModel!.results?[widget.index!].companyUserPhoneNumber}'),
                          const Divider(),
                          heightSpace(20),
                          text('Country',
                              '${widget.visitorModel!.results?[widget.index!].country}'),
                          const Divider(),
                          heightSpace(20),
                          text('State',
                              '${widget.visitorModel!.results?[widget.index!].state}'),
                          const Divider(),
                          heightSpace(20),
                          text('Visitor Address',
                              '${widget.visitorModel!.results?[widget.index!].companyVisitorAddress}'),
                          const Divider(),
                          heightSpace(20),
                          text('Phone Number',
                              '${widget.visitorModel!.results?[widget.index!].companyVisitorPhone}'),
                          const Divider(),
                          heightSpace(20),
                          text('Purpose of visit',
                              '${widget.visitorModel!.results?[widget.index!].purposeOfVisit}'),
                          Divider(),
                          heightSpace(20),
                          text('Vehicle Model',
                              '${widget.visitorModel!.results?[widget.index!].vehicleModel}'),
                          Divider(),
                          heightSpace(20),
                          text('Vehicle Colour',
                              '${widget.visitorModel!.results?[widget.index!].vehicleColor}'),
                          Divider(),
                          heightSpace(20),
                          text('Vehicle Plate',
                              '${widget.visitorModel!.results?[widget.index!].vehiclePlate}'),
                          const Divider(),
                          heightSpace(20),
                          text('Time',
                              '${widget.visitorModel!.results?[widget.index!].duration}'),
                          Divider(),
                          heightSpace(20),
                          text('Visitor ID',
                              '${widget.visitorModel!.results?[widget.index!].visitorId}'),
                          Divider(),
                          heightSpace(50),
                          // CustomButton(text: 'Approve', validate: validate),
                          heightSpace(50),
                        ],
                      ),
                    )
                  ],
                ),
              ));
  }

  text(title, text) => Column(
        // ignore: prefer_const_literals_to_create_immutables
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(color: kGray, fontSize: 15),
          ),
          Text(
            text,
            style: const TextStyle(fontSize: 20),
          )
        ],
      );

  validate() async {
    _profileDataNotifier!.setLoading(true);
    dynamic result = await _guardServices.approveVisitor(
        context, widget.visitorModel!.results?[0].id);
    if (result) {
      _profileDataNotifier!.setLoading(false);
      Navigator.pushNamed(context, '/entry_approved');
    } else {
      _profileDataNotifier!.setLoading(false);
    }
  }
}
