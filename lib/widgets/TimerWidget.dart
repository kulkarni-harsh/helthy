import 'dart:async';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:helthy/constants/colors.dart';
import 'package:helthy/models/MentalModel.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class TimerWidget extends StatefulWidget {
  const TimerWidget(
      {Key? key,
      required this.title,
      required this.musicUrl,
      required this.assetUrl,
      required this.description})
      : super(key: key);

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
  final String title;
  final String musicUrl;
  final String assetUrl;
  final String description;
}

class _TimerWidgetState extends State<TimerWidget> {
  final box = Hive.box('mental');

  AudioPlayer audioPlayer = AudioPlayer();
  Timer a = Timer(Duration(seconds: 0), () {});
  bool isTimeSet = false;
  bool isTimeCanceled = false;
  CountDownController controller = CountDownController();

  Duration duration = Duration(seconds: 0);
  updateValue(Duration d) async {
    final now = DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();
    MentalModel xy = await box.get(now, defaultValue: MentalModel());
    switch (widget.title) {
      case "Deep Breathing":
        xy..deepBreathing += d.inSeconds;
        break;

      case "Imagery Meditation":
        xy..imageryMeditation += d.inSeconds;
        break;
      case "Body Scan":
        xy..bodyScan += d.inSeconds;
        break;
      case "Mindful Breathing":
        xy..mindfulBreathing += d.inSeconds;
        break;
      case "Muscle Relaxation":
        xy..muscleRelaxation += d.inSeconds;
        break;
      case "Freeform Meditation":
        xy..freeformMeditation += d.inSeconds;
        break;

      default:
        xy..freeformMeditation += d.inSeconds;
    }
    await box.put(now, xy);
  }

  play(Duration duration) async {
    a = Timer(
      duration,
      () {
        stop();

        print("STOPPED");
      },
    );

    audioPlayer.setReleaseMode(ReleaseMode.STOP);
    if (kIsWeb) {
      print("WEB");
      int result = await audioPlayer.play(widget.musicUrl, isLocal: false);
      if (result == 1) {
        print("Start");
      }
    } else {
      print("Not WEB");
      AudioCache cachePlayer = AudioCache(
        fixedPlayer: audioPlayer,
      );
      cachePlayer.load(widget.assetUrl);

      cachePlayer.loop(widget.assetUrl);
    }
  }

  stop() async {
    if (kIsWeb) {
      print("WEB");
      audioPlayer.stop();
    } else {
      print("NOT WEB");
      int result = await audioPlayer.stop();
      if (result == 1) {
        print("stop");
      }
    }
    duration = Duration(seconds: 0);
    setState(() {
      if (!isTimeCanceled) {
        showDialog(
          context: context,
          builder: (context) => CupertinoAlertDialog(
              title: Text("Session Ended"),
              content: Text("Glad to assist you"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("OK"),
                ),
              ]),
        );
        isTimeCanceled = false;
      }
      isTimeSet = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isTimeSet) {
      play(duration);
    }
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => CupertinoAlertDialog(
                    title: Text("Session Info"),
                    content: Text(widget.description),
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
            icon: Icon(
              Icons.info_outline_rounded,
              color: kPrimaryColor,
            ),
          ),
        ],
        title: Text(
          widget.title,
          style: TextStyle(
            color: kPrimaryColor,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white70,
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                height: MediaQuery.of(context).size.height / 1.3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    isTimeSet
                        ? Expanded(
                            child: CircularCountDownTimer(
                              controller: controller,
                              onComplete: () {
                                print("Time Done $duration");
                                updateValue(duration);
                                print("ADDition done");
                                print(box
                                    .get(DateFormat('yyyy-MM-dd')
                                        .format(DateTime.now())
                                        .toString())!
                                    .freeformMeditation);
                              },
                              strokeWidth: 25,
                              width: MediaQuery.of(context).size.width / 1.2,
                              height: MediaQuery.of(context).size.height / 1.2,
                              duration: duration.inSeconds,
                              fillColor: kPrimaryColor,
                              ringColor: kPrimaryColor.withOpacity(0.5),
                              isReverse: true,
                              isReverseAnimation: true,
                              textStyle: TextStyle(
                                color: kPrimaryColor,
                                fontSize: 40,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          )
                        : Expanded(
                            child: DurationPicker(
                              onChange: (d) {
                                duration = d;
                              },
                              width: MediaQuery.of(context).size.width / 1.2,
                            ),
                          ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Container(
                        child: IconButton(
                          iconSize: 80,
                          padding: EdgeInsets.zero,
                          onPressed: isTimeSet
                              ? () {
                                  setState(() {
                                    isTimeSet = false;
                                    stop();
                                    controller.pause();
                                    print(controller.getTime());
                                    String v = controller.getTime();
                                    if (v.length < 3)
                                      updateValue(
                                          Duration(seconds: int.parse(v)));
                                    else if (v.length < 6)
                                      updateValue(Duration(
                                          seconds: Duration(
                                                  minutes:
                                                      int.parse(v[0] + v[1]),
                                                  seconds:
                                                      int.parse(v[3] + v[4]))
                                              .inSeconds));
                                    else
                                      updateValue(Duration(
                                          seconds: Duration(
                                        hours: int.parse(v[0] + v[1]),
                                        minutes: int.parse(v[3] + v[4]),
                                        seconds: int.parse(v[6] + v[7]),
                                      ).inSeconds));

                                    a.cancel();
                                  });
                                }
                              : () {
                                  setState(
                                    () {
                                      if (duration != Duration(seconds: 0)) {
                                        isTimeSet = true;
                                      }
                                    },
                                  );
                                },
                          icon: Icon(
                            isTimeSet //stop_circle_outlined
                                ? Icons.stop_circle_outlined
                                : Icons.play_circle_outline_rounded,
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
