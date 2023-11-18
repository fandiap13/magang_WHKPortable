import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TabelDetailKesehatan extends StatelessWidget {
  const TabelDetailKesehatan(
      {super.key,
      required this.data,
      required this.totalItem,
      required this.currentPage,
      required this.limit});

  final List data;
  final int totalItem;
  final int currentPage;
  final int limit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              rows: _createRows(),
              columns: _createColumns(),
            )),
      ],
    );
  }

  List<DataColumn> _createColumns() {
    return [
      const DataColumn(label: Text('ID')),
      const DataColumn(label: Text('Tanggal Mulai')),
      const DataColumn(label: Text('Tanggal Selesai')),
      const DataColumn(label: Text('Hasil')),
      const DataColumn(label: Text('Durasi (detik)')),
      const DataColumn(label: Text('Status')),
    ];
  }

  List<DataRow> _createRows() {
    int offset = (currentPage - 1) * limit;

    return data.map((periksa) {
      offset++;
      return DataRow(cells: [
        DataCell(Text((offset).toString())),
        DataCell(Text(DateFormat('dd MMM y HH:mm:ss')
            .format(DateTime.parse(periksa['start_at'])))),
        DataCell(Text(DateFormat('dd MMM y HH:mm:ss')
            .format(DateTime.parse(periksa['end_at'])))),
        DataCell(Text(periksa['value'].toString())),
        DataCell(Text(periksa['duration'].toString())),
        DataCell(Text(periksa['status'].toString())),
      ]);
    }).toList();
  }
}
