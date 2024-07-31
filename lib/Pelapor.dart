import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import paket intl
import 'Input2.dart';
import 'Notifikasi.dart';

class Pelapor extends StatefulWidget {
  final String category;

  Pelapor({required this.category});

  @override
  _PelaporPageState createState() => _PelaporPageState();
}

class _PelaporPageState extends State<Pelapor> {
  String? selectedKecamatan;
  String? selectedDesa;
  String? selectedJalan;
  List<String> desaOptions = [];
  List<String> jalanOptions = [];
  final TextEditingController namaController = TextEditingController();
  final TextEditingController nomorHpController = TextEditingController();

  Map<String, List<String>> desaOptionsMap = {
    'Jatiasih': [
      'Jatiasih',
      'Jatiluhur',
      'Jatimekar',
      'Jatikramat',
      'Jatirasa',
      'Jatisari'
    ],
    'Pondok Gede': ['Jatibening', 'Jaticempaka', 'Jatimakmur', 'Jatiwaringin'],
    'Rawalumbu': [
      'Pengasinan',
      'Bojong Menteng',
      'Sepanjang Jaya',
    ],
  };

  Map<String, List<String>> jalanOptionsMap = {
    'Jatiasih': ['Jl. Swatantra IV', 'Jln. Garuda'],
    'Jatiluhur': ['Jl. Wibawa Mukti ll', 'Jl. H. Longkot'],
    'Jatimekar': ['Jl. Dr.Ratna', 'Jl. Damai'],
    'Jatikramat': ['Jl. Makom', 'Jl. H. Anwar'],
    'Jatirasa': ['Jl. Tamba', 'Jl. Gn. Putri'],
    'Jatisari': ['Jl. Brantas Raya', 'Jl. Sirojul Munir'],
    'Jatibening': ['Jl. Tidore', 'JL, Ternate'],
    'Jaticempaka': ['Jl. Cempaka Baru', 'Jl. Anugerah Raya'],
    'Jatimakmur': ['Jl. Kemang Sari 4', 'Jl.Kemang Pulo'],
    'Jatiwaringin': ['Jl. Raya Jatiwaringin', 'Jl. Setia 1'],
    'Pengasinan': ['Jl. Pengasinan', 'Jl.Kesehatan'],
    'Bojong Menteng': ['Jl. Cipendawa Baru', 'Jl. Siliwangi'],
    'Sepanjang Jaya': ['Jl. Cut Mutia', 'Jl. Bambu Kuning'],
  };

  @override
  void initState() {
    super.initState();
    desaOptions = desaOptionsMap.keys.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('Input data - ${widget.category}'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Alamat',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            _buildTextField('Nama', '-- Nama --', namaController),
            _buildTextField('Nomor HP', '--Nomor Hp--', nomorHpController),
            _buildDropdownField('Kecamatan', selectedKecamatan, (value) {
              setState(() {
                selectedKecamatan = value;
                selectedDesa = null;
                selectedJalan = null;
                desaOptions = desaOptionsMap[selectedKecamatan] ?? [];
                jalanOptions = [];
              });
            }, desaOptionsMap.keys.toList()),
            _buildDropdownField('Desa', selectedDesa, (value) {
              setState(() {
                selectedDesa = value;
                selectedJalan = null;
                jalanOptions = jalanOptionsMap[selectedDesa] ?? [];
              });
            }, desaOptions),
            _buildDropdownField('Jalan', selectedJalan, (value) {
              setState(() {
                selectedJalan = value;
              });
            }, jalanOptions),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Input2(
                      kecamatan: selectedKecamatan,
                      desa: selectedDesa,
                      jalan: selectedJalan,
                      nama: namaController.text,
                      nomorHp: nomorHpController.text,
                      category: widget.category,
                    )),
                  ).then((_) {
                    // Menggunakan DateFormat untuk format tanggal yang lebih baik
                    final now = DateTime.now();
                    final formattedDate = DateFormat('dd MMMM yyyy HH:mm:ss').format(now);

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Notifikasi(
                        message: 'Kamu telah melaporkan ${widget.category} pada $formattedDate.',
                      )),
                    );
                  });
                },
                child: Text('selanjutnya',
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

  Widget _buildTextField(String label, String hint, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildDropdownField(String label, String? selectedValue,
      ValueChanged<String?> onChanged, List<String> options) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField<String>(
          value: selectedValue,
          decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(),
          ),
          dropdownColor: Colors.white,
          items: options.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: TextStyle(
                  color: value == selectedValue ? Colors.blue : Colors.black,
                ),
              ),
            );
          }).toList(),
          onChanged: onChanged,
          selectedItemBuilder: (BuildContext context) {
            return options.map<Widget>((String item) {
              return Text(
                item,
                style: TextStyle(
                    color: Colors.black), // Warna teks saat item dipilih tetap hitam
              );
            }).toList();
          },
        ),
      ),
    );
  }
}
