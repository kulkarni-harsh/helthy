import 'package:flutter/material.dart';
import 'package:helthy/constants/colors.dart';
import 'package:helthy/constants/models.dart';
import 'package:helthy/models/MentalModel.dart';
import 'package:helthy/widgets/StopwatchWidget.dart';
import 'package:helthy/widgets/TimerWidget.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class MentalHomePage extends StatefulWidget {
  const MentalHomePage({Key? key}) : super(key: key);

  @override
  _MentalHomePageState createState() => _MentalHomePageState();
}

class _MentalHomePageState extends State<MentalHomePage> {
  final now = DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();

  @override
  Widget build(BuildContext context) {
    final box = Hive.box('mental');

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
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                  child: Row(
                    children: [
                      Text(
                        kMentalExercisesList[index].title,
                      ),
                      Spacer(),
                      Text(
                        "${(content / 60).floor()} : ${content % 60}",
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
