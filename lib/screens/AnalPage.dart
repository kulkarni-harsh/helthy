import 'dart:math';

import 'package:flutter/material.dart';
import 'package:helthy/constants/colors.dart';
import 'package:helthy/models/MentalModel.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class AnalPage extends StatefulWidget {
  const AnalPage({Key? key}) : super(key: key);

  @override
  _AnalPageState createState() => _AnalPageState();
}

class _AnalPageState extends State<AnalPage> {
  late List<DailyExercise> chartData;
  late ZoomPanBehavior zoomPanBehavior;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chartData = getChartData();
    zoomPanBehavior = ZoomPanBehavior(
        enablePanning: true,
        // Performs zooming on double tap
        enableDoubleTapZooming: true);
  }

  List<DailyExercise> getChartData() {
    List<DailyExercise> chartData = [];
    final items = List<DateTime>.generate(
        7,
        (i) => DateTime.utc(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day,
            ).add(Duration(days: -i)));
    for (int i = 0; i < items.length; i++) {
      String a = DateFormat('yyyy-MM-dd').format(items[i]).toString();
      MentalModel x = Hive.box('mental').get(a, defaultValue: MentalModel());
      chartData.add(DailyExercise(
          a,
          x.deepBreathing,
          x.imageryMeditation,
          x.bodyScan,
          x.mindfulBreathing,
          x.muscleRelaxation,
          x.freeformMeditation));
    }
    return chartData;
  }

  @override
  Widget build(BuildContext context) {
    chartData = getChartData();
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(
              "Know Your Achievements",
              style: TextStyle(
                color: kPrimaryColor,
              ),
            ),
            backgroundColor: Colors.white,
          ),
          SliverToBoxAdapter(
            child: Container(
              height: MediaQuery.of(context).size.height / 2.5,
              child: SfCartesianChart(
                legend: Legend(
                    isVisible: true,
                    toggleSeriesVisibility: true,
                    overflowMode: LegendItemOverflowMode.wrap),
                zoomPanBehavior: zoomPanBehavior,
                series: <ChartSeries>[
                  StackedColumnSeries<DailyExercise, String>(
                      name: "Deep Breathing",
                      enableTooltip: true,
                      dataSource: chartData,
                      xValueMapper: (DailyExercise e, _) => e.date,
                      yValueMapper: (DailyExercise e, _) => e.deepBreathing),
                  StackedColumnSeries<DailyExercise, String>(
                      name: "Imagery Meditation",
                      dataSource: chartData,
                      xValueMapper: (DailyExercise e, _) => e.date,
                      yValueMapper: (DailyExercise e, _) =>
                          e.imageryMeditation),
                  StackedColumnSeries<DailyExercise, String>(
                      name: "Body Scan",
                      dataSource: chartData,
                      xValueMapper: (DailyExercise e, _) => e.date,
                      yValueMapper: (DailyExercise e, _) => e.bodyScan),
                  StackedColumnSeries<DailyExercise, String>(
                      name: "Mindful Breathing",
                      dataSource: chartData,
                      xValueMapper: (DailyExercise e, _) => e.date,
                      yValueMapper: (DailyExercise e, _) => e.mindfulBreathing),
                  StackedColumnSeries<DailyExercise, String>(
                      name: "Muscle Relaxation",
                      dataSource: chartData,
                      xValueMapper: (DailyExercise e, _) => e.date,
                      yValueMapper: (DailyExercise e, _) => e.muscleRelaxation),
                  StackedColumnSeries<DailyExercise, String>(
                      name: "Freeform",
                      dataSource: chartData,
                      xValueMapper: (DailyExercise e, _) => e.date,
                      yValueMapper: (DailyExercise e, _) =>
                          e.freeformMeditation)
                ],
                primaryXAxis: CategoryAxis(),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Text(
                "You can analyze the data as u wish.\nClick on the bar name in legend to toggle it's invisibility.\n Note that Time is given in seconds to provide better clarity"),
          ),
          SliverToBoxAdapter(
            child: GestureDetector(
              onTap: () {
                randomize();
                setState(() {});
              },
              child: Container(
                height: 100,
                width: MediaQuery.of(context).size.width / 3,
                color: kPrimaryColor,
                child: Text("Randomize Data"),
              ),
            ),
          ),
        ],
      ),
    );
  }

  randomize() async {
    final items = List<DateTime>.generate(
        7,
        (i) => DateTime.utc(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day,
            ).add(Duration(days: -i)));
    for (int i = 0; i < items.length - 1; i++) {
      String a = DateFormat('yyyy-MM-dd').format(items[i]).toString();
      MentalModel ox = MentalModel()
        ..bodyScan = Random().nextInt(300)
        ..deepBreathing = Random().nextInt(300)
        ..freeformMeditation = Random().nextInt(300)
        ..imageryMeditation = Random().nextInt(300)
        ..mindfulBreathing = Random().nextInt(300)
        ..muscleRelaxation = Random().nextInt(300);
      await Hive.box('mental').put(a, ox);
    }
  }
}

class DailyExercise {
  final String date;
  final int deepBreathing;
  final int imageryMeditation;
  final int bodyScan;
  final int mindfulBreathing;
  final int muscleRelaxation;
  final int freeformMeditation;

  DailyExercise(
      this.date,
      this.deepBreathing,
      this.imageryMeditation,
      this.bodyScan,
      this.mindfulBreathing,
      this.muscleRelaxation,
      this.freeformMeditation);
}
