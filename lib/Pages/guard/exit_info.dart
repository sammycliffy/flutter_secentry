import 'package:flutter/material.dart';
import 'package:flutter_secentry/constants/colors.dart';
import 'package:flutter_secentry/constants/spaces.dart';
import 'package:flutter_secentry/helpers/providers/profile.dart';
import 'package:flutter_secentry/models/visitor_model.dart';
import 'package:flutter_secentry/services/guard/guard_services.dart';
import 'package:flutter_secentry/widget/button.dart';
import 'package:flutter_secentry/widget/loading.dart';
import 'package:flutter_secentry/widget/toast.dart';
import 'package:provider/src/provider.dart';

class ExitInfo extends StatefulWidget {
  final VisitorModel? visitorModel;
  const ExitInfo({Key? key, this.visitorModel}) : super(key: key);

  @override
  _ExitInfoState createState() => _ExitInfoState();
}

class _ExitInfoState extends State<ExitInfo> {
  final GuardServices _guardServices = GuardServices();
  ProfileDataNotifier? _profileDataNotifier;

  @override
  void initState() {
    super.initState();
    if (widget.visitorModel!.count == 0) {
      ToastUtils.showRedToast('Code not found');
      Navigator.pop(context);
    }
  }

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
                          IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: Icon(Icons.arrow_back_ios)),
                          heightSpace(30),
                          const Text(
                            'Guest Info',
                            style: TextStyle(fontSize: 40),
                          ),
                          heightSpace(10),
                          Text(
                            '${widget.visitorModel!.results?[0].estateVisitorName}',
                            style: TextStyle(fontSize: 20),
                          ),
                          heightSpace(30),
                          text('Host name',
                              '${widget.visitorModel!.results?[0].estateUserFullname}'),
                          Divider(),
                          heightSpace(20),
                          text('Host phone',
                              '${widget.visitorModel!.results?[0].estateUserPhoneNumber}'),
                          Divider(),
                          heightSpace(20),
                          text('Country',
                              '${widget.visitorModel!.results?[0].country}'),
                          Divider(),
                          heightSpace(20),
                          text('State',
                              '${widget.visitorModel!.results?[0].state}'),
                          Divider(),
                          heightSpace(20),
                          text('Visitor Address',
                              '${widget.visitorModel!.results?[0].estateVisitorAddress}'),
                          Divider(),
                          heightSpace(20),
                          text('Phone Number',
                              '${widget.visitorModel!.results?[0].estateVisitorPhone}'),
                          Divider(),
                          heightSpace(20),
                          text('Purpose of visit',
                              '${widget.visitorModel!.results?[0].purposeOfVisit}'),
                          Divider(),
                          // heightSpace(20),
                          // text('Gender', '${widget.visitorModel!.results?[0].}'),
                          // Divider(),
                          heightSpace(20),
                          text('Time',
                              '${widget.visitorModel!.results?[0].duration}'),
                          Divider(),
                          heightSpace(50),
                          SizedBox(
                            height: 400,
                            width: 200,
                            child: ListView.builder(
                                itemCount: widget
                                    .visitorModel!.results?[0].itemPass!.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    leading: const Icon(Icons.list),
                                    title: Text(
                                        '${widget.visitorModel!.results?[0].itemPass?[index].itemName}'),
                                    subtitle: Text(
                                        '${widget.visitorModel!.results?[0].itemPass?[index].description}'),
                                    trailing: Text(
                                        '${widget.visitorModel!.results?[0].itemPass?[index].quantity}'),
                                  );
                                }),
                          ),
                          CustomButton(text: 'Checkout', validate: validate),
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
    dynamic result = await _guardServices.checkoutVisitor(
        context, widget.visitorModel!.results?[0].id);
    if (result) {
      _profileDataNotifier!.setLoading(false);
      Navigator.pushNamed(context, '/exit_approved');
    } else {
      _profileDataNotifier!.setLoading(false);
    }
  }
}
