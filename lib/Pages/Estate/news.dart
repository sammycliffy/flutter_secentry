import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secentry/Pages/Estate/news_details.dart';
import 'package:flutter_secentry/constants/colors.dart';
import 'package:flutter_secentry/constants/images.dart';
import 'package:flutter_secentry/constants/spaces.dart';
import 'package:flutter_secentry/helpers/format_date.dart';
import 'package:flutter_secentry/helpers/providers/profile.dart';
import 'package:flutter_secentry/models/estate_news_model.dart';
import 'package:flutter_secentry/services/news_services.dart';
import 'package:flutter_secentry/widget/shimmer_widgets/vertical_boxes.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class News extends StatefulWidget {
  const News({Key? key}) : super(key: key);

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final NewsServices _newsServices = NewsServices();
  bool loading = true;
  bool noinvitations = false;
  late Future<EstateNews> _estateNews;
  ProfileDataNotifier? _profileDataNotifier;
  List body = [];
  List subject = [];
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
            heightSpace(70),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'News',
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
              'You don\'t have any news yet.\n Admin will add soon',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: kGray),
            ),
          )
        ],
      );

  firstTimeLoad() {
    _estateNews = _newsServices.getAllNews();
    _estateNews.then((value) {
      setState(() {
        loading = false;
      });
      if (value.count == 0) {
        noinvitations = true;
      } else {
        value.results?.forEach((element) {
          setState(() {
            subject.add(element.subject);
            body.add(element.body);
            time.add(formatDate(element.dateAdded!));
          });
        });
      }
    });
  }

  //reload data
  Future _loadData() async {
    _estateNews = _newsServices.getAllNewsByPageNumber(pageNumber);
    _estateNews.then((value) {
      setState(() {
        loading = false;
      });
      if (value.count == 0) {
        noinvitations = true;
      } else {
        value.results?.forEach((element) {
          setState(() {
            subject.add(element.subject);
            body.add(element.body);
            time.add(formatDate(element.dateAdded!));
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
      itemCount: subject.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NewsDetails(
                        subject: subject[index],
                        body: body[index],
                        time: time[index],
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
                  Icons.notifications,
                  color: kWhite,
                )),
              ),
              title: Text(
                truncateWithEllipsis(12, subject[index]),
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: kPrimary, fontSize: 18),
              ),
              subtitle: Text(
                truncateWithEllipsis(12, body[index]),
                style: const TextStyle(color: kGray),
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
