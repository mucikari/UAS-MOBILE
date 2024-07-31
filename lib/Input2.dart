import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'report_provider.dart';
import 'data.dart';

class Input2 extends StatefulWidget {
  final String? kecamatan;
  final String? desa;
  final String? jalan;
  final String nama;
  final String nomorHp;
  final String category;

  Input2({
    this.kecamatan,
    this.desa,
    this.jalan,
    required this.nama,
    required this.nomorHp,
    required this.category,
  });

  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<Input2> {
  final TextEditingController keluhanController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Input data', style: TextStyle(color: Colors.black)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Gambar',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Center(
              child: Column(
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(Icons.camera_alt, size: 100, color: Colors.blue),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Tambahkan kode di sini jika perlu
                    },
                    child: Text('input',
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Keluhan',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            _buildTextField('Keluhan', '-- Keluhan --', keluhanController,
                maxLines: 4),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  final report = Report(
                    kecamatan: widget.kecamatan ?? '',
                    desa: widget.desa ?? '',
                    jalan: widget.jalan ?? '',
                    nama: widget.nama,
                    nomorHp: widget.nomorHp,
                    keluhan: keluhanController.text,
                    status: 'Pending',
                    category: widget.category,
                  );

                  final notificationMessage = 'Kamu telah melaporkan ${widget.category} pada ${DateTime.now().toString()}.';

                  Provider.of<ReportProvider>(context, listen: false)
                      .addReport(report);
                  Provider.of<ReportProvider>(context, listen: false)
                      .addNotification(notificationMessage);

                  // Navigasi ke halaman Home dan hapus semua rute sebelumnya
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/home',
                    (Route<dynamic> route) => false, // Menghapus seluruh tumpukan
                  );
                },
                child: Text('kirim',
                    style: TextStyle(fontSize: 16, color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
      String label, String hint, TextEditingController controller,
      {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
