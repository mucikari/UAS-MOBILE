import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Home.dart';
import 'Akun.dart';
import 'report_provider.dart';

class Report extends StatefulWidget {
  final int initialTab;

  Report({required this.initialTab});

  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<Report> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this, initialIndex: widget.initialTab);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Report'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Jalan'),
            Tab(text: 'Air'),
            Tab(text: 'Got'),
            Tab(text: 'Lampu'),
          ],
        ),
        automaticallyImplyLeading: false, // Menyembunyikan tombol back
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ReportList(category: 'Jalan'),
          ReportList(category: 'Air'),
          ReportList(category: 'Got'),
          ReportList(category: 'Lampu'),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.data_usage),
            label: 'Data',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
        ],
        currentIndex: 1, // Index of the 'Data' tab
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Home()),
            );
          } else if (index == 1) {
            // Do nothing since we are already on the Report screen
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Akun()),
            );
          }
        },
      ),
    );
  }
}

class ReportList extends StatelessWidget {
  final String category;

  ReportList({required this.category});

  @override
  Widget build(BuildContext context) {
    final reports = Provider.of<ReportProvider>(context)
        .reports
        .where((report) => report.category == category)
        .toList();

    return ListView.builder(
      padding: EdgeInsets.all(16.0),
      itemCount: reports.length,
      itemBuilder: (context, index) {
        final report = reports[index];
        return _buildReportItem(
          report.category, // Tampilkan kategori di report
          report.kecamatan,
          report.desa,
          report.jalan,
          report.status,
        );
      },
    );
  }

  Widget _buildReportItem(String category, String kecamatan, String desa, String jalan, String status) {
    Color statusColor = status == 'processed' ? Colors.green : Colors.red;
    return Card(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              category,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: [
                _buildInfoColumn('Kecamatan', kecamatan),
                _buildInfoColumn('Desa', desa),
                _buildInfoColumn('Jalan', jalan),
              ],
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoColumn(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(value),
      ],
    );
  }
}
