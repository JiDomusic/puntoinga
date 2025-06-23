import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Audiovisuales extends StatefulWidget {
  const Audiovisuales({super.key});

  @override
  State<Audiovisuales> createState() => _AudiovisualesState();
}

class _AudiovisualesState extends State<Audiovisuales> {
  final List<Map<String, String>> videos = const [
    {
      'url': 'https://www.youtube.com/embed/TOrvOPuQjw4',
      'thumbnail': 'https://img.youtube.com/vi/TOrvOPuQjw4/0.jpg',
      'title': 'Streaming Multicámara',
    },
    {
      'url': 'https://www.youtube.com/embed/qgYYpaEj-Mk',
      'thumbnail': 'https://img.youtube.com/vi/qgYYpaEj-Mk/0.jpg',
      'title': 'Comunicación Institucional',
    },
    {
      'url': 'https://www.youtube.com/embed/s3o4qo_S6H4',
      'thumbnail': 'https://img.youtube.com/vi/s3o4qo_S6H4/0.jpg',
      'title': 'Tutorial para redes',
    },
    {
      'url': 'https://www.youtube.com/embed/gE-YKDZeUYE',
      'thumbnail': 'https://img.youtube.com/vi/gE-YKDZeUYE/0.jpg',
      'title': 'Detrás de escena',
    },
    {
      'url': 'https://www.youtube.com/embed/zoFoCf4OGOQ',
      'thumbnail': 'https://img.youtube.com/vi/zoFoCf4OGOQ/0.jpg',
      'title': 'Video adicional',
    },
  ];

  String? currentVideoUrl;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isMobile = screenWidth < 600;

    // Configuración responsiva
    final playerWidth = isMobile ? screenWidth * 0.9 : screenWidth * 0.5;
    final playerHeight = isMobile ? playerWidth * 9 / 16 : screenHeight * 0.7;
    final gridCrossAxisCount = isMobile ? 1 : 2;
    final itemSpacing = isMobile ? 16.0 : 24.0;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Nuestro Equipo Audiovisual'),
        centerTitle: true,
        backgroundColor: const Color(0xFFB80821),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (isMobile) {
              return _buildMobileLayout(
                playerWidth: playerWidth,
                playerHeight: playerHeight,
                gridCrossAxisCount: gridCrossAxisCount,
                itemSpacing: itemSpacing,
              );
            } else {
              return _buildDesktopLayout(
                playerWidth: playerWidth,
                playerHeight: playerHeight,
                gridCrossAxisCount: gridCrossAxisCount,
                itemSpacing: itemSpacing,
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildDesktopLayout({
    required double playerWidth,
    required double playerHeight,
    required int gridCrossAxisCount,
    required double itemSpacing,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Reproductor de video (lateral izquierdo)
        if (currentVideoUrl != null)
          Container(
            width: playerWidth,
            height: playerHeight,
            margin: const EdgeInsets.only(right: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.black,
              boxShadow: [
                BoxShadow(
                  color: Colors.red.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: WebViewWidget(
                controller: WebViewController()
                  ..setJavaScriptMode(JavaScriptMode.unrestricted)
                  ..loadRequest(Uri.parse(currentVideoUrl!)),
              ),
            ),
          ),

        // Lista de videos (lado derecho)
        Expanded(
          child: GridView.builder(
            itemCount: videos.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: gridCrossAxisCount,
              mainAxisSpacing: itemSpacing,
              crossAxisSpacing: itemSpacing,
              childAspectRatio: 16 / 11,
            ),
            itemBuilder: (context, index) {
              final video = videos[index];
              return _buildVideoItem(video);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout({
    required double playerWidth,
    required double playerHeight,
    required int gridCrossAxisCount,
    required double itemSpacing,
  }) {
    return Column(
      children: [
        // Reproductor de video (arriba)
        if (currentVideoUrl != null)
          Container(
            width: playerWidth,
            height: playerHeight,
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.black,
              boxShadow: [
                BoxShadow(
                  color: Colors.red.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: WebViewWidget(
                controller: WebViewController()
                  ..setJavaScriptMode(JavaScriptMode.unrestricted)
                  ..loadRequest(Uri.parse(currentVideoUrl!)),
              ),
            ),
          ),

        // Lista de videos (abajo)
        Expanded(
          child: GridView.builder(
            itemCount: videos.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: gridCrossAxisCount,
              mainAxisSpacing: itemSpacing,
              crossAxisSpacing: itemSpacing,
              childAspectRatio: 16 / 11,
            ),
            itemBuilder: (context, index) {
              final video = videos[index];
              return _buildVideoItem(video);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildVideoItem(Map<String, String> video) {
    return GestureDetector(
      onTap: () {
        setState(() {
          currentVideoUrl = video['url'];
        });
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              video['thumbnail']!,
              width: double.infinity,
              height: 180,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[800],
                  child: const Center(
                    child: Icon(Icons.error, color: Colors.red),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Text(
            video['title']!,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
