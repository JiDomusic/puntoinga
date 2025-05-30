import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class Nosotros extends StatelessWidget {
  const Nosotros({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Fondo animado radial
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 1.2,
                  colors: [
                    Colors.black.withOpacity(0.9),
                    Colors.black.withOpacity(1.0),
                  ],
                ),
              ),
            ),
          ),

          // Partículas flotantes
          ...List.generate(
            20,
                (index) => Positioned(
              left: math.Random().nextDouble() * size.width,
              top: math.Random().nextDouble() * size.height,
              child: Container(
                width: 2,
                height: 2,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
              )
                  .animate(delay: (index * 100).ms)
                  .fadeIn(duration: 1000.ms)
                  .then()
                  .fadeOut(duration: 1000.ms),
            ),
          ),

          // Contenido principal
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/puntorojo3.png',
                    width: isMobile ? 200.0 : 200.0,
                  )
                      .animate()
                      .fadeIn(duration: 800.ms)
                      .scale(
                    begin: const Offset(0.10, 0.8),
                    end: const Offset(1.0, 1.0),
                  ),

                  const SizedBox(height: 16.0),

                  Text(
                    'PUNTO ROJO',
                    style: TextStyle(
                      fontSize: isMobile ? 32.0 : 48.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent,
                      letterSpacing: 2.0,
                    ),
                  )
                      .animate()
                      .fadeIn(duration: 800.ms)
                      .slideY(begin: -0.5, end: 0.0, duration: 1000.ms),

                  const SizedBox(height: 32.0),

                  Text(
                    'Nosotros',
                    style: TextStyle(
                      fontSize: isMobile ? 24.0 : 32.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ).animate().fadeIn(duration: 600.ms),

                  const SizedBox(height: 20.0),

                  Text(
                    '''Punto Rojo es una productora de contenidos nacida del trabajo cooperativo de profesionales de las artes visuales, la literatura, el cine y la música, que ofrecemos servicios culturales. Nos dedicamos a la Producción Audiovisual; la Prensa y la Comunicación institucional, el Diseño gráfico y la comunicación visual, entre otros.''',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isMobile ? 16.0 : 18.0,
                      color: Colors.white70,
                      height: 1.5,
                    ),
                  )
                      .animate()
                      .fadeIn(duration: 600.ms, delay: 200.ms),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
