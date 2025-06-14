import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class sobrenosotros extends StatelessWidget {
  const sobrenosotros({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Sobre Nosotros', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.home, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ).animate().fadeIn(),
      ),
      body: Stack(
        children: [
          // Imagen de fondo responsiva con protección por error
          Positioned.fill(
            child: Image.asset(
              'assets/images/nuestroservicio2.webp',
              fit: BoxFit.contain,
              alignment: Alignment.center,
              color: Colors.white.withOpacity(0.1),
              colorBlendMode: BlendMode.darken,


            ),
          ),

          // Burbujas animadas
          const AnimatedBubbles(),

          // Contenido centrado y scrollable
          SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 800),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // LOGO

                        const SizedBox(height: 40),

                        // TÍTULO
                        Text(
                          'Bienvenidos a Punto Rojo',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: isMobile ? 32 : 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.amber,
                          ),
                        ).animate().fadeIn().slideY(begin: 0.2, duration: 800.ms),

                        const SizedBox(height: 60),

                        // DESCRIPCIÓN
                        Text(
                          """Punto Rojo es una productora de contenidos nacida del trabajo cooperativo de profesionales de las artes visuales, la literatura, el cine y la música, que ofrecemos servicios culturales.

Nos dedicamos a la Producción Audiovisual; la Prensa y la Comunicación institucional, el Diseño gráfico y la comunicación visual, entre otros.""",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: isMobile ? 26: 17,
                            height: 1.8,
                            color: Colors.white,
                          ),
                        ).animate().fadeIn(delay: 400.ms, duration: 1000.ms),

                        const SizedBox(height: 300),

                        // BOTÓN
                        ElevatedButton.icon(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.arrow_back_ios_new_rounded),
                          label: const Text('Volver al Inicio'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          ),
                        ).animate().fadeIn(delay: 800.ms),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Animación de burbujas
class AnimatedBubbles extends StatelessWidget {
  const AnimatedBubbles({super.key});

  @override
  Widget build(BuildContext context) {
    final random = Random();
    final screenWidth = MediaQuery.of(context).size.width;

    final bubbles = List.generate(12, (index) {
      final left = random.nextDouble() * screenWidth;
      final delay = Duration(milliseconds: random.nextInt(3000));

      return Positioned(
        left: left,
        bottom: -40,
        child: Container(
          width: 20 + random.nextDouble() * 20,
          height: 20 + random.nextDouble() * 20,
          decoration: const BoxDecoration(
            color: Colors.white12,
            shape: BoxShape.circle,
          ),
        )
            .animate(onPlay: (controller) => controller.repeat())
            .moveY(
          begin: 600,
          end: -100,
          duration: 8000.ms + delay,
          curve: Curves.easeInOut,
        )
            .fadeIn(duration: 2000.ms),
      );
    });

    return SizedBox.expand(child: Stack(children: bubbles));
  }
}
