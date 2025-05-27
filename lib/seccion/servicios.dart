import 'package:flutter/material.dart';

class Servicios extends StatelessWidget {
  const Servicios({super.key});

  @override
  Widget build(BuildContext context) {
    final bordorColor = const Color(0xFF2C001E); // bordo
    final redAccent = Colors.redAccent;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: bordorColor,
        title: const Text(
          'SERVICIOS',
          style: TextStyle(color: Colors.amber),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Contenedor de texto principal
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: bordorColor, width: 3),
                boxShadow: [
                  BoxShadow(
                    color: bordorColor.withOpacity(0.5),
                    blurRadius: 8,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: const Text(
                'COMUNICACIÓN VISUAL'
                    ' Identidad'
                    '• Diseño, ajuste o rediseño de marcas'
                    '• Papelería.'
                    '• Media kit',
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            const SizedBox(height: 20),

            _buildImageTextSection(
              bordorColor,
              redAccent,
              'Editoriales',
              """• Revistas.
• Libros.
• Manuales.
• Catálogos.
• Folletos, volantes.""",
              'assets/images/servicioingacortado.jpg',
            ),
            const SizedBox(height: 20),

            _buildImageTextSection(
              bordorColor,
              redAccent,
              'Comunicación visual',
              """• Piezas para redes sociales.
• Banner web.
• Avisos publicitarios.
• Cartelería impresa.""",
              'assets/images/cajaforenseinga.jpg',
            ),
            const SizedBox(height: 8),

            _buildImageTextSection(
              bordorColor,
              redAccent,
              'MULTIMEDIA',
              """• Sitios web.
• Banner web.
• Avisos publicitarios.
• Cartelería impresa 
• Institucionales.
• Plataformas de contenidos.
• Tiendas virtualesRegistro audiovisual

• REGISTRO AUDIOVISUAL 
  Registro audiovisual en eventos sociales, artísticos, institucionales, educativos, etc.
• Coberturas fotográficas y audiovisuales
• Proyección con pantalla y sonido para pequeños eventos.
• Contenidos multimedia y transmedia.""",
              'assets/images/festitrapinga.jpg',
            ),
            const SizedBox(height: 20),

            _buildImageTextSection(
              bordorColor,
              redAccent,
              'PRENSA Y COMUNICACIÓN INSTITUCIONAL',
              """• Sitios web.
• Banner web.
• Avisos publicitarios.
• Cartelería impresa - • Institucionales.
• Plataformas de contenidos.
• Tiendas virtuales.""",
              'assets/images/CATA.png',
            ),
          ],
        ),
      ),
    );
  }

  // Siempre imagen a la izquierda, texto a la derecha
  Widget _buildImageTextSection(
      Color bordorColor,
      Color redAccent,
      String title,
      String description,
      String imagePath,
      ) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border.all(color: bordorColor, width: 3),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: bordorColor.withOpacity(0.5),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Imagen a la izquierda
          Expanded(
            flex: 3,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: AspectRatio(
                aspectRatio: 4 / 3,
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Texto a la derecha
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: redAccent,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
