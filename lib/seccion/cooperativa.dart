import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'quienes_somos.dart';

class cooperativa extends StatefulWidget {
  const cooperativa({super.key});

  @override
  State<cooperativa> createState() => _CooperativaState();
}

class _CooperativaState extends State<cooperativa>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Bienvenidos'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // 🌄 Imagen de fondo
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/fondoamarillo.webp"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // 🟡 Degradado amarillo translúcido encima
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xCCF1BC0E), // Amarillo claro con opacidad
                  Color(0x7C000000), // Negro con opacidad para contraste
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // 🌟 Contenido
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 🌀 Logo
                  Hero(
                    tag: 'logo-coop',
                    child: Image.asset(
                      'assets/images/coopinga.png',
                      width: 200,
                      height: 200,
                    )
                        .animate()
                        .scale(
                      delay: 200.ms,
                      duration: 800.ms,
                      curve: Curves.elasticOut,
                    )
                        .shimmer(duration: 2000.ms, color: Colors.white)
                        .then(delay: 2.seconds)
                        .shake(hz: 1, curve: Curves.easeOutCubic),
                  ),

                  const SizedBox(height: 40),

                  // ✨ Título
                  Text(
                    '¡Bienvenidos a Cooperativa Inga!',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      height: 1.3,
                    ),
                  )
                      .animate()
                      .fadeIn(delay: 500.ms)
                      .slide(begin: Offset(0, 0.3), duration: 800.ms)
                      .then(delay: 1.seconds)
                      .scaleXY(end: 1.02, curve: Curves.easeInOut, duration: 600.ms),

                  const SizedBox(height: 30),

                  // 📣 Texto institucional
                  Container(
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.only(bottom: 24),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.amberAccent, width: 1.2),
                    ),
                    child: const Text(
                      "Acompañamos a ONGs, cooperativas, instituciones culturales, sindicatos y organismos públicos. Promovemos el acceso a herramientas de comunicación audiovisual con compromiso social.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        height: 1.5,
                      ),
                    ),
                  )
                      .animate()
                      .fadeIn(delay: 900.ms)
                      .slide(begin: Offset(0, 0.3)),

                  // ✅ Valores
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Nuestros valores",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.amberAccent,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.amber, width: 1.2),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text("✔ Calidad y profesionalismo", style: TextStyle(color: Colors.white, fontSize: 18)),
                            SizedBox(height: 8),
                            Text("✔ Honestidad y transparencia", style: TextStyle(color: Colors.white, fontSize: 18)),
                            SizedBox(height: 8),
                            Text("✔ Respeto por la diversidad", style: TextStyle(color: Colors.white, fontSize: 18)),
                            SizedBox(height: 8),
                            Text("✔ Cooperación y solidaridad", style: TextStyle(color: Colors.white, fontSize: 18)),
                          ],
                        ),
                      ),
                    ],
                  )
                      .animate()
                      .fadeIn(delay: 1.seconds)
                      .slide(begin: Offset(0, 0.3)),

                  const SizedBox(height: 40),

                  // 🚀 Botón
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow[700],
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    icon: const Icon(Icons.explore),
                    label: const Text(
                      'Explorar la Cooperativa',
                      style: TextStyle(fontSize: 16),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const quienessomos(),
                        ),
                      );
                    },
                  )
                      .animate()
                      .fadeIn(delay: 1.2.seconds)
                      .slide(begin: Offset(0, 0.3))
                      .scaleXY(end: 1.05, curve: Curves.easeOutBack),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
