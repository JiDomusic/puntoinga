import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class sobrenosotros extends StatelessWidget {
  const sobrenosotros({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

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
          // Imagen de fondo adaptable a web y móviles
          Positioned.fill(
            child: Image.asset(
              'assets/images/INGAL.webp',
              fit: isMobile ? BoxFit.cover : BoxFit.contain,
              alignment: Alignment.topCenter,
              color: Colors.cyan.withOpacity(0.35),
              colorBlendMode: BlendMode.darken,
            ),
          ),

          // Contenido
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
                        const SizedBox(height: 40),

                        // Título
                        Text(
                          'Bienvenidos a Punto Rojo',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: isMobile ? 28 : 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.amber,
                          ),
                        ).animate().fadeIn().slideY(begin: 0.2, duration: 800.ms),

                        const SizedBox(height: 60),

                        // Descripción
                        Text(
                          """Punto Rojo es una productora de contenidos nacida del trabajo cooperativo de profesionales de las artes visuales, la literatura, el cine y la música, que ofrecemos servicios culturales.

Nos dedicamos a la Producción Audiovisual; la Prensa y la Comunicación institucional, el Diseño gráfico y la comunicación visual, entre otros.""",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: isMobile ? 18 : 20,
                            height: 1.8,
                            color: Colors.white,
                          ),
                        ).animate().fadeIn(delay: 400.ms, duration: 1000.ms),

                        const SizedBox(height: 300),

                        // Botón de volver
                        ElevatedButton.icon(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.arrow_back_ios_new_rounded),
                          label: const Text('Volver al Inicio'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 45),
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
