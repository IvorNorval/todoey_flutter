import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:todoey_flutter/models/task.dart';
import 'package:todoey_flutter/screens/eater_egg_screen.dart';
import 'package:todoey_flutter/services/hive_helper.dart';

class TaskTextFieldWidget extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String newTaskTitle;
    return Consumer<HiveHelper>(
      builder: (context, hiveHelper, Widget child) {
        return Container(
          color: const Color(0xFFedddd4),
          child: Container(
            padding: const EdgeInsets.all(5.0),
            decoration: const BoxDecoration(
              color: Color(0xFF283d3b),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFedddd4),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: TextField(
                onTap: () {
                  hiveHelper.hideAd();
                },
                controller: _controller,
                textInputAction: TextInputAction.go,
                cursorColor: const Color(0xFF283d3b),
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                    hintText: 'Add new to do...',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff197278),
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff197278),
                      ),
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff197278),
                      ),
                    ),
                    labelStyle: TextStyle(
                      color: Color(0xff197278),
                    )),
                onChanged: (value) {
                  newTaskTitle = value;
                },
                onEditingComplete: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  if (newTaskTitle != null) {
                    final newTask = Task(
                      taskText: newTaskTitle,
                      isDone: false,
                      color: 0xffffffff,
                    );
                    await _selectColorDialog(context: context, task: newTask);
                    hiveHelper.addTask(newTask);
                  }
                  _controller.clear();
                  newTaskTitle = null;
                  if (hiveHelper.getTaskBoxLength() == 10) {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) {
                        return EasterEggScreen();
                      },
                    );
                  }
                  if (hiveHelper.getTaskBoxLength() > 9) {
                    hiveHelper.scrollController.animateTo(
                      hiveHelper.scrollController.position.maxScrollExtent,
                      curve: Curves.easeOut,
                      duration: const Duration(milliseconds: 300),
                    );
                  }
                  hiveHelper.setShowAd();
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _selectColorDialog({BuildContext context, Task task}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        Widget widget;
        if (MediaQuery.of(context).orientation == Orientation.landscape) {
          const double size = 100;
          widget = Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      task.color = 0xff197278;
                      Navigator.of(context).pop();
                    },
                    child: const Image(
                      height: size,
                      image: AssetImage('images/color_197278.png'),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      task.color = 0xff283d3b;
                      Navigator.of(context).pop();
                    },
                    child: const Image(
                      height: size,
                      image: AssetImage('images/color_283d3b.png'),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      task.color = 0xff3D348B;
                      Navigator.of(context).pop();
                    },
                    child: const Image(
                      height: size,
                      image: AssetImage('images/color_3D348B.png'),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      task.color = 0xff684551;
                      Navigator.of(context).pop();
                    },
                    child: const Image(
                      height: size,
                      image: AssetImage('images/color_684551.png'),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      task.color = 0xffD15387;
                      Navigator.of(context).pop();
                    },
                    child: const Image(
                      height: size,
                      image: AssetImage('images/color_D15387.png'),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      task.color = 0xffDDEDAA;
                      Navigator.of(context).pop();
                    },
                    child: const Image(
                      height: size,
                      image: AssetImage('images/color_DDEDAA.png'),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      task.color = 0xff7AC74F;
                      Navigator.of(context).pop();
                    },
                    child: const Image(
                      height: size,
                      image: AssetImage('images/color_7AC74F.png'),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      task.color = 0xffc44900;
                      Navigator.of(context).pop();
                    },
                    child: const Image(
                      height: size,
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
                  task.color = 0xffffffff;
                  Navigator.of(context).pop();
                },
                child: const Image(
                  width: size,
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
                      task.color = 0xff197278;
                      Navigator.of(context).pop();
                    },
                    child: const Image(
                      image: AssetImage('images/color_197278.png'),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      task.color = 0xff283d3b;
                      Navigator.of(context).pop();
                    },
                    child: const Image(
                      image: AssetImage('images/color_283d3b.png'),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      task.color = 0xff3D348B;
                      Navigator.of(context).pop();
                    },
                    child: const Image(
                      image: AssetImage('images/color_3D348B.png'),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      task.color = 0xff684551;
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
                      task.color = 0xffD15387;
                      Navigator.of(context).pop();
                    },
                    child: const Image(
                      image: AssetImage('images/color_D15387.png'),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      task.color = 0xffDDEDAA;
                      Navigator.of(context).pop();
                    },
                    child: const Image(
                      image: AssetImage('images/color_DDEDAA.png'),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      task.color = 0xff7AC74F;
                      Navigator.of(context).pop();
                    },
                    child: const Image(
                      image: AssetImage('images/color_7AC74F.png'),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      task.color = 0xffc44900;
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
                  task.color = 0xffffffff;
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
