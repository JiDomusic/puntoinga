import 'package:flutter/material.dart';
import '../main.dart'; // Ajusta si HomeScreen está en otra ruta

class galeria extends StatelessWidget {
  final List<String> imagePaths = [
    'assets/images/paya.webp',
    'assets/images/servicioingacortado.webp',
    'assets/images/INGA77.webp',
    'assets/images/productoss.webp',
    'assets/images/INGA99.webp',
    'assets/images/galeria3.webp',
    'assets/images/puntorojo0.webp',
    'assets/images/galeria.webp',
    'assets/images/chicainga.webp',
    'assets/images/audiovisual.webp',
    'assets/images/PUNTOROJO.webp',
    'assets/images/puntorojofilm.webp',
    'assets/images/productos2.webp',
    'assets/images/filmpuntorojo.webp',
    'assets/images/cajaforenseinga.webp',
    'assets/images/puntorojo4.webp',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        title: const Text('Galería'),
        leading: IconButton(
          icon: const Icon(Icons.home),
          tooltip: 'Volver a Home',
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const HomeScreen()),
            );
          },
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            int crossAxisCount = 2; // predeterminado para móviles
            double width = constraints.maxWidth;

            if (width >= 1200) {
              crossAxisCount = 5;
            } else if (width >= 900) {
              crossAxisCount = 4;
            } else if (width >= 600) {
              crossAxisCount = 3;
            }

            return GridView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: imagePaths.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1,
              ),
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    color: Colors.grey[900],
                    child: Image.asset(
                      imagePaths[index],
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.broken_image,
                        color: Colors.white38,
                        size: 40,
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
