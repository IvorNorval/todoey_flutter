import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:todoey_flutter/services/ad_helper.dart';
import 'package:todoey_flutter/services/hive_helper.dart';
import 'package:todoey_flutter/widgets/heading_widget.dart';
import 'package:todoey_flutter/widgets/task_list_widget.dart';
import 'package:todoey_flutter/widgets/task_text_field_widget.dart';

class TasksScreen extends StatefulWidget {
  static const String id = 'TasksScreen';

  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  BannerAd? _ad;
  bool _isAdLoaded = false;
  Orientation? _orientation;

  @override
  void initState() {
    super.initState();
    _ad = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: AdListener(
        onAdLoaded: (_) {
          setState(
            () {
              _isAdLoaded = true;
            },
          );
        },
        onAdFailedToLoad: (_, error) {
          //print('Ad load failed (code=${error.code} message=${error
          //    .message})');
        },
      ),
    );

    _ad!.load();
  }

  @override
  void dispose() {
    _ad?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HiveHelper>(
      builder: (context, hiveHelper, Widget? child) {
        if (MediaQuery.of(context).orientation == Orientation.landscape) {
          if (_orientation != null && _orientation == Orientation.portrait) {
            _isAdLoaded = false;
            _ad?.dispose();
            _ad = BannerAd(
              adUnitId: AdHelper.bannerAdUnitId,
              size: AdSize.banner,
              request: const AdRequest(),
              listener: AdListener(
                onAdLoaded: (_) {
                  setState(
                    () {
                      _isAdLoaded = true;
                    },
                  );
                },
                onAdFailedToLoad: (_, error) {
                  // print(
                  //     'Ad load failed (code=${error.code} message=${error.message})');
                },
              ),
            );

            _ad!.load();
          }
          _orientation = Orientation.landscape;
          return SafeArea(
            child: Scaffold(
              backgroundColor: const Color(0xff197278),
              body: Row(
                children: [
                  SizedBox(
                    width: 180,
                    child: Heading(),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TaskListWidget(),
                        if (_isAdLoaded && hiveHelper.showAd)
                          Container(
                            color: const Color(0xFFedddd4),
                            height: 72.0,
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: AdWidget(ad: _ad!),
                            ),
                          )
                        else
                          Container(),
                        TaskTextFieldWidget(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          if (_orientation != null && _orientation == Orientation.landscape) {
            _isAdLoaded = false;
            _ad?.dispose();
            _ad = BannerAd(
              adUnitId: AdHelper.bannerAdUnitId,
              size: AdSize.banner,
              request: const AdRequest(),
              listener: AdListener(
                onAdLoaded: (_) {
                  setState(
                    () {
                      _isAdLoaded = true;
                    },
                  );
                },
                onAdFailedToLoad: (_, error) {
                  // print(
                  //     'Ad load failed (code=${error.code} message=${error.message})');
                },
              ),
            );

            _ad!.load();
          }
          _orientation = Orientation.portrait;
          return Scaffold(
            backgroundColor: const Color(0xff197278),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Heading(),
                TaskListWidget(),
                if (_isAdLoaded && hiveHelper.showAd)
                  Container(
                    color: const Color(0xFFedddd4),
                    height: 72.0,
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AdWidget(ad: _ad!),
                    ),
                  )
                else
                  Container(),
                TaskTextFieldWidget(),
              ],
            ),
          );
        }
      },
    );
  }
}
