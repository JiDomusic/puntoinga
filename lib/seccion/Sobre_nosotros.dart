import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SobreNosotros extends StatelessWidget {
  const SobreNosotros({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      backgroundColor: Colors.black,
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 60, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // LOGO
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/images/puntorojo2.jpg',
                  height: isMobile ? 180 : 250,
                  fit: BoxFit.contain,
                ),
              ).animate().fadeIn(duration: 1000.ms),

              const SizedBox(height: 40),

              // TÍTULO
              Text(
                'Bienvenidos a Punto Rojo',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: isMobile ? 24 : 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ).animate().fadeIn().slideY(begin: 0.2, duration: 800.ms),

              const SizedBox(height: 20),

              // DESCRIPCIÓN
              Text(
                """Punto Rojo es una productora de contenidos nacida del trabajo cooperativo de profesionales de las artes visuales, la literatura, el cine y la música, que ofrecemos servicios culturales.

Nos dedicamos a la Producción Audiovisual; la Prensa y la Comunicación institucional, el Diseño gráfico y la comunicación visual, entre otros.""",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: isMobile ? 16 : 18,
                  height: 1.6,
                  color: Colors.white70,
                ),
              ).animate().fadeIn(delay: 400.ms, duration: 1000.ms),

              const SizedBox(height: 40),

              // BOTÓN DE VOLVER
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
    );
  }
}
