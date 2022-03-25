import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secentry/constants/colors.dart';
import 'package:flutter_secentry/constants/images.dart';
import 'package:flutter_secentry/constants/spaces.dart';
import 'package:flutter_secentry/helpers/format_date.dart';
import 'package:flutter_secentry/models/visitor_model.dart';
import 'package:flutter_secentry/services/invitation_services.dart';
import 'package:flutter_secentry/widget/shimmer_widgets/vertical_boxes.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MyInvitations extends StatefulWidget {
  const MyInvitations({Key? key}) : super(key: key);

  @override
  _MyInvitationsState createState() => _MyInvitationsState();
}

class _MyInvitationsState extends State<MyInvitations> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  bool loading = true;
  bool noinvitations = false;
  Future<VisitorModel>? _visitorModel;
  int pageNumber = 1;
  List<String> hostName = [];
  List<String> hostPhone = [];
  List time = [];
  @override
  void initState() {
    super.initState();
    firstTimeLoad();
  }

  final GuestEntryServices _guestEntryServices = GuestEntryServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            heightSpace(50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.arrow_back_ios)),
                const Text(
                  'My Invitations',
                  style: TextStyle(fontSize: 25),
                ),
                widthSpace(50),
              ],
            ),
            heightSpace(50),
            (() {
              if (loading) {
                return shimmers();
              } else if (noinvitations) {
                return noInvitations();
              } else {
                return Expanded(
                  child: customRefresher(),
                );
              }
            }())

            // Align(alignment: Alignment.bottomRight, child: background)
          ],
        ),
      ),
    );
  }

  listView() => ListView.builder(
      primary: true,
      shrinkWrap: true,
      itemCount: hostName.length,
      itemBuilder: (context, index) {
        return ListTile(
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
            hostName[index],
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: kPrimary, fontSize: 18),
          ),
          subtitle: Text(
            time[index],
            style: const TextStyle(color: kGray),
          ),
        );
      });

  firstTimeLoad() {
    _visitorModel = _guestEntryServices.getInvitedLists(context);
    _visitorModel!.then((value) {
      setState(() {
        loading = false;
      });
      if (value.count == 0) {
        noinvitations = true;
      } else {
        setState(() {
          value.results!.forEach((element) {
            setState(() {
              hostName.add(element.estateUserFullname!);
              hostPhone.add(element.estateUserPhoneNumber!);
              time.add(formatDate(DateTime.parse(element.dateJoined!)));
            });
          });
        });
      }
    });
  }

  noInvitations() => Column(children: [
        heightSpace(60),
        guestIcon,
        heightSpace(30),
        const Center(
          child: Text(
            'You don\'t have any invitations yet.\n',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: kGray),
          ),
        )
      ]);
  Future<dynamic> onRefresh() async {
    return const Text('refreshed');
  }

  void _onLoading() async {
    await Future.delayed(const Duration(milliseconds: 4000));
    setState(() {
      pageNumber++;
    });
    if (mounted) _loadData();
  }

//reload data
  Future _loadData() async {
    _visitorModel =
        _guestEntryServices.getInvitedListsByNumber(context, pageNumber);
    _visitorModel!.then((value) {
      setState(() {
        value.results!.forEach((element) {
          setState(() {
            hostName.add(element.estateUserFullname!);
            hostPhone.add(element.estateUserPhoneNumber!);
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
}
