import 'package:flutter/material.dart';
import '../main.dart'; // Ajusta si HomeScreen está en otra ruta

class galeria extends StatelessWidget {
  final List<String> imagePaths = [
    'assets/images/puntorojo4.jpg',
    'assets/images/servicioingacortado.jpg',
    'assets/images/INGA7.jpg',
    'assets/images/productos.jpg',
    'assets/images/INGA9.JPG',
    'assets/images/galeria2.jpg',
    'assets/images/puntorojo0.jpg',
    'assets/images/galeria.jpg',
    'assets/images/chicainga.jpg',
    'assets/images/audiovisual.jpg',
    'assets/images/PUNTOROJO.jpg',
    'assets/images/puntorojofilm.jpg',
    'assets/images/productos2.jpg',
    'assets/images/filmpuntorojo.jpg',
    'assets/images/cajaforenseinga.jpg',
    'assets/images/paya.jpg',
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
        child: GridView.builder(
          padding: const EdgeInsets.all(8.0),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 250, // Tamaño máximo por celda
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 1,
          ),
          itemCount: imagePaths.length,
          itemBuilder: (context, index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                color: Colors.grey[900],
                child: Image.asset(
                  imagePaths[index],
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
