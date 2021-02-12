import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shimmer/shimmer.dart';
import 'package:todoey_flutter/models/task.dart';

class TaskTile extends StatefulWidget {
  const TaskTile({this.onChangedFunction, this.task});
  final void Function(bool) onChangedFunction;
  final Task task;

  @override
  _TaskTileState createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(4),
      color: Color(widget.task.color),
      child: InkWell(
        splashColor: const Color(0xff197278),
        onTap: () =>
            Fluttertoast.showToast(msg: "", toastLength: Toast.LENGTH_SHORT),
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
                      widget.task.taskText,
                      style: TextStyle(
                        decoration: widget.task.isDone
                            ? TextDecoration.lineThrough
                            : null,
                        color: widget.task.color == 0xffffffff ||
                                widget.task.color == 0xffDDEDAA
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
                color: widget.task.color == 0xffffffff ||
                        widget.task.color == 0xffDDEDAA
                    ? const Color(0xFF283d3b)
                    : Colors.white,
              ),
              onPressed: () {
                _selectRunsDialog(context: context, task: widget.task);
              },
            ),
            Theme(
              data: ThemeData(
                unselectedWidgetColor: widget.task.color == 0xffffffff ||
                        widget.task.color == 0xffDDEDAA
                    ? const Color(0xFF283d3b)
                    : Colors.white,
              ),
              child: Checkbox(
                value: widget.task.isDone,
                activeColor: const Color(0xfFc44900),
                onChanged: widget.onChangedFunction,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectRunsDialog({BuildContext context, Task task}) async {
    final List<Widget> widgets = [];
    final Widget widget = Column(
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  task.color = 0xff197278;
                  Navigator.of(context).pop();
                });
              },
              child: const Image(
                image: AssetImage('images/color_197278.png'),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  task.color = 0xff283d3b;
                  Navigator.of(context).pop();
                });
              },
              child: const Image(
                image: AssetImage('images/color_283d3b.png'),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  task.color = 0xff3D348B;
                  Navigator.of(context).pop();
                });
              },
              child: const Image(
                image: AssetImage('images/color_3D348B.png'),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  task.color = 0xff684551;
                  Navigator.of(context).pop();
                });
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
                setState(() {
                  task.color = 0xffD15387;
                  Navigator.of(context).pop();
                });
              },
              child: const Image(
                image: AssetImage('images/color_D15387.png'),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  task.color = 0xffDDEDAA;
                  Navigator.of(context).pop();
                });
              },
              child: const Image(
                image: AssetImage('images/color_DDEDAA.png'),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  task.color = 0xff7AC74F;
                  Navigator.of(context).pop();
                });
              },
              child: const Image(
                image: AssetImage('images/color_7AC74F.png'),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  task.color = 0xffc44900;
                  Navigator.of(context).pop();
                });
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
            setState(() {
              task.color = 0xffffffff;
              Navigator.of(context).pop();
            });
          },
          child: const Image(
            image: AssetImage('images/color_white.png'),
          ),
        ),
        // IconButton(
        //   iconSize: 40,
        //   icon: Shimmer.fromColors(
        //     baseColor: const Color(0xFFedddd4),
        //     period: const Duration(milliseconds: 5000),
        //     highlightColor: const Color(0xFF283d3b),
        //     child: const Icon(
        //       Icons.arrow_back_ios,
        //       color: Colors.white,
        //     ),
        //   ),
        //   onPressed: () {
        //     task.color = 0xffffffff;
        //     Navigator.of(context).pop();
        //   },
        // ),
      ],
    );
    widgets.add(widget);

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
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
          actions: widgets,
        );
      },
    );
  }
}
