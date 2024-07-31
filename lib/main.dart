// main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'report_provider.dart';
import 'Start.dart';
import 'Home.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ReportProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => Start(),
          '/home': (context) => Home(),
          // Add other routes if necessary
        },
      ),
    ),
  );
}
