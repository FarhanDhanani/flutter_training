library constants;

import 'package:random_string/random_string.dart';

const int nameLength = 10;
const List<String> cities = ["karachi", "lahore", "islamabad"];

String defaultCity = cities[0];

List<Map> suggestions = [
  {'id': 1, 'name': randomAlphaNumeric(nameLength), 'isFavourite': 0},
  {'id': 2, 'name': randomAlphaNumeric(nameLength), 'isFavourite': 1},
  {'id': 3, 'name': randomAlphaNumeric(nameLength), 'isFavourite': 0},
  {'id': 4, 'name': randomAlphaNumeric(nameLength), 'isFavourite': 0},
  {'id': 5, 'name': randomAlphaNumeric(nameLength), 'isFavourite': 0},
  {'id': 6, 'name': randomAlphaNumeric(nameLength), 'isFavourite': 0},
  {'id': 7, 'name': randomAlphaNumeric(nameLength), 'isFavourite': 0},
  {'id': 8, 'name': randomAlphaNumeric(nameLength), 'isFavourite': 1},
  {'id': 9, 'name': randomAlphaNumeric(nameLength), 'isFavourite': 0},
  {'id': 10, 'name': randomAlphaNumeric(nameLength), 'isFavourite': 1},
];