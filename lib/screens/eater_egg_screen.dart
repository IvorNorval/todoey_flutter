import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey_flutter/constants.dart';
import 'package:todoey_flutter/services/hive_helper.dart';

class EasterEggScreen extends StatelessWidget {
  final EasterEggs eggTrigger;
  static const String id = 'EasterEggScreen';

  const EasterEggScreen({Key key, this.eggTrigger}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String eggImage;
    if (eggTrigger == EasterEggs.AllDone) {
      eggImage = 'images/boxes.gif';
    } else if (eggTrigger == EasterEggs.noTasks) {
      eggImage = 'images/egg1.gif';
    } else if (eggTrigger == EasterEggs.manyBoxes) {
      eggImage = 'images/manyBoxes.gif';
    }
    return Consumer<HiveHelper>(
      builder: (context, hiveHelper, Widget child) {
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
