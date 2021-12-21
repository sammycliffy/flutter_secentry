import 'package:flutter/material.dart';
import 'package:flutter_secentry/helpers/format_date.dart';
import 'package:flutter_secentry/models/visitor_model.dart';
import 'package:flutter_secentry/services/invitation_services.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NoFacilityInvitation extends StatefulWidget {
  const NoFacilityInvitation({Key? key}) : super(key: key);

  @override
  _NoFacilityInvitationState createState() => _NoFacilityInvitationState();
}

class _NoFacilityInvitationState extends State<NoFacilityInvitation> {
  // ignore: prefer_final_fields
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final GuestEntryServices _guestEntryServices = GuestEntryServices();
  // ignore: unused_field
  Future<VisitorModel>? _visitorModel;
  VisitorModel? visitorModel;
  List<String> hostName = [];
  List<String> hostPhone = [];
  List time = [];
  int? count;
  bool loading = true;
  int pageNumber = 1;

  @override
  void initState() {
    super.initState();
    _guestEntryServices.getInvitedLists(context).then((value) {
      if (value.count == 0) {
        setState(() {
          loading = false;
          count = 0;
        });
      } else {
        value.results!.forEach((element) {
          setState(() {
            loading = false;
            hostName.add(element.estateVisitorName!);
            hostPhone.add(element.estateVisitorPhone!);
            time.add(formatDate(DateTime.parse(element.dateJoined!)));
          });
        });
      }
    });
  }

  void _onLoading() async {
    await Future.delayed(const Duration(milliseconds: 4000));
    setState(() {
      pageNumber++;
    });
    if (mounted) _loadData();
  }

  Future _loadData() async {
    _guestEntryServices
        .getInvitedListsByNumber(context, pageNumber)
        .then((value) {
      setState(() {
        value.results!.forEach((element) {
          setState(() {
            hostName.add(element.estateVisitorName!);
            hostPhone.add(element.estateVisitorPhone!);
            time.add(formatDate(DateTime.parse(element.dateJoined!)));
          });
        });
      });
    }).whenComplete(() {
      return _refreshController.loadComplete();
    }).catchError((e) {
      _refreshController.loadNoData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 35),
          child: Column(
            children: const [
              Text(
                'Hi Samuel,',
                style: TextStyle(fontSize: 40),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
