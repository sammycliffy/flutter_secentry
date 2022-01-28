import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secentry/constants/colors.dart';
import 'package:flutter_secentry/constants/images.dart';
import 'package:flutter_secentry/constants/spaces.dart';
import 'package:flutter_secentry/helpers/format_date.dart';
import 'package:flutter_secentry/helpers/providers/profile.dart';
import 'package:flutter_secentry/models/company/company_visitor_model.dart';
import 'package:flutter_secentry/models/visitor_model.dart';
import 'package:flutter_secentry/services/company/invitation_services.dart';
import 'package:flutter_secentry/services/invitation_services.dart';
import 'package:flutter_secentry/widget/shimmer_widgets/vertical_boxes.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'company_guest_info.dart';

class CompanyGuestEntry extends StatefulWidget {
  const CompanyGuestEntry({Key? key}) : super(key: key);

  @override
  State<CompanyGuestEntry> createState() => _CompanyGuestEntryState();
}

class _CompanyGuestEntryState extends State<CompanyGuestEntry> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final CompanyGuestEntryServices _guestEntryServices =
      CompanyGuestEntryServices();
  bool loading = true;
  bool noinvitations = false;
  Future<CompanyVisitorModel>? _visitorModel;
  CompanyVisitorModel? visitorModel;
  ProfileDataNotifier? _profileDataNotifier;
  List<String> visitorName = [];
  List<String> visitorPhone = [];
  List time = [];
  int pageNumber = 1;
  @override
  void initState() {
    super.initState();
    firstTimeLoad();
  }

  @override
  Widget build(BuildContext context) {
    _profileDataNotifier = context.watch<ProfileDataNotifier>();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            heightSpace(30),
            heightSpace(30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, '/company_dashboard'),
                    icon: const Icon(Icons.arrow_back_ios)),
                const Text(
                  'Guest List',
                  style: TextStyle(fontSize: 25),
                ),
                IconButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, '/company_invite_guest'),
                    icon: const Icon(
                      Icons.person_add,
                      size: 40,
                      color: kPrimary,
                    ))
              ],
            ),
            heightSpace(20),
            (() {
              if (loading) {
                return shimmers();
              } else if (noinvitations) {
                return noInvitedGuest();
              } else {
                return Expanded(
                  child: customRefresher(),
                );
              }
            }())
          ],
        ),
      ),
    );
  }

  noInvitedGuest() => Column(
        children: [
          heightSpace(100),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/company_invite_guest'),
            child: Center(
              child: guestIcon,
            ),
          ),
          heightSpace(20),
          const Center(
            child: Text(
              'You haven\'t invited anyone yet.\n Tap icon to invite guest',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: kGray),
            ),
          )
        ],
      );

  firstTimeLoad() {
    _visitorModel = _guestEntryServices.getInvitation(context);
    _visitorModel!.then((value) {
      setState(() {
        loading = false;
      });
      visitorModel = value;
      if (value.count == 0) {
        noinvitations = true;
      } else {
        setState(() {
          value.results!.forEach((element) {
            setState(() {
              visitorName.add(element.companyVisitorName!);
              visitorPhone.add(element.companyVisitorPhone!);
              time.add(formatDate(DateTime.parse(element.dateJoined!)));
            });
          });
        });
      }
    });
  }

  //reload data
  Future _loadData() async {
    _visitorModel =
        _guestEntryServices.getInvitationByNumber(context, pageNumber);
    _visitorModel!.then((value) {
      setState(() {
        visitorModel = value;
        value.results!.forEach((element) {
          setState(() {
            visitorName.add(element.companyVisitorName!);
            visitorPhone.add(element.companyVisitorPhone!);
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

  void _onLoading() async {
    await Future.delayed(const Duration(milliseconds: 4000));
    setState(() {
      pageNumber++;
    });
    if (mounted) _loadData();
  }

  customRefresher() => SmartRefresher(
      enablePullDown: false,
      enablePullUp: true,
      header: const WaterDropHeader(),
      footer: CustomFooter(
        builder: (BuildContext context, LoadStatus? mode) {
          Widget body;
          if (mode == LoadStatus.idle) {
            body = const Text("pull down load");
          } else if (mode == LoadStatus.loading) {
            body = const CupertinoActivityIndicator();
          } else if (mode == LoadStatus.failed) {
            body = const Text("Load Failed!Click retry!");
          } else if (mode == LoadStatus.canLoading) {
            body = const Text("release to load more");
          } else {
            body = const Text("No more Data");
          }
          return Container(
            height: 55.0,
            child: Center(child: body),
          );
        },
      ),
      controller: _refreshController,
      onRefresh: null,
      onLoading: _onLoading,
      child: listView());

  listView() => ListView.builder(
      primary: true,
      shrinkWrap: true,
      itemCount: visitorName.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CompanyGuestInfo(
                        visitorModel: visitorModel,
                        index: index,
                      ))),
          child: Card(
            child: ListTile(
              leading: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    color: kPrimary, borderRadius: BorderRadius.circular(5)),
                child: const Center(
                    child: Icon(
                  Icons.person,
                  color: kWhite,
                )),
              ),
              title: Text(
                visitorName[index],
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: kPrimary, fontSize: 14),
              ),
              subtitle: Text(
                time[index],
                style: const TextStyle(color: kGray, fontSize: 12),
              ),
            ),
          ),
        );
      });
}
