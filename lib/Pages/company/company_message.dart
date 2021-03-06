import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secentry/Pages/Estate/message_details.dart';
import 'package:flutter_secentry/constants/colors.dart';
import 'package:flutter_secentry/constants/images.dart';
import 'package:flutter_secentry/constants/spaces.dart';
import 'package:flutter_secentry/helpers/format_date.dart';
import 'package:flutter_secentry/helpers/providers/profile.dart';
import 'package:flutter_secentry/helpers/sharedpreferences.dart';
import 'package:flutter_secentry/models/company/companymessage_model.dart';
import 'package:flutter_secentry/services/company/company_message_services.dart';
import 'package:flutter_secentry/widget/shimmer_widgets/vertical_boxes.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CompanyMessages extends StatefulWidget {
  const CompanyMessages({Key? key}) : super(key: key);

  @override
  State<CompanyMessages> createState() => _CompanyMessagesState();
}

class _CompanyMessagesState extends State<CompanyMessages> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final CompanyMessageServices _messageServices = CompanyMessageServices();
  bool loading = true;
  bool noinvitations = false;
  late Future<CompanyMessage> _messageModel;
  ProfileDataNotifier? _profileDataNotifier;
  List message = [];
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimary,
        onPressed: () =>
            Navigator.pushNamed(context, '/company_compose_message'),
        child: const Icon(Icons.email),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            heightSpace(60),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.arrow_back_ios)),
                heightSpace(50),
                const Text(
                  'Messages',
                  style: TextStyle(fontSize: 25),
                ),
                widthSpace(60),
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
              'You don\'t have any message.\n Click to compose message',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: kGray),
            ),
          )
        ],
      );

  firstTimeLoad() {
    _messageModel = _messageServices.getAllMessage();
    _messageModel.then((value) {
      SharedPreference().saveCount('count', value.count);
      setState(() {
        loading = false;
      });
      if (value.count == 0) {
        noinvitations = true;
      } else {
        value.results?.forEach((element) {
          setState(() {
            message.add(element.message);
            time.add(formatDate(DateTime.parse(element.time!)));
          });
        });
      }
    });
  }

  //reload data
  Future _loadData() async {
    _messageModel = _messageServices.getAllMessageByPageNumber(pageNumber);
    _messageModel.then((value) {
      setState(() {
        loading = false;
      });
      if (value.count == 0) {
        noinvitations = true;
      } else {
        setState(() {
          value.results!.forEach((element) {
            setState(() {
              message.add(element.message);

              time.add(formatDate(DateTime.parse(element.time!)));
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
      itemCount: message.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MessageDetails(
                        message: message[index],
                      ))),
          child: Card(
            child: ListTile(
              leading: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    color: kPrimary, borderRadius: BorderRadius.circular(25)),
                child: const Center(
                    child: Icon(
                  Icons.message,
                  color: kWhite,
                )),
              ),
              title: Text(
                truncateWithEllipsis(12, message[index]),
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

String truncateWithEllipsis(int cutoff, String myString) {
  return (myString.length <= cutoff)
      ? myString
      : '${myString.substring(0, cutoff)}...';
}
