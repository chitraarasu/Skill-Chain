import 'package:flutter/material.dart';
import 'package:skill_chain/web/utils/font_manager.dart';
import 'package:skill_chain/web/utils/widgets/widgets.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class OpenCertificate extends StatelessWidget {
  final String url;

  const OpenCertificate(this.url);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: getCustomFont("Certificate", 18, fontWeight: semiBold),
      ),
      body: SfPdfViewer.network(url),
    );
  }
}
