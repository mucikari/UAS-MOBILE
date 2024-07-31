import 'package:flutter/material.dart';
import 'data.dart';

class ReportProvider with ChangeNotifier {
  List<Report> _reports = [];
  List<String> _notifications = [];

  List<Report> get reports => _reports;
  List<String> get notifications => _notifications;

  void addReport(Report report) {
    _reports.add(report);
    notifyListeners();
  }

  void addNotification(String message) {
    _notifications.add(message);
    notifyListeners();
  }
}
