import 'package:flutter/material.dart';

class Fotografia extends StatelessWidget {
  const Fotografia ({super.key});

  final List<Map<String, String>> items = const [
    {
      'image': 'assets/images/Placa para reel PR 001.jpg',
      'title': 'Evento Cultural',
      'description': 'dia de coso.'
    },
    {
      'image': 'assets/images/Placa para reel PR 002.jpg',
      'title': 'Arte Urbano',
      'description': 'cubriendo.'
    },
    {
      'image': 'assets/images/CATA.png',
      'title': 'Taller Comunitario',
      'description': 'Jornada ..'
    },
    {
      'image': 'assets/images/PUNTOROJO.jpg',
      'title': 'Noche de Cine',
      'description': 'Cine comunitario kfsjskdfsjd'
    },
    {
      'image': 'assets/images/filmpuntorojo.jpg',
      'title': 'Feria Local',
      'description': 'Expositores locales sakdjhsakd '
    },
    {
      'image': 'assets/images/03.jpg',
      'title': 'Música en Vivo',
      'description': 'Bandas emergentes askjdhsad  .'
    },
    {
      'image': 'assets/images/puntorojo2.jpg',
      'title': ' evento  de  sjkasf  d',
      'description': 'U askjhaskd  sajkdhsa'
    },
    {
      'image': 'assets/images/04.jpg',
      'title': 'sdflsdjlf  ',
      'description': 'Cdsakdhs  skdjfhs'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Galería Punto Rojo'),
        backgroundColor: Colors.red.shade900,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isWide = constraints.maxWidth > 800;

          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'eventos cubiertos por punto rojo',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'los  sasrasrasahs.',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white70,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    isWide
                        ? Wrap(
                      spacing: 20,
                      runSpacing: 20,
                      alignment: WrapAlignment.center,
                      children: items
                          .map((item) => SizedBox(
                        width: 350,
                        child: AnimatedImageCard(
                          imagePath: item['image']!,
                          title: item['title']!,
                          description: item['description']!,
                        ),
                      ))
                          .toList(),
                    )
                        : Column(
                      children: items
                          .map((item) => AnimatedImageCard(
                        imagePath: item['image']!,
                        title: item['title']!,
                        description: item['description']!,
                      ))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class AnimatedImageCard extends StatefulWidget {
  final String imagePath;
  final String title;
  final String description;

  const AnimatedImageCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
  });

  @override
  State<AnimatedImageCard> createState() => _AnimatedImageCardState();
}

class _AnimatedImageCardState extends State<AnimatedImageCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.red, Colors.black87],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.redAccent.withOpacity(0.6),
              blurRadius: 15,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
              child: Image.asset(
                widget.imagePath,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.description,
                    style: const TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
