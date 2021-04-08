import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:todoey_flutter/models/task.dart';
import 'package:todoey_flutter/screens/eater_egg_screen.dart';
import 'package:todoey_flutter/services/hive_helper.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({required this.index, Key? key}) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    return Consumer<HiveHelper>(builder: (context, hiveHelper, Widget? child) {
      final Task task = hiveHelper.getTask(index)!;
      return Card(
        margin: const EdgeInsets.all(4),
        color: Color(task.color!),
        child: InkWell(
          splashColor: const Color(0xff197278),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Flexible(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      alignment: Alignment.topLeft,
                      child: Text(
                        task.taskText!,
                        style: TextStyle(
                          decoration:
                              task.isDone! ? TextDecoration.lineThrough : null,
                          color: task.color == 0xffffffff ||
                                  task.color == 0xffDDEDAA
                              ? const Color(0xFF283d3b)
                              : Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.color_lens_outlined,
                  color: task.color == 0xffffffff || task.color == 0xffDDEDAA
                      ? const Color(0xFF283d3b)
                      : Colors.white,
                ),
                onPressed: () {
                  _selectColorDialog(
                      context: context, hiveHelper: hiveHelper, index: index);
                },
              ),
              Theme(
                data: ThemeData(
                  unselectedWidgetColor:
                      task.color == 0xffffffff || task.color == 0xffDDEDAA
                          ? const Color(0xFF283d3b)
                          : Colors.white,
                ),
                child: Checkbox(
                  value: task.isDone,
                  activeColor: const Color(0xfFc44900),
                  onChanged: (bool? isDone) {
                    hiveHelper.toggleDoneState(index);
                    if (hiveHelper.allBoxesTicked()) {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) {
                          return EasterEggScreen();
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Future<void> _selectColorDialog({
    required BuildContext context,
    HiveHelper? hiveHelper,
    required int index,
  }) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        Widget widget;
        if (MediaQuery.of(context).orientation == Orientation.landscape) {
          const double height = 100;
          widget = Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      hiveHelper!.updateColor(index, 0xff197278);
                      Navigator.of(context).pop();
                    },
                    child: const Image(
                      height: height,
                      image: AssetImage('images/color_197278.png'),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      hiveHelper!.updateColor(index, 0xff283d3b);
                      Navigator.of(context).pop();
                    },
                    child: const Image(
                      height: height,
                      image: AssetImage('images/color_283d3b.png'),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      hiveHelper!.updateColor(index, 0xff3D348B);
                      Navigator.of(context).pop();
                    },
                    child: const Image(
                      height: height,
                      image: AssetImage('images/color_3D348B.png'),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      hiveHelper!.updateColor(index, 0xff684551);
                      Navigator.of(context).pop();
                    },
                    child: const Image(
                      height: height,
                      image: AssetImage('images/color_684551.png'),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      hiveHelper!.updateColor(index, 0xffD15387);
                      Navigator.of(context).pop();
                    },
                    child: const Image(
                      height: height,
                      image: AssetImage('images/color_D15387.png'),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      hiveHelper!.updateColor(index, 0xffDDEDAA);
                      Navigator.of(context).pop();
                    },
                    child: const Image(
                      height: height,
                      image: AssetImage('images/color_DDEDAA.png'),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      hiveHelper!.updateColor(index, 0xff7AC74F);
                      Navigator.of(context).pop();
                    },
                    child: const Image(
                      height: height,
                      image: AssetImage('images/color_7AC74F.png'),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      hiveHelper!.updateColor(index, 0xffc44900);
                      Navigator.of(context).pop();
                    },
                    child: const Image(
                      height: height,
                      image: AssetImage('images/color_c44900.png'),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  hiveHelper!.updateColor(index, 0xffffffff);
                  Navigator.of(context).pop();
                },
                child: const Image(
                  width: 100,
                  image: AssetImage('images/color_white.png'),
                ),
              ),
            ],
          );
        } else {
          widget = Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      hiveHelper!.updateColor(index, 0xff197278);
                      Navigator.of(context).pop();
                    },
                    child: const Image(
                      image: AssetImage('images/color_197278.png'),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      hiveHelper!.updateColor(index, 0xff283d3b);
                      Navigator.of(context).pop();
                    },
                    child: const Image(
                      image: AssetImage('images/color_283d3b.png'),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      hiveHelper!.updateColor(index, 0xff3D348B);
                      Navigator.of(context).pop();
                    },
                    child: const Image(
                      image: AssetImage('images/color_3D348B.png'),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      hiveHelper!.updateColor(index, 0xff684551);
                      Navigator.of(context).pop();
                    },
                    child: const Image(
                      image: AssetImage('images/color_684551.png'),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      hiveHelper!.updateColor(index, 0xffD15387);
                      Navigator.of(context).pop();
                    },
                    child: const Image(
                      image: AssetImage('images/color_D15387.png'),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      hiveHelper!.updateColor(index, 0xffDDEDAA);
                      Navigator.of(context).pop();
                    },
                    child: const Image(
                      image: AssetImage('images/color_DDEDAA.png'),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      hiveHelper!.updateColor(index, 0xff7AC74F);
                      Navigator.of(context).pop();
                    },
                    child: const Image(
                      image: AssetImage('images/color_7AC74F.png'),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      hiveHelper!.updateColor(index, 0xffc44900);
                      Navigator.of(context).pop();
                    },
                    child: const Image(
                      image: AssetImage('images/color_c44900.png'),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  hiveHelper!.updateColor(index, 0xffffffff);
                  Navigator.of(context).pop();
                },
                child: const Image(
                  image: AssetImage('images/color_white.png'),
                ),
              ),
            ],
          );
        }
        return SingleChildScrollView(
          child: AlertDialog(
            contentPadding: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
            backgroundColor: Colors.transparent,
            title: Shimmer.fromColors(
              baseColor: const Color(0xFFedddd4),
              period: const Duration(milliseconds: 5000),
              highlightColor: const Color(0xFF283d3b),
              child: const Text(
                'Select Color',
                style: TextStyle(
                  color: Color(0xFFedddd4),
                  fontSize: 35.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            content: widget,
          ),
        );
      },
    );
  }
}
