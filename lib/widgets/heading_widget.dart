import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:todoey_flutter/services/hive_helper.dart';

class Heading extends StatefulWidget {
  @override
  _HeadingState createState() => _HeadingState();
}

class _HeadingState extends State<Heading> with TickerProviderStateMixin {
  late AnimationController _controller;

  final Tween<double> turnsTween = Tween<double>(
    begin: 0,
    end: 1,
  );

  @override
  void initState() {
    super.initState();
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      EdgeInsets edgeInsets;
      if (MediaQuery.of(context).orientation == Orientation.landscape) {
        edgeInsets = EdgeInsets.only(
            top: isKeyboardVisible ? 5.0 : 60.0,
            left: 25.0,
            right: 25.0,
            bottom: isKeyboardVisible ? 5 : 20.0);
        _controller.forward();
      } else {
        edgeInsets = const EdgeInsets.only(
            top: 60.0, left: 30.0, right: 30.0, bottom: 20.0);
        _controller.forward();
      }

      return Consumer<HiveHelper>(
        builder: (context, hiveHelper, Widget? child) {
          return Container(
            padding: edgeInsets,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                RotationTransition(
                  turns: turnsTween.animate(_controller),
                  child: !hiveHelper.isInfoList
                      ? Shimmer.fromColors(
                          baseColor: const Color(0xFFedddd4),
                          period: const Duration(milliseconds: 5000),
                          highlightColor: const Color(0xFF283d3b),
                          child: const Text(
                            'ToDoey',
                            style: TextStyle(
                              color: Color(0xFFedddd4),
                              fontSize: 35.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ))
                      : GestureDetector(
                          onTap: () {
                            hiveHelper.resetInfoList();
                          },
                          child: const Image(
                            image: AssetImage('images/going_back.png'),
                            height: 80,
                          ),
                        ),
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          "${hiveHelper.getDoneTasksCount()} done",
                          style: const TextStyle(
                            color: Color(0xfFc44900),
                            fontSize: 17.0,
                          ),
                        ),
                        Text(
                          "${hiveHelper.getTaskBoxLength() - hiveHelper.getDoneTasksCount()} todo's",
                          style: const TextStyle(
                            color: Color(0xfFc44900),
                            fontSize: 17.0,
                          ),
                        ),
                      ],
                    ),
                    const Expanded(
                      child: SizedBox(
                        width: 180,
                      ),
                    ),
                    if (!hiveHelper.isInfoList)
                      IconButton(
                        iconSize: 40,
                        icon: Image.asset('images/info_icon.png'),
                        onPressed: () {
                          hiveHelper.setInfoList();
                        },
                      )
                    else
                      const Image(
                        image: AssetImage('images/info_icon.png'),
                        height: 40,
                        width: 40,
                      ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    });
  }
}
