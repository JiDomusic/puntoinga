import 'package:flutter/material.dart';

class Servicios extends StatelessWidget {
  const Servicios({super.key});

  @override
  Widget build(BuildContext context) {
    final bordoColor = const Color(0xFF4A1A28); // tono bordo elegante
    final goldAccent = const Color(0xFFFFC107); // dorado
    final backgroundColor = const Color(0xFF1C1C1C); // gris oscuro

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: bordoColor,
        title: const Text(
          'Nuestros Servicios',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 22,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildMainServiceCard(bordoColor, goldAccent),
            const SizedBox(height: 20),
            _buildImageTextSection(
              bordoColor,
              goldAccent,
              'Editoriales',
              """• Revistas y libros con identidad.\n• Manuales y catálogos visuales.\n• Folletos que cuentan historias.""",
              'assets/images/servicioingacortado.jpg',
            ),
            _buildImageTextSection(
              bordoColor,
              goldAccent,
              'Comunicación Visual',
              """• Diseño para redes sociales.\n• Publicidad online y gráfica.\n• Cartelería para tu organización.""",
              'assets/images/cajaforenseinga.jpg',
            ),
            _buildImageTextSection(
              bordoColor,
              goldAccent,
              'Multimedia y Audiovisual',
              """• Sitios web dinámicos.\n• Tiendas virtuales.\n• Cobertura audiovisual de eventos.\n• Contenidos multimedia y transmedia.""",
              'assets/images/festitrapinga.jpg',
            ),
            _buildImageTextSection(
              bordoColor,
              goldAccent,
              'Prensa e Institucional',
              """• Gestión de comunicación interna y externa.\n• Diseño de campañas.\n• Presencia digital e institucional.""",
              'assets/images/CATA.png',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainServiceCard(Color bordo, Color gold) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: bordo, width: 3),
        boxShadow: [
          BoxShadow(
            color: bordo.withOpacity(0.4),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: const [
          Text(
            'COMUNICACIÓN VISUAL',
            style: TextStyle(
              fontSize: 26,
              color: Color(0xFF4A1A28),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Creamos identidad visual cooperativa con propósito:',
            style: TextStyle(fontSize: 18, color: Colors.black87),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Text(
            '• Diseño o rediseño de marcas\n'
                '• Papelería institucional\n'
                '• Kits de comunicación para redes y medios',
            style: TextStyle(fontSize: 16, color: Colors.black54),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildImageTextSection(
      Color bordoColor,
      Color goldAccent,
      String title,
      String description,
      String imagePath,
      ) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        border: Border.all(color: bordoColor, width: 2),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: bordoColor.withOpacity(0.3),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Imagen
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

          // Texto
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title.toUpperCase(),
                    style: TextStyle(
                      color: goldAccent,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.1,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.white70,
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
