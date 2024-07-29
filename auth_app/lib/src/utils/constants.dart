import 'package:flutter/material.dart';

String apiUrl = 'http://192.168.1.3:8000/api';

double screenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double screenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}
