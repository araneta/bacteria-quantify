import 'dart:typed_data';
import 'package:path/path.dart' as Path;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:pdf/pdf.dart';
import 'dart:io';
import 'package:http/http.dart' show get;
import 'package:share_plus/share_plus.dart';
import 'package:pdf/widgets.dart' as pw;

import '../models/Bacteries.dart';

class PDFService {
  final BuildContext context;

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  const PDFService({required this.context});

  Future<void> share(String sampleName, String sampleImageURL,
      List<Bacteries> bacteries) async {
    print("generate pdf");
    //try {
    //https://stackoverflow.com/questions/54379206/flutter-create-directory-on-external-storage-path-path-provider-getexternals
    var pdfBytes =
        await generateShareResult(sampleName!, sampleImageURL, bacteries);
    //print("get external dir");
    //final directory = await getExternalStorageDirectory();
    final directory = await _localPath;

    print("create file");
    final fname = "example.pdf";
    final fpath = "${directory}/${fname}";
    final file = File(fpath);
    print("write");
    await file.writeAsBytes(pdfBytes.toList());
    print("save");
    //dfs.DocumentFileSavePlus().saveFile(pdfBytes, fname, "application/pdf");
    print("share");
    final result =
        await Share.shareXFiles([XFile(fpath)], text: 'Great picture');

    if (result.status == ShareResultStatus.success) {
      print('Thank you for sharing the picture!');
    }
    //} catch (ex) {
    //print(ex);
    //}
  }

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
          pw.Image(pw.MemoryImage(data)),
          pw.Table(
              border: pw.TableBorder.all(color: PdfColors.black),
              children: [
                // The first row just contains a phrase 'INVOICE FOR PAYMENT'
                pw.TableRow(
                  children: [
                    pw.Padding(
                      child: pw.Text(
                        'Bacteria Species',
                        style: pw.Theme.of(context).header4,
                        textAlign: pw.TextAlign.center,
                      ),
                      padding: pw.EdgeInsets.all(20),
                    ),
                    pw.Padding(
                      child: pw.Text(
                        'Total Colony',
                        style: pw.Theme.of(context).header4,
                        textAlign: pw.TextAlign.center,
                      ),
                      padding: pw.EdgeInsets.all(20),
                    ),
                  ],
                ),
                ...bacteries.map(
                    // Each new line item for the invoice should be rendered on a new TableRow
                    (e) => pw.TableRow(children: [
                          // We can use an Expanded widget, and use the flex parameter to specify
                          // how wide this particular widget should be. With a flex parameter of
                          // 2, the description widget will be 66% of the available width.
                          pw.Expanded(
                            child: pw.Text(e.species!),
                            flex: 2,
                          ),
                          pw.Expanded(
                            child: pw.Text(e.totalColony.toString()),
                            flex: 2,
                          ),
                        ]))
              ])
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
