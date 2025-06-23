import 'package:flutter/material.dart';
import '../main.dart'; // Asegúrate que HomeScreen esté importado

class galeria extends StatefulWidget {
  const galeria({Key? key}) : super(key: key);

  @override
  State<galeria> createState() => _GaleriaState();
}

class _GaleriaState extends State<galeria> {
  // Lista actualizada de imágenes
  final List<String> imagePaths = [
    'assets/images/paya.webp',
    'assets/images/INGA77.webp',
    'assets/images/productos2.webp',
    'assets/images/INGA99.webp',
    'assets/images/galeria3.webp',
    'assets/images/puntorojo0.webp',
    'assets/images/galeria.webp',
    'assets/images/chicagaleria.webp',
    'assets/images/audiovisual.webp',
    'assets/images/PUNTOROJO.webp',
    'assets/images/puntorojofilm.webp',
    'assets/images/INGA8.webp',
    'assets/images/filmpuntorojo.webp',
    'assets/images/cajaforenseinga.webp',
    'assets/images/puntorojo4.webp',
    'assets/images/titulogaleria.png',
    'assets/images/festitrapinga2.webp',
    'assets/images/dillon.webp',
    'assets/images/coopinga.png',
    'assets/images/nuestroservicio.webp',
    'assets/images/logostitulosinga.png',
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Precaching optimizado para dispositivos antiguos
    if (MediaQuery.of(context).size.width > 600) {
      for (final path in imagePaths) {
        precacheImage(AssetImage(path), context);
      }
    }
  }

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
              MaterialPageRoute(builder: (_) => HomeScreen()), // Corregido: HomeScreen en lugar de galeria
            );
          },
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Configuración responsiva mejorada para dispositivos antiguos
            int crossAxisCount;
            final width = constraints.maxWidth;

            if (width > 900) {
              crossAxisCount = 4;
            } else if (width > 700) {
              crossAxisCount = 3;
            } else if (width > 500) {
              crossAxisCount = 2;
            } else {
              crossAxisCount = 1; // Para dispositivos muy pequeños
            }

            return GridView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: imagePaths.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 1,
              ),
              itemBuilder: (context, index) {
                return _buildImageItem(imagePaths[index]);
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildImageItem(String imagePath) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        color: Colors.grey[900],
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
          filterQuality: FilterQuality.low,
          frameBuilder: (context, child, frame, wasSync) {
            if (wasSync || frame != null) {
              return child;
            }
            return Center(
              child: Container(
                width: 30,
                height: 30,
                padding: const EdgeInsets.all(4),
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white60),
                ),
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.broken_image,
                  color: Colors.white38,
                  size: 30,
                ),
                const SizedBox(height: 4),
                Text(
                  'Error al cargar',
                  style: TextStyle(
                    color: Colors.white38,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}