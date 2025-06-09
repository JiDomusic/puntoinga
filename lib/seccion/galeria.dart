import 'package:flutter/material.dart';

class galeria extends StatelessWidget {
final List<String> imagePaths = [
  'assets/images/festitrapinga.jpg',
  'assets/images/servicioingacortado.jpg',
  'assets/images/INGA7.jpg',
  'assets/images/INGA8.jpg',
  'assets/images/INGA9.JPG',
  'assets/images/logostitulosinga.png',
  'assets/images/puntorojo0.jpg',
  'assets/images/dillon.jpg',
  'assets/images/chicainga.jpg',
  'assets/images/audiovisual.jpg',
  'assets/images/PUNTOROJO.jpg',
  'assets/images/puntorojofilm.jpg',
  'assets/images/ofeliarojo2.png',
  'assets/images/filmpuntorojo.jpg',
  'assets/images/cajaforenseinga.jpg',
  'assets/images/paya.jpg',
];

@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.black,
    body: SafeArea(
      child: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Cambia a 3 para pantallas grandes si querés
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: imagePaths.length,
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              imagePaths[index],
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    ),
  );
}
}
