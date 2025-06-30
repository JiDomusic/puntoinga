import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:math';

class Audiovisuales extends StatelessWidget {
  const Audiovisuales({super.key});

  final List<String> videoUrls = const [
    'https://www.youtube.com/embed/TOrvOPuQjw4',
    'https://www.youtube.com/embed/qgYYpaEj-Mk',
    'https://www.youtube.com/embed/s3o4qo_S6H4',
    'https://www.youtube.com/embed/gE-YKDZeUYE',
    'https://www.youtube.com/embed/zoFoCf4OGOQ',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Audiovisuales'),
        centerTitle: true,
        backgroundColor: const Color(0xFFB80821).withOpacity(0.9),
      ),
      body: Stack(
        children: [
          const Positioned.fill(child: GradientAnimatedBackground()),
          Positioned.fill(
            child: Container(
              padding: const EdgeInsets.only(top: kToolbarHeight + 24),
              child: Content(videos: videoUrls),
            ),
          ),
        ],
      ),
    );
  }
}

class Content extends StatelessWidget {
  final List<String> videos;

  const Content({super.key, required this.videos});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double videoWidth = screenWidth > 600 ? screenWidth * 0.7 : screenWidth * 0.95;
    final double videoHeight = videoWidth * 9 / 16;

    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 40),
      itemCount: videos.length,
      separatorBuilder: (_, __) => const SizedBox(height: 36),
      itemBuilder: (context, index) {
        return Center(
          child: Container(
            width: videoWidth,
            height: videoHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: WebViewWidget(
                controller: WebViewController()
                  ..setJavaScriptMode(JavaScriptMode.unrestricted)
                  ..loadRequest(Uri.parse(videos[index])),
              ),
            ),
          ),
        );
      },
    );
  }
}

class GradientAnimatedBackground extends StatefulWidget {
  const GradientAnimatedBackground({super.key});

  @override
  State<GradientAnimatedBackground> createState() =>
      _GradientAnimatedBackgroundState();
}

class _GradientAnimatedBackgroundState extends State<GradientAnimatedBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Color> colors;

  @override
  void initState() {
    super.initState();
    colors = [Colors.red, Colors.orange, Colors.yellow];
    _controller = AnimationController(
      duration: const Duration(seconds: 12),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return CustomPaint(
          painter: GradientPainter(_controller.value, colors),
          child: Container(),
        );
      },
    );
  }
}

class GradientPainter extends CustomPainter {
  final double progress;
  final List<Color> colors;

  GradientPainter(this.progress, this.colors);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 1.2;

    final gradient = RadialGradient(
      colors: colors,
      stops: [
        0.3 + 0.1 * sin(progress * 2 * pi),
        0.7 + 0.1 * cos(progress * 2 * pi)
      ],
      center: Alignment(
        0.5 * sin(progress * 2 * pi),
        0.5 * cos(progress * 2 * pi),
      ),
    );

    final rect = Rect.fromCircle(center: center, radius: radius);
    final paint = Paint()..shader = gradient.createShader(rect);

    canvas.drawRect(Offset.zero & size, paint);
  }

  @override
  bool shouldRepaint(covariant GradientPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
