import 'package:flutter/material.dart';
import 'package:helthy/constants/colors.dart';
import 'package:helthy/models/MentalModel.dart';
import 'package:helthy/models/User.dart';
import 'package:helthy/screens/MentalHomePage.dart';
import 'package:helthy/screens/MentalMainPage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(MentalModelAdapter());

  Hive.registerAdapter(UserAdapter());
  print("main");
  final boxExists = await Hive.boxExists('mental');
  await Hive.openBox('mental');
  await Hive.openBox('user');

  runApp(MyApp(boxExists: boxExists));
}

class MyApp extends StatelessWidget {
  final bool boxExists;
  const MyApp({Key? key, required this.boxExists}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Palette.kToDark,
      ),
      home: boxExists ? MentalMainPage() : RegistrationPage(),
    );
  }
}

class RegistrationPage extends StatelessWidget {
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
                  Navigator.push(
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
