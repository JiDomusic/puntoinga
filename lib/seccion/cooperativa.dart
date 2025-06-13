import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart'; // ✨ Requiere paquete flutter_animate
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
          // 🌈 Fondo gradiente
          AnimatedContainer(
            duration: const Duration(seconds: 10),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF8E0E00),
                  Color(0xFFFFA500),
                  Color(0xFF8E0E00),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // LOGO
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
                      curve: Curves.elasticOut)
                      .shimmer(duration: 2000.ms, color: Colors.white)
                      .then(delay: 2.seconds)
                      .shake(hz: 1, curve: Curves.easeOutCubic),
                ),
                const SizedBox(height: 40),

                // TITULO PRINCIPAL
                Text(
                  '¡Bienvenidos a Cooperativa Inga!',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.3,
                  ),
                )
                    .animate()
                    .fadeIn(delay: 500.ms)
                    .slideY(begin: 0.3, duration: 800.ms)
                    .then(delay: 1.seconds)
                    .scaleXY(
                    end: 1.02, curve: Curves.easeInOut, duration: 600.ms),

                const SizedBox(height: 30),

                // SECCIÓN NUESTROS VALORES
                LayoutBuilder(
                  builder: (context, constraints) {
                    bool isWide = constraints.maxWidth > 600;
                    return Container(
                      padding: const EdgeInsets.all(24),
                      margin: const EdgeInsets.symmetric(vertical: 24),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black.withOpacity(0.5),
                        image: DecorationImage(
                          image: const AssetImage(
                              'assets/images/fondoamarillo.webp'),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.3),
                            BlendMode.darken,
                          ),
                        ),
                      ),
                      child: isWide
                          ? Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.asset(
                                'assets/images/fondoamarillo.webp',
                                fit: BoxFit.cover,
                                height: 250,
                              ),
                            ),
                          ),
                          const SizedBox(width: 24),
                          Expanded(child: _buildValoresTexto()),
                        ],
                      )
                          : Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              'assets/images/fondoamarillo.webp',
                              fit: BoxFit.cover,
                              height: 200,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildValoresTexto(),
                        ],
                      ),
                    );
                  },
                ),

                const SizedBox(height: 40),

                // BOTÓN
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow[700],
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 16),
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
                    .fadeIn(delay: 1.seconds)
                    .slideY(begin: 0.3)
                    .scaleXY(end: 1.05, curve: Curves.easeOutBack),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 👉 Widget para mostrar los valores
  Widget _buildValoresTexto() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          "Nuestros valores",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.amberAccent,
          ),
        ),
        SizedBox(height: 16),
        ListTile(
          leading: Icon(Icons.check_circle_outline, color: Colors.greenAccent),
          title: Text("Calidad y profesionalismo",
              style: TextStyle(color: Colors.white)),
        ),
        ListTile(
          leading: Icon(Icons.check_circle_outline, color: Colors.greenAccent),
          title: Text("Honestidad y transparencia",
              style: TextStyle(color: Colors.white)),
        ),
        ListTile(
          leading: Icon(Icons.check_circle_outline, color: Colors.greenAccent),
          title: Text("Respeto por la diversidad",
              style: TextStyle(color: Colors.white)),
        ),
        ListTile(
          leading: Icon(Icons.check_circle_outline, color: Colors.greenAccent),
          title: Text("Cooperación y solidaridad",
              style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
