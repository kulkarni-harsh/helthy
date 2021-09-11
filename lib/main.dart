import 'package:flutter/material.dart';
import 'package:helthy/constants/colors.dart';
import 'package:helthy/models/MentalModel.dart';
import 'package:helthy/models/User.dart';
import 'package:helthy/screens/MentalMainPage.dart';
import 'package:helthy/screens/RegPage.dart';
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
