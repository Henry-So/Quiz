import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'basic_quiz.dart';
import 'user_info.dart';

class InformationForm extends StatefulWidget {
  @override
  _InformationFormState createState() => _InformationFormState();
}

class _InformationFormState extends State<InformationForm> {
  String _userName = "";
  DateTime _userDateOfBirth = DateTime.now();
  String _userGender = "";

  bool _userNameWarning = false;
  bool _userDateOfBirthWarning = false;
  bool _userGenderWarning = false;

  bool _loadedJson = false;

  final _normalTextStyle = TextStyle(
    fontSize: 18.0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("請填寫基本資料"),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              autofocus: false,
              onChanged: (name) {
                setState(() {
                  _userName = name;
                });
              },
              decoration: InputDecoration(
                hintText: "姓名",
                hintStyle: _normalTextStyle,
                border: OutlineInputBorder(),
              ),
            ),
          ), // name
          Padding(
            padding: EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2.0)),
                side: BorderSide(color: Colors.white, width: 1.0),
                minimumSize: Size(double.infinity, 50.0),
                primary: Colors.transparent,
              ),
              child: Text(
                "出生日期: " + _toString(_userDateOfBirth),
                style: _normalTextStyle,
              ),
              onPressed: () async {
                final DateTime picked = await showDatePicker(
                  context: context,
                  initialDate: _userDateOfBirth,
                  firstDate: DateTime(1960),
                  lastDate: DateTime.now(),
                );
                if (picked != null && picked != _userDateOfBirth)
                  setState(() {
                    _userDateOfBirth = picked;
                  });
              },
            ),
          ), // date of birth
          Padding(
            padding: EdgeInsets.all(8.0),
            child: DropdownButton(
              value: _userGender.isEmpty ? null : _userGender,
              hint: Text(
                "性別",
                style: _normalTextStyle,
              ),
              items: [
                DropdownMenuItem(value: "男", child: Text("男")),
                DropdownMenuItem(value: "女", child: Text("女")),
              ],
              onChanged: (value) {
                setState(() {
                  _userGender = value;
                });
              },
            ),
          ), // gender
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2.0)),
              side: BorderSide(color: Colors.white, width: 1.0),
              primary: Colors.green,
            ),
            child: Text("遞交"),
            onPressed: () async {
              setState(() {
                _userNameWarning = _userName.isEmpty;
                _userDateOfBirthWarning =
                    _toString(_userDateOfBirth) == _toString(DateTime.now());
                _userGenderWarning = _userGender.isEmpty;
              });
              if (!_userNameWarning &&
                  !_userDateOfBirthWarning &&
                  !_userGenderWarning) {
                // all information is correctly filed
                currentUserInfo = UserInfo(_userName, _userDateOfBirth, _userGender);

                if (!_loadedJson) {
                  String json = await rootBundle.loadString('assets/data.json');
                  List<dynamic> loaded = jsonDecode(json);
                  loaded.forEach((data) {
                    quizzes.add(Quiz.fromJson(data));
                  });
                  _loadedJson = true;
                }
                Navigator.pushNamed(context, '/');
              }
            },
          ),
          Padding(padding: EdgeInsets.all(18.0)),
          Text(
            _userNameWarning ? "請填寫姓名" : "",
            style: Theme.of(context).textTheme.headline1,
          ),
          Text(
            _userDateOfBirthWarning ? "請填寫出生日期" : "",
            style: Theme.of(context).textTheme.headline1,
          ),
          Text(
            _userGenderWarning ? "請填寫性別" : "",
            style: Theme.of(context).textTheme.headline1,
          )
        ],
      ),
    );
  }
}

String _toString(DateTime date) {
  return "${date.day}/${date.month}/${date.year}";
}
