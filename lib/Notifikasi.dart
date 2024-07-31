import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'report_provider.dart';

class Notifikasi extends StatelessWidget {
  final String? message; // Tambahkan parameter message

  Notifikasi({this.message}); // Tambahkan konstruktor

  @override
  Widget build(BuildContext context) {
    final notifications = Provider.of<ReportProvider>(context).notifications;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Notifikasi',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: message != null
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  message!,
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                return NotificationTile(
                  avatarUrl: 'assets/avatar.jpg',
                  name: 'Ikhsan Al Fahrizi',
                  message: notifications[index],
                );
              },
            ),
    );
  }
}

class NotificationTile extends StatelessWidget {
  final String avatarUrl;
  final String name;
  final String message;

  NotificationTile({
    required this.avatarUrl,
    required this.name,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage(avatarUrl),
          ),
          title: Text(
            'Hai $name',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(message),
        ),
        Divider(
          thickness: 1,
          indent: 72,
        ),
      ],
    );
  }
}
