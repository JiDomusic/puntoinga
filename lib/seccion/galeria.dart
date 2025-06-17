import 'package:flutter/material.dart';
import '../main.dart'; // Asegúrate que HomeScreen esté importado

class galeria extends StatefulWidget {
  const galeria({Key? key}) : super(key: key);

  @override
  State<galeria> createState() => _galeriaState();
}

class _galeriaState extends State<galeria> {
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
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (MediaQuery.of(context).size.width > 700) {
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
              MaterialPageRoute(builder: (_) => const HomeScreen()),
            );
          },
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            int crossAxisCount = 2;
            double width = constraints.maxWidth;

            if (width >= 900) {
              crossAxisCount = 5;
            } else if (width >= 700) {
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
                // Eliminamos childAspectRatio para que no fuerce proporciones
              ),
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    color: Colors.grey[900],
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Image.asset(
                          imagePaths[index],
                          fit: BoxFit.cover,
                          filterQuality: FilterQuality.low,

                          // cacheHeight podría omitirse para respetar la proporción
                          frameBuilder: (context, child, frame, wasSync) {
                            if (wasSync || frame != null) {
                              return child;
                            }
                            return const Center(
                              child: SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white60),
                                ),
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) => const Center(
                            child: Icon(
                              Icons.broken_image,
                              color: Colors.white38,
                              size: 40,
                            ),
                          ),
                        );
                      },
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
