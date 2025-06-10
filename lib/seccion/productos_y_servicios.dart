import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'cooperativa.dart';

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
    return Container(
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
          return buildCarouselImage(
              carouselImages[itemIndex], width, height / 3 - 24);
        },
      ),
    );
  }

  Widget buildLeftContent(double screenWidth, double screenHeight) {
    return Column(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: const DecorationImage(
                image: AssetImage('assets/images/fondo_texto.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black54, BlendMode.darken), // oscurecer
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 10,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            padding: const EdgeInsets.all(24),
            child: Center(
              child: DefaultTextStyle(
                style: TextStyle(
                  fontSize: screenWidth > 800 ? 20 : 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
                child: AnimatedTextKit(
                  repeatForever: true,
                  animatedTexts: [
                    TyperAnimatedText(
                      "Nuestra cooperativa se dedica a la producción, realización y postproducción de piezas audiovisuales publicitarias y de difusión y a la creación de contenido audiovisual para redes sociales. También el diseño gráfico, el diseño web, la fotografía y la comunicación en general, son parte de los productos y servicios que brindamos.",
                      speed: const Duration(milliseconds: 40),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
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
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    if (screenWidth > 800) {
      double carouselWidth = 350;
      double carouselHeight = screenHeight * 0.9;
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text('Productos y Servicios'),
          backgroundColor: Colors.red[900],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SizedBox(
                  height: carouselHeight,
                  child: buildLeftContent(screenWidth, screenHeight),
                ),
              ),
              const SizedBox(width: 24),
              buildCarousel(carouselWidth, carouselHeight),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text('Productos y Servicios'),
          backgroundColor: Colors.red[900],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(
                height: screenHeight * 0.6,
                width: double.infinity,
                child: buildLeftContent(screenWidth, screenHeight),
              ),
              const SizedBox(height: 24),
              buildCarousel(screenWidth * 0.9, screenHeight * 0.25),
            ],
          ),
        ),
      );
    }
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
