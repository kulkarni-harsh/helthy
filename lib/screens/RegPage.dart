import 'package:flutter/material.dart';
import 'package:helthy/constants/colors.dart';
import 'package:helthy/models/User.dart';
import 'package:hive/hive.dart';

import 'MentalMainPage.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController userNameController = TextEditingController();

  TextEditingController ageController = TextEditingController();

  TextEditingController weightController = TextEditingController();

  done() async {
    await Hive.openBox('user');
    User user;
    try {
      user = User()
        ..userName = userNameController.text
        ..age = int.parse(ageController.text)
        ..weight = int.parse(weightController.text);
    } catch (e) {
      user = User()
        ..age = 20
        ..userName = "Boomer"
        ..weight = 60;
    }
    await Hive.box('user').put('user', user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tell Us About Yourself",
          style: TextStyle(color: kPrimaryColor),
        ),
        backgroundColor: Colors.white70,
      ),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Column(children: [
              TextField(
                keyboardType: TextInputType.name,
                controller: userNameController,
                decoration: InputDecoration(
                  helperText: "Enter Your Name",
                ),
              ),
              SizedBox(height: 10),
              TextField(
                keyboardType: TextInputType.number,
                controller: ageController,
                decoration: InputDecoration(
                  helperText: "Enter Age",
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: weightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  helperText: "Enter Weight",
                ),
              ),
            ]),
          ),
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: GestureDetector(
                onTap: () {
                  done();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MentalMainPage()));
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: kPrimaryColor,
                  ),
                  height: 60,
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Center(
                    child: Text(
                      "DONE",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
// Navigator.push(context,
//               MaterialPageRoute(builder: (context) => MentalMainPage()));
//         },
