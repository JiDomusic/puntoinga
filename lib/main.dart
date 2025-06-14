import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:puntorojo/seccion/contacto_Inga.dart';
import 'package:puntorojo/seccion/galeria.dart';
import 'package:puntorojo/seccion/quienes_somos.dart';
import 'package:puntorojo/seccion/servicios_especiales.dart';
import 'package:puntorojo/seccion/sobre_nosotros.dart';
import 'package:puntorojo/seccion/audiovisuales.dart';
import 'package:puntorojo/seccion/contacto.dart';
import 'package:puntorojo/seccion/cooperativa.dart';
import 'package:puntorojo/seccion/productos_y_servicios.dart';

import 'admin_dashboard.dart';
import 'login_screen.dart';
import 'seccion/videos.dart' as videos_page;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setUrlStrategy(PathUrlStrategy());

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCy1ebHorTaRBgIm4GzicdtDsIbsnKuTYE",
      authDomain: "puntorojo-9a6ce.firebaseapp.com",
      projectId: "puntorojo-9a6ce",
      messagingSenderId: "826307552004",
      appId: "1:826307552004:web:075cf163a2436cfaa82651",
    ),
  );

  runApp(MyApp(initialScreen: const HomeScreen()));
}

class MyApp extends StatelessWidget {
  final Widget initialScreen;
  const MyApp({super.key, required this.initialScreen});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'punto rojo / coopLinga',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        primaryColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          elevation: 1,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
          titleLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.grey[900],
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            textStyle: const TextStyle(fontSize: 16),
          ),
        ),
      ),
      home: initialScreen,
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final AnimationController _leftController;
  late final Animation<Offset> _leftOffsetAnimation;
  late final AnimationController _rightController;
  late final Animation<Offset> _rightOffsetAnimation;

  @override
  void initState() {
    super.initState();

    _leftController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _leftOffsetAnimation = Tween<Offset>(begin: const Offset(-0.3, 0), end: Offset.zero)
        .animate(CurvedAnimation(parent: _leftController, curve: Curves.easeOut));

    _rightController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _rightOffsetAnimation = Tween<Offset>(begin: const Offset(0.3, 0), end: Offset.zero)
        .animate(CurvedAnimation(parent: _rightController, curve: Curves.easeOut));

    _leftController.forward();
    _rightController.forward();
  }

  @override
  void dispose() {
    _leftController.dispose();
    _rightController.dispose();
    super.dispose();
  }

  Future<void> _navigateTo(BuildContext context, String title) async {
    Widget screen;

    if (title == 'Admin') {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
        return;
      }
      screen = const AdminDashboard();
    } else {
      switch (title) {
        case 'sobre nosotros':
          screen = const sobrenosotros();
          break;
        case 'servicios especiales':
          screen = const serviciosespeciales();
          break;
        case 'contacto':
          screen = const contacto();
          break;
        case 'audiovisuales':
          screen = const audiovisuales();
          break;

        case 'cooperativa':
          screen = const cooperativa();
          break;
        case 'quienes somos':
          screen = const quienessomos();
          break;
        case 'galería':
          screen = galeria();
          break;
        case 'contactos':
          screen = const contacto_inga();
          break;
        case 'productos y servicios':
          screen = const productosyservicios();
          break;
        case 'videos':
          screen = const videos_page.Videos();
          break;
        default:
          print('⚠️ Ruta no encontrada para "$title", mostrando Videos por defecto');
          screen = const videos_page.Videos();
      }

      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => screen),
      );
    }
  }

  Widget animatedButton(String label, VoidCallback onTap, {IconData? icon}) {
    return _AnimatedElevatedButton(label: label, onTap: onTap, icon: icon);
  }

  Widget buildContent({
    required String title,
    required String imagePath,
    required List<Map<String, String>> buttons,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(child: Image.asset(imagePath, width: 200, height: 200)),
        const SizedBox(height: 20),
        Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        for (var btn in buttons)
          animatedButton(
            btn['label']!,
                () => _navigateTo(context, btn['label']!),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;

    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        actions: [
          IconButton(
            icon: const Icon(Icons.admin_panel_settings),
            tooltip: 'Acceso Admin',
            onPressed: () => _navigateTo(context, 'Admin'),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Column(
                children: [
                  if (isMobile) ...[
                    SlideTransition(
                      position: _leftOffsetAnimation,
                      child: FadeTransition(
                        opacity: _leftController,
                        child: Container(
                          constraints: const BoxConstraints(maxWidth: 400),
                          padding: const EdgeInsets.all(16),
                          margin: const EdgeInsets.only(bottom: 30),
                          decoration: BoxDecoration(
                            color: Colors.grey[900],
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: buildContent(
                            title: 'Punto Rojo',
                            imagePath: 'assets/images/puntorojo2.webp',
                            buttons: [
                              {'label': 'sobre nosotros'},
                              {'label': 'servicios especiales'},
                              {'label': 'contacto'},
                              {'label': 'audiovisuales'},

                            ],
                          ),
                        ),
                      ),
                    ),
                    SlideTransition(
                      position: _rightOffsetAnimation,
                      child: FadeTransition(
                        opacity: _rightController,
                        child: Container(
                          constraints: const BoxConstraints(maxWidth: 400),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.grey[900],
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: buildContent(
                            title: 'Cooperativa Inga',
                            imagePath: 'assets/images/coopinga.png',
                            buttons: [
                              {'label': 'cooperativa'},
                              {'label': 'quienes somos'},
                              {'label': 'contactos'},
                              {'label': 'productos y servicios'},
                              {'label': 'galería'},
                            ],
                          ),
                        ),
                      ),
                    ),
                  ] else ...[
                    Row(
                      children: [
                        Expanded(
                          child: SlideTransition(
                            position: _leftOffsetAnimation,
                            child: FadeTransition(
                              opacity: _leftController,
                              child: Container(
                                decoration: const BoxDecoration(
                                  border: Border(
                                    right: BorderSide(color: Colors.redAccent, width: 2),
                                  ),
                                ),
                                child: buildContent(
                                  title: 'Punto Rojo',
                                  imagePath: 'assets/images/puntorojo.webp',
                                  buttons: [
                                    {'label': 'sobre nosotros'},
                                    {'label': 'servicios especiales'},
                                    {'label': 'contacto'},
                                    {'label': 'audiovisuales'},

                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: SlideTransition(
                            position: _rightOffsetAnimation,
                            child: FadeTransition(
                              opacity: _rightController,
                              child: buildContent(
                                title: 'Cooperativa Inga',
                                imagePath: 'assets/images/coopinga.png',
                                buttons: [
                                  {'label': 'cooperativa'},
                                  {'label': 'quienes somos'},
                                  {'label': 'contactos'},
                                  {'label': 'productos y servicios'},
                                  {'label': 'galería'},
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                  const SizedBox(height: 30),
                  animatedButton('Videos', () => _navigateTo(context, 'videos'), icon: Icons.video_library),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _AnimatedElevatedButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final IconData? icon;

  const _AnimatedElevatedButton({
    required this.label,
    required this.onTap,
    this.icon,
  });

  @override
  State<_AnimatedElevatedButton> createState() => _AnimatedElevatedButtonState();
}

class _AnimatedElevatedButtonState extends State<_AnimatedElevatedButton> {
  bool _pressed = false;

  void _onTapDown(TapDownDetails details) => setState(() => _pressed = true);
  void _onTapUp(TapUpDetails details) {
    setState(() => _pressed = false);
    widget.onTap();
  }

  void _onTapCancel() => setState(() => _pressed = false);

  @override
  Widget build(BuildContext context) {
    final elevation = _pressed ? 12.0 : 4.0;
    final scale = _pressed ? 0.98 : 1.0;

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeInOut,
        transform: Matrix4.identity()..scale(scale),
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            elevation: elevation,
            backgroundColor: Colors.grey[900],
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
            textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          icon: widget.icon != null ? Icon(widget.icon) : const SizedBox.shrink(),
          label: Text(widget.label),
          onPressed: widget.onTap,
        ),
      ),
    );
  }
}
