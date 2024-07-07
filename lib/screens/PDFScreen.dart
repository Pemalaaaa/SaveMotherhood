import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFScreen extends StatefulWidget {
  const PDFScreen({Key? key}) : super(key: key);

  @override
  State<PDFScreen> createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> {
  String _selectedPdf = "assets/pdf/CareDuringPregnancy-AReview.pdf";

  void _openPdf(String pdfPath) {
    setState(() {
      _selectedPdf = pdfPath;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SfPdfViewer.asset(_selectedPdf),
          ),
          SizedBox(
            height: 150,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                PdfCard(
                  pdfPath: "assets/pdf/CareDuringPregnancy-AReview.pdf",
                  title: "Care During Pregnancy",
                  onTap: _openPdf,
                  backgroundColor:Color(0xFFFFC2CD),
                ),
                PdfCard(
                  pdfPath:
                      "assets/pdf/Study_of_trimester_wise_effect_of_hypothyroidism_i.pdf",
                  title: "Trimester-wise Effect of Hypothyroidism",
                  onTap: _openPdf,
                 backgroundColor:Color(0xFFF7E5E7),
                ),
                PdfCard(
                  pdfPath: "assets/pdf/Calcimum Supplementation.pdf",
                  title: "Calcimum Supplementation",
                  onTap: _openPdf,
                  backgroundColor:Color(0xFFFFC2CD),
                ),
                PdfCard(
                  pdfPath: "assets/pdf/Daily Iron Supplementation.pdff",
                  title: "Daily Oral Iron Supplementation",
                  onTap: _openPdf,
                  backgroundColor:Color(0xFFF7E5E7)
                ),
                PdfCard(
                  pdfPath:
                      "assets/pdf/Importance of nutrition during pregnancy.pdf",
                  title: "Importance of nutrition during pregnancy",
                  onTap: _openPdf,
                  backgroundColor:Color(0xFFFFC2CD),
                ),
                // Add more PdfCard widgets with different titles for each PDF
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PdfCard extends StatelessWidget {
  final String pdfPath;
  final String title;
  final Function(String) onTap;
  final Color backgroundColor;

  const PdfCard({
    required this.pdfPath,
    required this.title,
    required this.onTap,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(pdfPath),
      child: Card(
         color: backgroundColor,
        child: Container(
          width: 200,
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              title,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
