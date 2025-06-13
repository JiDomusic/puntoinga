import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../main.dart';

class contacto_inga extends StatelessWidget {
  const contacto_inga({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color rojo = Color(0xFFB71C1C);
    const Color amarillo = Color(0xFFFFEB3B);
    const Color negro = Colors.black;
    const Color verde = Color(0xFF1B5E20);

    return Scaffold(
      backgroundColor: negro,
      appBar: AppBar(
        backgroundColor: rojo,
        title: const Text('Contacto INGA'),
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
      body: Stack(
        children: [
          // Imagen de fondo
          Positioned.fill(
            child: Opacity(
              opacity: 0.50,
              child: Image.asset(
                'assets/images/LOOOGOO.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Contenido principal
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Text(
                  'Contáctanos',
                  style: TextStyle(
                    color: amarillo,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),

                contactoItem(
                  icon: FontAwesomeIcons.instagram,
                  label: '@inga.oficial',
                  color: Colors.pinkAccent,
                  onTap: () async {
                    final url = Uri.parse('https://www.instagram.com/inga.oficial');
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url, mode: LaunchMode.externalApplication);
                    }
                  },
                ),
                const SizedBox(height: 15),

                contactoItem(
                  icon: FontAwesomeIcons.whatsapp,
                  label: '+57 300 123 4567',
                  color: verde,
                  onTap: () async {
                    final url = Uri.parse('https://wa.me/573001234567');
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url, mode: LaunchMode.externalApplication);
                    }
                  },
                ),
                const SizedBox(height: 15),

                contactoItem(
                  icon: Icons.phone,
                  label: '(601) 123 4567',
                  color: amarillo,
                  onTap: () async {
                    final url = Uri.parse('tel:6011234567');
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    }
                  },
                ),
                const SizedBox(height: 15),

                contactoItem(
                  icon: Icons.email,
                  label: 'contacto@inga.com',
                  color: rojo,
                  onTap: () async {
                    final url = Uri.parse('mailto:contacto@inga.com');
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget contactoItem({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          border: Border.all(color: color, width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 18,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
