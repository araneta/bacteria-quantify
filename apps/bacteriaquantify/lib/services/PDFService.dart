import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:pdf/pdf.dart';
import 'dart:io';
import 'package:http/http.dart' show get;

import 'package:pdf/widgets.dart' as pw;

import '../models/Bacteries.dart';

class PDFService {
  final BuildContext context;

  const PDFService({required this.context});

  Future<Uint8List> generateShareResult(String sampleName,
      String sampleImageURL, List<Bacteries> bacteries) async {
    final pdf = pw.Document();
    print("1");
    var response = await get(Uri.parse(sampleImageURL));
    print("12");
    var data = response.bodyBytes;
    print("3");
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(children: [
          pw.Center(
            child: pw.Text(sampleName),
          ),
          pw.Image(pw.MemoryImage(data))
        ]),
      ),
    );
    print("5");
    //final file = File('example.pdf');
    //await file.writeAsBytes(await pdf.save());
    return await pdf.save();
  }

  void sharePDF() {}
}
