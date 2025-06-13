import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:puntorojo/main.dart';

class quienessomos extends StatelessWidget {
  const quienessomos({super.key});

  @override
  Widget build(BuildContext context) {
    final Color rojo = const Color(0xFFB71C1C);
    final Color amarillo = const Color(0xFFFFD54F);

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          '',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // 🖼 Fondo con imagen completa
          Positioned.fill(
            child: Image.asset(
              'assets/images/cooperativa2.webp',
              fit: BoxFit.cover,
            ),
          ),

          // 📦 Filtro oscuro para mejor lectura
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.4),
            ),
          ),

          // 📄 Contenido centrado
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 🔆 LOGO
                  Image.asset(
                    'assets/images/coopinga.png',
                    width: 180,
                  ).animate().fadeIn(duration: 600.ms),

                  const SizedBox(height: 30),

                  // 🟨 TEXTO PRINCIPAL
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white24),
                    ),
                    child: Text(
                      '''
Somos una empresa cooperativa dedicada a brindar servicios y productos culturales.

El objeto de la cooperativa incluye la producción de medios alternativos de comunicación democrática y solidaria; la producción y difusión de actividades culturales y artísticas; el fomento del espíritu de solidaridad y ayuda mutua entre los asociados y asociadas con el fin de crear una conciencia cooperativa.

Interpretamos las necesidades de nuestros clientes para construir un mensaje que se acerque a la esencia de lo que necesitan expresar y difundir a la hora de interpelar a la sociedad con sus acciones.

Más que comunicar, resolvemos un problema de comunicación, al apuntalar en el plano audiovisual –técnica y lenguaje mediante– a reforzar la labor comunitaria e institucional.

Nuestra capacidad creativa va más allá de un simple registro o trabajo técnico, ya que se sustenta en la relación consustancial con las problemáticas de nuestros clientes.

Este valor nos ratifica el rumbo elegido de trabajar con la institucionalidad popular y comunitaria, ya que podemos “traducir” al lenguaje audiovisual sus necesidades comunicacionales.
                      ''',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 18,
                        height: 1.6,
                        color: amarillo,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ).animate().fadeIn(duration: 700.ms).slideY(begin: 0.2),

                  const SizedBox(height: 40),

                  // 🔙 BOTÓN VOLVER
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
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
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
                  ).animate().fadeIn(duration: 600.ms, delay: 400.ms).slideY(begin: 0.2),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
