import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class ProductosYServicios extends StatefulWidget {
  const ProductosYServicios({super.key});

  @override
  State<ProductosYServicios> createState() => _ProductosYServiciosState();
}

class _ProductosYServiciosState extends State<ProductosYServicios> {
  String? localPDFPath;

  @override
  void initState() {
    super.initState();
    loadPDF();
  }

  Future<void> loadPDF() async {
    final bytes = await rootBundle.load('assets/images/serviciopuntorojo.webp');
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/preview.pdf');
    await file.writeAsBytes(bytes.buffer.asUint8List());
    setState(() {
      localPDFPath = file.path;
    });
  }

  void openPDFViewer() {
    if (localPDFPath == null) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PDFViewerPage(pdfPath: localPDFPath!),
      ),
    );
  }

  Widget buildSection({
    required String title,
    required String content,
    required bool leftAligned,
    required Color titleColor,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 600;
        return Align(
          alignment: leftAligned ? Alignment.centerLeft : Alignment.centerRight,
          child: Container(
            width: isWide ? constraints.maxWidth * 0.9 : double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey[850],
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Column(
              crossAxisAlignment:
              leftAligned ? CrossAxisAlignment.start : CrossAxisAlignment.end,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: titleColor,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  content,
                  textAlign: leftAligned ? TextAlign.left : TextAlign.right,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 20,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildPDFPreview() {
    return GestureDetector(
      onTap: openPDFViewer,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 32),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.redAccent, width: 2),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 10,
              offset: const Offset(0, 6),
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            'assets/images/03.jpg',
            fit: BoxFit.cover,
            height: 280,
            width: double.infinity,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Productos y Servicios'),
        backgroundColor: Colors.red[900],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          children: [
            buildSection(
              title: 'PRODUCTOS',
              content: '''
Este servicio permite registrar actividades de forma profesional con múltiples cámaras.

• Transmisión en vivo profesional (multicámara, Zoom, redes sociales simultáneas).
• Adaptado a los equipos del cliente con nuestra producción creativa.
• Diseño gráfico, asesoramiento técnico y guiones incluidos.
Ideal para congresos, diplomaturas, cursos, eventos institucionales y deportivos.
              ''',
              leftAligned: true,
              titleColor: Colors.redAccent,
            ),
            buildSection(
              title: 'SERVICIOS',
              content: '''
Tutoriales audiovisuales breves y creativos diseñados para redes sociales.

• Para explicar técnicas, saberes o contar experiencias con impacto visual.
• Incluye guión, rodaje, edición y adaptación a cada plataforma.
• Pensado para personas, colectivos u organizaciones con contenido que destacar.
              ''',
              leftAligned: false,
              titleColor: Colors.amberAccent,
            ),
            buildPDFPreview(),
            const Text(
              'Toca la imagen para ver el catálogo en PDF',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PDFViewerPage extends StatelessWidget {
  final String pdfPath;

  const PDFViewerPage({super.key, required this.pdfPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vista PDF')),
      body: PDFView(
        filePath: pdfPath,
        autoSpacing: true,
        pageFling: true,
        pageSnap: true,
        enableSwipe: true,
        swipeHorizontal: false,
      ),
    );
  }
}
