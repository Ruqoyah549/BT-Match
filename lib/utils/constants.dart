import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const BASE_URL = "http://api.football-data.org";

const API_KEY = "564fca52235049969af659e678a4e32c";

const MATCH_API = "/v4/competitions/PL/matches?status=FINISHED&season=2021";

const kPrimaryColor = Color(0xFFFD2780);

final kFormatDate = new DateFormat.yMMMMd();

Map<int, Color> color = {
  50: Color.fromRGBO(136, 14, 79, .1),
  100: Color.fromRGBO(136, 14, 79, .2),
  200: Color.fromRGBO(136, 14, 79, .3),
  300: Color.fromRGBO(136, 14, 79, .4),
  400: Color.fromRGBO(136, 14, 79, .5),
  500: Color.fromRGBO(136, 14, 79, .6),
  600: Color.fromRGBO(136, 14, 79, .7),
  700: Color.fromRGBO(136, 14, 79, .8),
  800: Color.fromRGBO(136, 14, 79, .9),
  900: Color.fromRGBO(136, 14, 79, 1),
};

MaterialColor kCustomColor = MaterialColor(0xFFFD2780, color);
