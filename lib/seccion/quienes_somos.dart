import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:puntorojo/main.dart';

class quienessomos extends StatelessWidget {
  const quienessomos({super.key});

  @override
  Widget build(BuildContext context) {
    final Color rojo = const Color(0xFFB71C1C);
    final Color amarillo = const Color(0xFFFFD54F);

    final bool isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      backgroundColor: Colors.black,
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
          padding: const EdgeInsets.all(16),
          child: isMobile
          // 📱 Diseño para pantallas pequeñas (stack)
              ? Column(
            children: [
              Image.asset(
                'assets/images/cooperativa2.webp',
                width: 300,
              ).animate().fadeIn(duration: 600.ms),
              const SizedBox(height: 24),
              _buildTextBox(amarillo),
            ],
          )
          // 💻 Diseño para pantallas grandes (dividido)
              : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Image.asset(
                    'assets/images/cooperativa2.webp',
                    fit: BoxFit.cover,
                    height: 500,
                  ).animate().fadeIn(duration: 600.ms),
                ),
              ),
              Expanded(
                flex: 2,
                child: _buildTextBox(amarillo),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton.icon(
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
        ),
      ),
    );
  }

  Widget _buildTextBox(Color amarillo) {
    return Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.65),
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
    ).animate().fadeIn(duration: 700.ms).slideY(begin: 0.2);
  }
}
