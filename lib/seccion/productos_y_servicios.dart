import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

// Asegúrate de tener una pantalla llamada CooperativaPage para navegar hacia ella.
import 'cooperativa.dart'; // Asegúrate de tener este archivo y clase.

class productosyservicios extends StatefulWidget {
  const productosyservicios({super.key});

  @override
  State<productosyservicios> createState() => _ProductosYServiciosState();
}

class _ProductosYServiciosState extends State<productosyservicios> {
  String? localPDFPath;
  final ScrollController _scrollController = ScrollController();

  final List<String> carouselImages = [
    'assets/images/COOP INGA_Marca_#001_CMYK_01[Export-CS4]-1_dorado.png',
    'assets/images/nuestroservicio2.jpg',
    'assets/images/nuestroservicio.jpg',
  ];

  @override
  void initState() {
    super.initState();
    loadPDF();
    WidgetsBinding.instance.addPostFrameCallback((_) => _startAutoScroll());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> loadPDF() async {
    final bytes = await rootBundle.load('assets/images/nuestroservicio.jpg');
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

  void _startAutoScroll() async {
    const duration = Duration(milliseconds: 30);
    const step = 1.0;

    while (mounted) {
      if (!_scrollController.hasClients) {
        await Future.delayed(duration);
        continue;
      }

      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.offset;
      double nextScroll = currentScroll + step;

      if (nextScroll >= maxScroll) {
        await _scrollController.animateTo(0,
            duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
      } else {
        _scrollController.jumpTo(nextScroll);
      }

      await Future.delayed(duration);
    }
  }

  Widget buildCarouselImage(String assetPath, double width, double height) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => FullscreenImagePage(imagePath: assetPath),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.redAccent, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            assetPath,
            fit: BoxFit.cover,
            width: width,
            height: height,
          ),
        ),
      ),
    );
  }

  Widget buildCarousel(double width, double height) {
    return SizedBox(
      width: width,
      height: height,
      child: ListView.builder(
        controller: _scrollController,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: carouselImages.length * 1000,
        itemBuilder: (context, index) {
          final itemIndex = index % carouselImages.length;
          return buildCarouselImage(carouselImages[itemIndex], width, height / 3 - 24);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    double carouselWidth = screenWidth > 1000 ? 350 : 200;
    double carouselHeight = screenHeight * 0.9;

    double imageWidth = screenWidth - carouselWidth - 80;
    double imageHeight = carouselHeight;

    Widget buildLeftContent() {
      return Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => FullscreenImagePage(
                    imagePath: 'assets/images/COOP INGA_Marca_#001_CMYK_01[Export-CS4]-1_dorado.png',
                  ),
                ),
              );
            },
            child: Container(
              width: imageWidth,
              height: imageHeight - 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.redAccent, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 10,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/images/serviciopuntorojo.webp',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const cooperativa()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[800],
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Ver más',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Productos y Servicios'),
        backgroundColor: Colors.red[900],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: screenWidth > 800
            ? Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: buildLeftContent()),
            const SizedBox(width: 24),
            buildCarousel(carouselWidth, carouselHeight),
          ],
        )
            : Column(
          children: [
            buildLeftContent(),
            const SizedBox(height: 24),
            buildCarousel(screenWidth * 0.8, screenHeight * 0.3),
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

class FullscreenImagePage extends StatelessWidget {
  final String imagePath;

  const FullscreenImagePage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        title: const Text('Imagen'),
      ),
      body: Center(
        child: InteractiveViewer(
          child: Image.asset(imagePath, fit: BoxFit.contain),
        ),
      ),
    );
  }
}
