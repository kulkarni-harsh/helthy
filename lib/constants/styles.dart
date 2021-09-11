import 'package:flutter/material.dart';

import 'colors.dart';

TextStyle kBannerText = TextStyle(color: Colors.white, fontSize: 60);
List<BoxShadow> boxshadow = [
  BoxShadow(
    color: kPrimaryColor.withOpacity(0.5),
    spreadRadius: 5,
    blurRadius: 7,
    offset: Offset(0, 3), // changes position of shadow
  ),
];

TextStyle tileTextStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w500,
);
TextStyle hrStyle = TextStyle(
  fontWeight: FontWeight.w600,
  fontSize: 35,
);
TextStyle minStyle = TextStyle(
  fontWeight: FontWeight.w600,
  color: Colors.black54,
  fontSize: 25,
);
String kChartInfo =
    "You can analyze the data as u wish.\nClick on the bar name in legend to toggle it's visibility.\nNote that Time is given in seconds to provide better clarity";
