import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';

import 'basic_quiz.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  RandomColor _randomColor = RandomColor();

  @override
  Widget build(BuildContext context) {
    var buttons = <Widget>[];
    quizzes.forEach((quiz) {
      buttons.add(Padding(
          padding: EdgeInsets.all(12.0),
          child: _button(
              quiz.title,
              _randomColor.randomColor(
                  colorHue: ColorHue.blue,
                  colorBrightness: ColorBrightness.dark),
              () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => quiz)))));
    });
    return Scaffold(
      appBar: AppBar(
        title: Text("考驗"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[Text("請選擇一個測試")] + buttons,
      ),
    );
  }

  Widget _button(String title, Color color, Function func) {
    return Padding(
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(350.0, 50.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          side: BorderSide(color: Colors.white, width: 3.0),
          primary: _randomColor.randomColor(
            colorHue: ColorHue.blue,
            colorBrightness: ColorBrightness.dark,
          ),
        ),
        onPressed: func,
        child: Text(title),
      ),
    );
  }
}
