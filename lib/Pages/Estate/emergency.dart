import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_secentry/constants/colors.dart';
import 'package:flutter_secentry/constants/images.dart';
import 'package:flutter_secentry/constants/spaces.dart';
import 'package:flutter_secentry/helpers/providers/profile.dart';
import 'package:flutter_secentry/models/emergency_model.dart';
import 'package:flutter_secentry/services/emergency_services.dart';
import 'package:flutter_secentry/widget/shimmer_widgets/vertical_boxes.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class EmergencyContact extends StatefulWidget {
  const EmergencyContact({Key? key}) : super(key: key);

  @override
  State<EmergencyContact> createState() => _EmergencyContactState();
}

class _EmergencyContactState extends State<EmergencyContact> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final EmergencyServices _emergencyServices = EmergencyServices();
  bool loading = true;
  bool noinvitations = false;
  Future<EmergencyModel>? _emergencyModel;
  ProfileDataNotifier? _profileDataNotifier;
  List<String> contactName = [];
  List<String> contactPhone = [];
  List designation = [];
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
            heightSpace(70),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Emergency',
                  style: TextStyle(fontSize: 40),
                ),
                IconButton(
                    onPressed: null,
                    icon: Icon(
                      Icons.search,
                      size: 40,
                      color: kBlack,
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
            onTap: () => Navigator.pushNamed(context, '/invite_guest'),
            child: Center(
              child: guestIcon,
            ),
          ),
          heightSpace(20),
          const Center(
            child: Text(
              'No emergency contact yet.\n Ask your admin to add at least one',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: kGray),
            ),
          )
        ],
      );

  firstTimeLoad() {
    _emergencyModel = _emergencyServices.getAllContact();
    _emergencyModel!.then((value) {
      setState(() {
        loading = false;
      });
      if (value.count == 0) {
        noinvitations = true;
      } else {
        setState(() {
          value.results!.forEach((element) {
            setState(() {
              contactName.add(element.contactName!);
              contactPhone.add(element.contactPhone!);
              designation.add(element.contactDesignation);
            });
          });
        });
      }
    });
  }

  //reload data
  Future _loadData() async {
    _emergencyModel = _emergencyServices.getAllContactByPagenumber(pageNumber);
    _emergencyModel!.then((value) {
      setState(() {
        loading = false;
      });
      if (value.count == 0) {
        noinvitations = true;
      } else {
        setState(() {
          value.results!.forEach((element) {
            setState(() {
              contactName.add(element.contactName!);
              contactPhone.add(element.contactPhone!);
              designation.add(element.contactDesignation);
            });
          });
        });
      }
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
      itemCount: contactName.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            trailing: IconButton(
                icon: const Icon(
                  Icons.phone,
                  color: kPrimary,
                ),
                onPressed: () => callNumber(contactPhone[index])),
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
              contactName[index],
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: kPrimary, fontSize: 18),
            ),
            subtitle: Text(
              designation[index],
              style: const TextStyle(color: kGray),
            ),
          ),
        );
      });

  callNumber(number) async {
    bool? res = await FlutterPhoneDirectCaller.callNumber(number);
  }
}
