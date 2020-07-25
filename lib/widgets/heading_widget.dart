import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:todoey_flutter/services/hive_helper.dart';

class Heading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<HiveHelper>(
      builder: (context, hiveHelper, Widget child) {
        return Container(
          padding: EdgeInsets.only(top: 60.0, left: 30.0, right: 30.0, bottom: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Shimmer.fromColors(
                baseColor: Color(0xFFedddd4),
                period: Duration(milliseconds: 5000),
                highlightColor: Color(0xFF283d3b),
                child: Text(
                  'ToDoey',
                  style: TextStyle(
                    color: Color(0xFFedddd4),
                    fontSize: 35.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Text(
                '${hiveHelper.getTaskBoxLength()} todo\'s',
                style: TextStyle(
                  color: Color(0xfFc44900),
                  fontSize: 17.0,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
            ],
          ),
        );
      },
    );
  }
}
