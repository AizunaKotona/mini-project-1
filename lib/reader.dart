import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'home.dart';

class ReaderScreen extends StatefulWidget {

  final String pdfPath;
  final String title;
  const ReaderScreen({Key? key, required this.pdfPath, required this.title}) : super(key: key);
  

  @override
  // ignore: library_private_types_in_public_api
  _ReaderScreenState createState() => _ReaderScreenState();
}

class _ReaderScreenState extends State<ReaderScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: SfPdfViewer.network(widget.pdfPath,
        ),
      ),
    );
  }
}