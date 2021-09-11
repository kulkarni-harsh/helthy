import 'package:audioplayers/audioplayers.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:helthy/constants/colors.dart';
import 'package:helthy/constants/styles.dart';
import 'package:helthy/models/MentalModel.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class StopwatchWidget extends StatefulWidget {
  final String title;
  final String musicUrl;
  final String assetUrl;
  final Duration duration;
  final String description;

  const StopwatchWidget(
      {Key? key,
      required this.title,
      required this.musicUrl,
      required this.assetUrl,
      required this.duration,
      required this.description})
      : super(key: key);

  @override
  _StopwatchWidgetState createState() => _StopwatchWidgetState();
}

class _StopwatchWidgetState extends State<StopwatchWidget> {
  bool isStopped = true;
  AudioPlayer audioPlayer = AudioPlayer();

  CountDownController controller = CountDownController();
  updateValue(Duration d) async {
    final box = Hive.box('mental');
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

  play() async {
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

      cachePlayer.play(widget.assetUrl);
    }
  }

  stop() async {
    if (kIsWeb) {
      print("WEB");
      audioPlayer.pause();
    } else {
      print("NOT WEB");
      int result = await audioPlayer.pause();
      if (result == 1) {
        print("stop");
      }
    }
    setState(() {
      isStopped = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            widget.title,
            style: TextStyle(
              color: kPrimaryColor,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white70,
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
          ]),
      body: Container(
        height: MediaQuery.of(context).size.height / 1.3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 5,
            ),
            Text(
              "Total Time ${widget.duration.inMinutes} : ${widget.duration.inSeconds % 100}",
              style: kBannerText.copyWith(color: Colors.black87, fontSize: 25),
            ),
            Expanded(
              child: CircularCountDownTimer(
                onComplete: () {
                  isStopped = true;
                  String v = controller.getTime();
                  if (v.length < 3)
                    updateValue(Duration(seconds: int.parse(v)));
                  else if (v.length < 6)
                    updateValue(Duration(
                        seconds: Duration(
                                minutes: int.parse(v[0] + v[1]),
                                seconds: int.parse(v[3] + v[4]))
                            .inSeconds));
                  else
                    updateValue(Duration(
                        seconds: Duration(
                      hours: int.parse(v[0] + v[1]),
                      minutes: int.parse(v[3] + v[4]),
                      seconds: int.parse(v[6] + v[7]),
                    ).inSeconds));

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
                },
                controller: controller,
                isReverse: false,
                isReverseAnimation: false,
                autoStart: false,
                strokeWidth: 25,
                width: MediaQuery.of(context).size.width / 1.2,
                height: MediaQuery.of(context).size.height / 1.2,
                duration: widget.duration.inSeconds,
                fillColor: kPrimaryColor,
                ringColor: kPrimaryColor.withOpacity(0.5),
                textStyle: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Container(
                child: IconButton(
                  iconSize: 80,
                  padding: EdgeInsets.zero,
                  onPressed: isStopped
                      ? () {
                          setState(() {
                            isStopped = false;
                            play();

                            controller.resume();
                          });
                        }
                      : () {
                          setState(
                            () {
                              isStopped = true;
                              String v = controller.getTime();
                              if (v.length < 3)
                                updateValue(Duration(seconds: int.parse(v)));
                              else if (v.length < 6)
                                updateValue(
                                  Duration(
                                      seconds: Duration(
                                              minutes: int.parse(v[0] + v[1]),
                                              seconds: int.parse(v[3] + v[4]))
                                          .inSeconds),
                                );
                              else
                                updateValue(
                                  Duration(
                                      seconds: Duration(
                                    hours: int.parse(v[0] + v[1]),
                                    minutes: int.parse(v[3] + v[4]),
                                    seconds: int.parse(v[6] + v[7]),
                                  ).inSeconds),
                                );

                              stop();
                              controller.pause();
                            },
                          );
                        },
                  icon: Icon(
                    !isStopped //stop_circle_outlined
                        ? Icons.pause_circle_filled_outlined
                        : Icons.play_circle_outline_rounded,
                    color: kPrimaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
