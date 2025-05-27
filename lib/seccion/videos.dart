import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class Videos extends StatefulWidget {
  const Videos({super.key});

  @override
  State<Videos> createState() => _VideosState();
}

class _VideosState extends State<Videos> {
  final Map<String, YoutubePlayerController> _controllers = {};

  String? _extractYoutubeId(String url) {
    final cleanUrl = url.trim();
    final uri = Uri.tryParse(cleanUrl);
    if (uri == null) return null;
    if (uri.host.contains('youtube.com')) {
      return uri.queryParameters['v'];
    } else if (uri.host.contains('youtu.be')) {
      return uri.pathSegments.isNotEmpty ? uri.pathSegments.first : null;
    }
    return null;
  }

  YoutubePlayerController _getOrCreateController(String videoId) {
    if (_controllers.containsKey(videoId)) {
      return _controllers[videoId]!;
    } else {
      final controller = YoutubePlayerController.fromVideoId(
        videoId: videoId,
        autoPlay: false,
        params: const YoutubePlayerParams(
          showFullscreenButton: true,
          showControls: true,
          mute: false,
        ),
      );
      _controllers[videoId] = controller;
      return controller;
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.close();
    }
    _controllers.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // Para mantener aspecto 16:9, calculamos altura en función del ancho
    final videoWidth = screenWidth * 0.9; // 90% del ancho pantalla
    final videoHeight = videoWidth * 9 / 16;

    return Scaffold(
      appBar: AppBar(title: const Text('Videos')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('videos')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No hay videos disponibles.'));
          }

          final videos = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 16),
            itemCount: videos.length,
            itemBuilder: (context, index) {
              final video = videos[index];
              final videoId = _extractYoutubeId(video['url'] ?? '');

              return Container(
                margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.6),
                      offset: const Offset(0, 3),
                      blurRadius: 8,
                    )
                  ],
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      video['titulo'] ?? '',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    if (video['descripcion'] != null &&
                        video['descripcion'].toString().isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          video['descripcion'],
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                      ),
                    if (video['texto'] != null &&
                        video['texto'].toString().isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          video['texto'],
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                    const SizedBox(height: 20),
                    if (videoId != null)
                      Center(
                        child: SizedBox(
                          width: videoWidth,
                          height: videoHeight,
                          child: YoutubePlayerScaffold(
                            controller: _getOrCreateController(videoId),
                            builder: (context, player) => player,
                          ),
                        ),
                      )
                    else
                      const Text(
                        'URL de YouTube no válida',
                        style: TextStyle(color: Colors.redAccent),
                      ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
