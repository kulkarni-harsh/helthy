import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helthy/constants/colors.dart';
import 'package:helthy/constants/models.dart';
import 'package:helthy/constants/styles.dart';
import 'package:helthy/models/MentalModel.dart';
import 'package:helthy/models/User.dart';
import 'package:helthy/widgets/StopwatchWidget.dart';
import 'package:helthy/widgets/TimerWidget.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class MentalHomePage extends StatefulWidget {
  const MentalHomePage({Key? key}) : super(key: key);

  @override
  _MentalHomePageState createState() => _MentalHomePageState();
}

class _MentalHomePageState extends State<MentalHomePage> {
  late String userName;

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  final now = DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();
  getUserData() async {}

  @override
  Widget build(BuildContext context) {
    final box = Hive.box('mental');
    User user = Hive.box('user').get('user',
        defaultValue: User()
          ..userName = "User"
          ..weight = 50
          ..age = 20);
    userName = user.userName;
    MentalModel element = box.get(now, defaultValue: MentalModel());
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white70,
            floating: true,
            title: Text(
              "Welcome to Mind Zone",
              style: TextStyle(color: kPrimaryColor),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              color: kPrimaryColor,
              child: Center(
                child: Text(
                  "Hello " + userName + " !!!",
                  style: kBannerText,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => CupertinoAlertDialog(
                            title: Text("Quote 4 U"),
                            content: Text(
                                quotes[Random().nextInt(quotes.length)],
                                style: TextStyle(fontSize: 20)),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("OK"),
                              ),
                            ]),
                      );
                    },
                    child: Center(
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: kPrimaryColor),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: kPrimaryColor.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Text(
                          "Get Inspiring Quotes",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    "Your Activities",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              int content;
              switch (kMentalExercisesList[index].title) {
                case "Deep Breathing":
                  content = element.deepBreathing;

                  break;

                case "Imagery Meditation":
                  content = element.imageryMeditation;
                  break;
                case "Body Scan":
                  content = element.bodyScan;
                  break;
                case "Mindful Breathing":
                  content = element.mindfulBreathing;
                  break;
                case "Muscle Relaxation":
                  content = element.muscleRelaxation;
                  break;
                case "Freeform Meditation":
                  content = element.freeformMeditation;
                  break;

                default:
                  content = element.freeformMeditation;
              }
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    kMentalExercisesList[index].title == "Freeform Meditation"
                        ? MaterialPageRoute(
                            builder: (context) => TimerWidget(
                                title: kMentalExercisesList[index].title,
                                musicUrl: kMentalExercisesList[index].audioUrl,
                                assetUrl: kMentalExercisesList[index].assetUrl,
                                description:
                                    kMentalExercisesList[index].description),
                          )
                        : MaterialPageRoute(
                            builder: (context) => StopwatchWidget(
                                title: kMentalExercisesList[index].title,
                                musicUrl: kMentalExercisesList[index].audioUrl,
                                assetUrl: kMentalExercisesList[index].assetUrl,
                                duration: kMentalExercisesList[index].duration,
                                description:
                                    kMentalExercisesList[index].description),
                          ),
                  ).then((value) {
                    setState(() {});
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: boxshadow,
                  ),
                  child: Row(
                    children: [
                      Text(
                        kMentalExercisesList[index].title,
                        overflow: TextOverflow.ellipsis,
                        style: tileTextStyle,
                      ),
                      Spacer(),
                      Column(
                        children: [
                          Text(
                            "${(content / 60).floor()}".padLeft(2, "0"),
                            style: hrStyle,
                          ),
                          Text(
                            "${content % 60}".padLeft(2, "0"),
                            style: minStyle,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }, childCount: kMentalExercisesList.length),
          ),
        ],
      ),
    );
  }
}
