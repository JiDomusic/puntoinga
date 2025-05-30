import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class TeamMember {
  final String name;
  final String role;
  final String? imageAsset;
  final String? pdfAsset;
  final String description;
  final Color accentColor;

  TeamMember({
    required this.name,
    required this.role,
    this.imageAsset,
    this.pdfAsset,
    required this.description,
    required this.accentColor,
  });
}

class ServiciosEspeciales extends StatefulWidget {
  const ServiciosEspeciales({super.key});

  @override
  State<ServiciosEspeciales> createState() => _ServiciosEspecialesState();
}

class _ServiciosEspecialesState extends State<ServiciosEspeciales> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final List<TeamMember> teamMembers = [
    TeamMember(
      name: "Ofrecemos un servicio de comunicación integral",
      role: """Registro de diversas actividades""",
      imageAsset: "assets/images/01.jpg",
      description: """Institucional,tanto interna como externa.
    • Desarrollamos la cobertura de
    eventos y diversas actividades a
    través de registro fotográfico,
    audiovisual y periodístico.
    • Edición y publicación del
    material en variedad de formatos:
    reels, shorts o publicaciones, copys y
    contenidos para redes sociales.""",
      accentColor: Colors.amber,
    ),
    TeamMember(
      name: "Producción y Realización",
      role: "En Rosario y alrededores",
      pdfAsset: "assets/images/puntorojo2.jpg",
      description: """• Llevamos a cabo la producción y realización de entrevistas y artículos periodísticos, comunicados
   y notas de prensa, incluyendo el
   contacto con medios de
   comunicación, la organización de
   conferencias de prensa y la difusión.
  • Armado y envío de mails
   internos, para quienes integran la
   Organización; o externos, para clientes  newsletters """,
      accentColor: Colors.purple,
    ),
    TeamMember(
      name: "Editor",
      role: "Editor Senior",
      imageAsset: "assets/images/02.jpg",
      description: """Diseño gráfico general(identidad de marca, creación de logos, etc) y de materiales impresos
    (volantes, afiches y boletines, entre
    otros) y para redes sociales. • Community management. En coordinación con el equipo de prensa
    y comunicación y con el de diseño gráfico, nos abocamos a calendarizar
    publicaciones, elegir los formatos
   (publicación, historias, reels, videos) más adecuados, responder los mensajes de la comunidad, organizar
   sorteos, entre otras funciones.""",
      accentColor: Colors.blue,
    ),
    TeamMember(
      name: "Sound",
      role: "Diseñador de Sonido",
      imageAsset: "assets/images/04.jpg",
      description: """• Servicio de capacitación y asesoramiento en administración de redes para organizaciones sociales,
    emprendedores, clubes, etc. Este
    servicio brinda a las instituciones
    intermedias la posibilidad de
    capacitar a algunos de sus miembros para que desarrollen las tareas
    cotidianas de comunicación.""",
      accentColor: Colors.green,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;

    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('EL EQUIPO').animate().fadeIn(duration: 800.ms),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ).animate().slideX(begin: -1, end: 0, duration: 500.ms),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.scale(
                  scale: 1.0 + (_controller.value * 0.05),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        center: Alignment.center,
                        radius: 1.5,
                        colors: [
                          Colors.black.withOpacity(0.9),
                          Colors.black.withOpacity(0.95),
                          Colors.black,
                        ],
                        stops: const [0.0, 0.5, 1.0],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          ...List.generate(
            20,
                (index) => Positioned(
              left: math.Random().nextDouble() * size.width,
              top: math.Random().nextDouble() * size.height,
              child: Container(
                width: 2,
                height: 2,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
              ).animate(
                delay: (index * 100).ms,
              )
                  .scale(duration: 2000.ms, curve: Curves.easeInOut)
                  .then(delay: 1000.ms)
                  .fadeOut(duration: 1000.ms)
                  .then()
                  .fadeIn(duration: 1000.ms),
            ),
          ),

          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: SizedBox(height: isMobile ? 100 : 50)),

              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        """SERVICIO DE PRENSA Y COMUNICACIÓN INSTITUCIONAL""",
                        style: TextStyle(
                          fontSize: isMobile ? 28 : 27,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.5, end: 0),
                      const SizedBox(height: 20),
                      Text(
                        """ Especialmente pensado para: personas individuales, colectivos, personas jurídicas, organizaciones, que pretendan llegar más y mejor a través de las redes sociales para aclarar, explicar, desarrollar un saber específico, una técnica o simplemente contar su experiencia o su saber específico frente a una audiencia determinada.""",
                        style: TextStyle(
                          fontSize: isMobile ? 16 : 18,
                          color: Colors.white70,
                          height: 1.5,
                        ),
                      ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.5, end: 0, delay: 200.ms),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),

              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 40),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: isMobile ? 1 : 2,
                    mainAxisSpacing: 50,
                    crossAxisSpacing: 50,
                    childAspectRatio: isMobile ? 1.2 : 1.5,
                  ),
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      final member = teamMembers[index];
                      return _buildTeamMemberCard(member, index, isMobile);
                    },
                    childCount: teamMembers.length,
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 40),
                  child: Column(
                    children: [
                      Text(
                        'CONTÁCTANOS PARA TU PRÓXIMO PROYECTO',
                        style: TextStyle(
                          fontSize: isMobile ? 18 : 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ).animate().fadeIn(delay: 1200.ms),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        ),
                        child: const Text(
                          'Enviar Mensaje',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ).animate().fadeIn(delay: 1400.ms),
                      const SizedBox(height: 40),
                      Text(
                        '© 2025 Estudio Audiovisual',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white54,
                        ),
                      ).animate().fadeIn(delay: 1600.ms),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTeamMemberCard(TeamMember member, int index, bool isMobile) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: Colors.black,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _buildTeamMedia(member),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    member.name,
                    style: TextStyle(fontSize: isMobile ? 24 : 28, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  Text(member.role, style: TextStyle(fontSize: isMobile ? 16 : 18, color: member.accentColor)),
                  const SizedBox(height: 10),
                  Text(member.description, style: TextStyle(fontSize: isMobile ? 14 : 16, color: Colors.white70)),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    children: [
                      Icon(Icons.camera_alt_rounded, color: member.accentColor),
                      Icon(Icons.movie_creation_rounded, color: member.accentColor),
                      Icon(Icons.music_note_rounded, color: member.accentColor),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: member.accentColor.withOpacity(0.3), width: 1),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ],
      ),
    ).animate().slideY(
      begin: 0.5,
      end: 0,
      duration: 500.ms,
      delay: (index * 200).ms,
      curve: Curves.easeOutCubic,
    );
  }

  Widget _buildTeamMedia(TeamMember member) {
    if (member.imageAsset != null) {
      return Image.asset(
        member.imageAsset!,
        fit: BoxFit.cover,
        height: 400,
      );
    } else if (member.pdfAsset != null) {
      return Container(
        height: 200,
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 8, offset: const Offset(0, 4))],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: SfPdfViewer.asset(
            member.pdfAsset!,
            canShowScrollHead: false,
            canShowPaginationDialog: false,
          ),
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}
