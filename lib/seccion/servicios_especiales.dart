import 'package:flutter/material.dart';

class serviciosespeciales extends StatelessWidget {
  const serviciosespeciales({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Servicios especiales',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.red.shade800,
        centerTitle: true,
        elevation: 0,
      ),
      body: ScrollConfiguration(
        behavior: ScrollBehavior().copyWith(overscroll: false),
        child: Scrollbar(
          thumbVisibility: true,
          thickness: 6,
          radius: const Radius.circular(3),

          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 24),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Column(
                  children: [
                    servicioItem(
                      titulo: 'Streaming Multicámaras',
                      imagenAsset: 'assets/images/01.jpg',
                      descripcion:
                      """Este servicio a una, o más cámaras, permite el registro de diversas actividades para establecimientos, instituciones, individuos o grupos que quieran mejorar su apariencia e imagen en las redes, dejando atrás el amateurismo y convirtiendo a las transmisiones en vivo en streaming profesional multicámara. 
• Se puede realizar como re streaming de conversatorios, charlas y capacitaciones.
• El streaming se desarrolla con los dispositivos y recursos que el cliente ya posee, siendo nuestra productora la que aporta conocimiento y creatividad en la retransmisión a través de un software específico de dichas actividades.
• Se incluyen en este servicio la contratación de Zoom, la retransmisión por varias redes sociales en simultáneo, el diseño de gráficas y backgrounds y el asesoramiento al cliente de elementos propios de este recurso: cronograma, guiones, encuadres, iluminación, etc. Son nuestros insumos: los Congresos, seminarios, formación de posgrado, diplomaturas, cursos, talleres, clases magistrales, actos políticos e institucionales, eventos deportivos, etc.
                  """,
                      color: Colors.red.shade700,
                    ),
                    const SizedBox(height: 30),
                    servicioItem(
                      titulo: 'Prensa y Comunicación Integral',
                      imagenAsset: 'assets/images/03.jpg',
                      descripcion:
                      """Ofrecemos un servicio de comunicación integral, institucional, tanto interna como externa. 
• Desarrollamos la cobertura de eventos y diversas actividades a través de registro fotográfico, audiovisual y periodístico. 
• Edición y publicación del material en variedad de formatos: reels, shorts o publicaciones, copys y contenidos para redes sociales. 
• Llevamos a cabo la producción y realización de entrevistas y artículos periodísticos, comunicados y notas de prensa, incluyendo el contacto con medios de comunicación, la organización de conferencias de prensa y la difusión. 
• Armado y envío de mails internos, para quienes integran la Organización; o externos, para clientes (newsletters). 
• Diseño gráfico general (identidad de marca, creación de logos, etc) y de materiales impresos (volantes, afiches y boletines, entre otros) y para redes sociales. 
• Reorganizamos las publicaciones para que estén en sintonía (gráfica y discursivamente) con el diseño general de la marca o la institución. 
• Servicio de capacitación y asesoramiento en administración de redes para organizaciones sociales, emprendedores, clubes, etc. Este servicio brinda a las instituciones intermedias la posibilidad de capacitar a algunos de sus miembros para que desarrollen las tareas cotidianas de comunicación. """,
                      color: Colors.yellow.shade700,
                    ),
                    const SizedBox(height: 30),
                    servicioItem(
                      titulo: 'Tutoriales para Redes',
                      imagenAsset: 'assets/images/02.jpg',
                      descripcion:
                      """    • Pensado para comunicar, explicar, desarrollar técnicas, saberes, conocimientos específicos con una diversidad de usos y aplicaciones concretas para una infinidad de áreas del trabajo, entretenimiento, educación, etc. 
    • Trabajaremos con cápsulas audiovisuales de breve duración para que puedan ser difundidas por redes sociales, manteniendo la atención de las audiencias y los formatos específicos de cada red puntual.
    • Incluye la escritura del guión, la realización y la edición.
    • Especialmente pensado para: personas individuales, colectivos, personas jurídicas, organizaciones, que pretendan llegar más y mejor a través de las redes sociales para aclarar, explicar, desarrollar un saber específico, una técnica o simplemente contar su experiencia o su saber específico frente a una audiencia determinada
 """,
                      color: Colors.red.shade400,
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget servicioItem({
    required String titulo,
    required String imagenAsset,
    required String descripcion,
    required Color color,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color, width: 2),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titulo,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              imagenAsset,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            descripcion,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white70,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
