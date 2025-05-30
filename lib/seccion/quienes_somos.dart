import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:puntorojo/main.dart';

class QuienesSomos extends StatelessWidget {
  const QuienesSomos({super.key});

  @override
  Widget build(BuildContext context) {
    final Color rojo = const Color(0xFFB71C1C);
    final Color amarillo = const Color(0xFFFFD54F);
    final Color green = const Color(0xFF2E7D32);
    final Color negro = Colors.black;

    return Scaffold(
      backgroundColor: negro,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          '¿Quiénes Somos?',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // LOGO
              Image.asset(
                'assets/images/coopinga.png',
                width: 180,
              )
                  .animate()
                  .fadeIn(duration: 600.ms),


               SizedBox(height: 30),

              // VALORES
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white24),
                ),
                child: Column(
                  children: [
                    Text(
                      'Nuestros Valores',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: amarillo,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '''✔ Calidad y profesionalismo
✔ Honestidad y transparencia
✔ Respeto por la diversidad
✔ Cooperación y solidaridad''',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              )
                  .animate()
                  .fadeIn(duration: 600.ms, delay: 200.ms)
                  .slideY(begin: 0.2),

              const SizedBox(height: 30),

              // TEXTO PRINCIPAL
              Text(
                '''Acompañamos a ONGs, cooperativas, instituciones culturales, sindicatos y organismos públicos. Promovemos el acceso a herramientas de comunicación audiovisual con compromiso social.''',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  height: 1.6,
                ),
              )
                  .animate()
                  .fadeIn(duration: 600.ms, delay: 400.ms)
                  .slideY(begin: 0.2),

              const SizedBox(height: 40),

              // BOTÓN
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const HomeScreen()),
                        (route) => false,
                  );
                },
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                label: const Text(
                  'Volver al inicio',
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: rojo,
                  padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  elevation: 6,
                  shadowColor: Colors.black87,
                ),
              )
                  .animate()
                  .fadeIn(duration: 600.ms, delay: 600.ms)
                  .slideY(begin: 0.2),
            ],
          ),
        ),
      ),
    );
  }
}
