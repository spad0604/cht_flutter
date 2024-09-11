import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html_parser;
import 'package:html/dom.dart';

Future<List<List<String>>> fetchTableData(int id) async {
  List<List<String>> columns = [];

  final response = await http.get(Uri.parse('http://thptchuyen.hatinh.edu.vn/upload/51504/20240905/34e79e/Web20240906/tkb_class_${id}_0.html'));

  if (response.statusCode == 200) {
    var utf8Body = utf8.decode(response.bodyBytes);
    Document document = html_parser.parse(utf8Body);

    var table = document.querySelector('table');
    if (table != null) {
      var rows = table.querySelectorAll('tr');

      int columnCount = rows.first.querySelectorAll('td').length;

      columns = List.generate(columnCount, (_) => []);

      for (var row in rows) {
        var cells = row.querySelectorAll('td');
        
        for (int i = 0; i < cells.length; i++) {
          columns[i].add(cells[i].text.trim());
        }
      }
    }
  }

  return columns;
}
