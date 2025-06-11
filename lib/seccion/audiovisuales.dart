import 'dart:async';
import 'package:flutter/material.dart';

class audiovisuales extends StatefulWidget {
  const audiovisuales({super.key});

  @override
  State<audiovisuales> createState() => _audiovisualesState();
}

class _audiovisualesState extends State<audiovisuales> {
  final PageController _pageController = PageController(viewportFraction: 1.0);
  final List<Map<String, String>> imageData = [
    {
      'image': 'assets/images/Placa para reel PR 001.jpg',
      'title': 'STREAMING PROFESIONAL MULTICÁMARA',
      'description': ''
    },
    {
      'image': 'assets/images/Placa para reel PR 002.jpg',
      'title': 'SERVICIO DE PRENSA Y COMUNICACIÓN INSTITUCIONAL',
      'description': ''
    },
    {
      'image': 'assets/images/Placa para reel PR 003.jpg',
      'title': 'TUTORIALES AUDIOVISUALES PARA REDES SOCIALES',
      'description': ''
    },
    {
      'image': 'assets/images/Placa para reel PR 004.jpg',
      'title': 'Comunidad',
      'description': 'Cultura que se comparte y se vive.'
    },
    {
      'image': 'assets/images/Placa para reel PR 005.jpg',
      'title': 'Innovación',
      'description': 'Creatividad y tecnología en acción.'
    },
    {
      'image': 'assets/images/Placa para reel PR 006.jpg',
      'title': 'Pasión Audiovisual',
      'description': 'Cada cuadro cuenta una historia.'
    },
  ];

  final List<String> galleryImages = [
    'assets/images/festitrapinga2.webp',
    'assets/images/dillon.webp',
    'assets/images/logostitulosinga.png',
    'assets/images/CATA.png',
    'assets/images/ofeliarojo2.png',
  ];

  int currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_pageController.hasClients) {
        int nextPage = (currentIndex + 1) % imageData.length;
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _showImageFullscreen(String imagePath) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FullscreenImagePage(imagePath: imagePath),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final double carouselWidth = screenWidth > 1200 ? screenWidth * 0.6 : screenWidth;
    final double galleryWidth = screenWidth > 1200 ? screenWidth * 0.30 : screenWidth;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color(0xFFB80821),
        title: const Text(
          'Nuestro Equipo Audiovisual',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: screenWidth > 1200
            ? Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: carouselWidth,
              height: screenHeight * 0.90,
              child: PageView.builder(
                controller: _pageController,
                itemCount: imageData.length,
                onPageChanged: (index) {
                  setState(() => currentIndex = index);
                },
                itemBuilder: (context, index) {
                  final item = imageData[index];
                  return Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Card(
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        children: [
                          Expanded(
                            child: Image.asset(
                              item['image']!,
                              fit: BoxFit.contain,
                              width: double.infinity,
                            ),
                          ),
                          Container(
                            color: Colors.black.withOpacity(0.8),
                            padding: const EdgeInsets.all(40),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['title']!,
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 7),
                                if (item['description']!.isNotEmpty)
                                  Text(
                                    item['description']!,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.white70,
                                    ),
                                  ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              width: galleryWidth,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: galleryImages.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => _showImageFullscreen(galleryImages[index]),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          galleryImages[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        )
            : ListView(
          children: [
            SizedBox(
              height: screenHeight * 0.6,
              child: PageView.builder(
                controller: _pageController,
                itemCount: imageData.length,
                onPageChanged: (index) {
                  setState(() => currentIndex = index);
                },
                itemBuilder: (context, index) {
                  final item = imageData[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
                    child: Card(
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        children: [
                          Expanded(
                            child: Image.asset(
                              item['image']!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                          Container(
                            color: Colors.black.withOpacity(0.85),
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['title']!,
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                if (item['description']!.isNotEmpty) ...[
                                  const SizedBox(height: 6),
                                  Text(
                                    item['description']!,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.white70,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: galleryImages.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => _showImageFullscreen(galleryImages[index]),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        galleryImages[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
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
