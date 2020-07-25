import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey_flutter/services/hive_helper.dart';

class EasterEggScreen extends StatelessWidget {
  static const String id = 'EasterEggScreen';

  @override
  Widget build(BuildContext context) {
    return Consumer<HiveHelper>(
      builder: (context, hiveHelper, Widget child) {
        String eggImage;
        if (hiveHelper.getTaskBoxLength() == 0)
          eggImage = 'images/egg1.gif';
        else if (hiveHelper.getTaskBoxLength() == 10)
          eggImage = 'images/manyBoxes.gif';
        else
          eggImage = 'images/boxes.gif';

        return SingleChildScrollView(
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              color: Color(0xFF757575),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Image(
                      image: AssetImage(eggImage),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
