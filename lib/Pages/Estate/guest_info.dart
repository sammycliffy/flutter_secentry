import 'package:flutter/material.dart';
import 'package:flutter_secentry/constants/colors.dart';
import 'package:flutter_secentry/constants/spaces.dart';
import 'package:flutter_secentry/helpers/providers/profile.dart';
import 'package:flutter_secentry/models/visitor_model.dart';
import 'package:flutter_secentry/services/guard/guard_services.dart';
import 'package:flutter_secentry/widget/button.dart';
import 'package:flutter_secentry/widget/loading.dart';
import 'package:provider/src/provider.dart';

class GuestInfo extends StatefulWidget {
  final VisitorModel? visitorModel;
  final int? index;
  const GuestInfo({Key? key, this.visitorModel, this.index}) : super(key: key);

  @override
  _GuestInfoState createState() => _GuestInfoState();
}

class _GuestInfoState extends State<GuestInfo> {
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
                          heightSpace(40),
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
                          const Text(
                            'Guest Info',
                            style: TextStyle(fontSize: 40),
                          ),
                          heightSpace(10),
                          Text(
                            '${widget.visitorModel!.results?[widget.index!].estateVisitorName}',
                            style: TextStyle(fontSize: 20),
                          ),
                          heightSpace(30),
                          text('Host name',
                              '${widget.visitorModel!.results?[widget.index!].estateUserFullname}'),
                          const Divider(),
                          heightSpace(20),
                          text('Host phone',
                              '${widget.visitorModel!.results?[widget.index!].estateUserPhoneNumber}'),
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
                              '${widget.visitorModel!.results?[widget.index!].estateVisitorAddress}'),
                          const Divider(),
                          heightSpace(20),
                          text('Phone Number',
                              '${widget.visitorModel!.results?[widget.index!].estateVisitorPhone}'),
                          const Divider(),
                          heightSpace(20),
                          text('Purpose of visit',
                              '${widget.visitorModel!.results?[widget.index!].purposeOfVisit}'),
                          Divider(),
                          // heightSpace(20),
                          // text('Gender', '${widget.visitorModel!.results?[0].}'),
                          // Divider(),
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
