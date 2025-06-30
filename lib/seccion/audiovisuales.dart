import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Audiovisuales extends StatelessWidget {
  const Audiovisuales({super.key});

  final List<Map<String, String>> videos = const [
    {
      'url': 'https://www.youtube.com/embed/TOrvOPuQjw4',
      'title': 'Video 1',
    },
    {
      'url': 'https://www.youtube.com/embed/qgYYpaEj-Mk',
      'title': 'Video 2',
    },
    {
      'url': 'https://www.youtube.com/embed/s3o4qo_S6H4',
      'title': 'Video 3',
    },
    {
      'url': 'https://www.youtube.com/embed/gE-YKDZeUYE',
      'title': 'Video 4',
    },
    {
      'url': 'https://www.youtube.com/embed/zoFoCf4OGOQ',
      'title': 'Video 5',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Audiovisuales'),
        centerTitle: true,
        backgroundColor: const Color(0xFFB80821),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: videos.length,
        separatorBuilder: (context, index) => const SizedBox(height: 24),
        itemBuilder: (context, index) {
          final video = videos[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                video['title']!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              AspectRatio(
                aspectRatio: 16 / 9,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: WebViewWidget(
                    controller: WebViewController()
                      ..setJavaScriptMode(JavaScriptMode.unrestricted)
                      ..loadRequest(Uri.parse(video['url']!)),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
