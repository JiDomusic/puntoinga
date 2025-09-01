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

  // Configurar estrategia de URL
  try {
    setUrlStrategy(PathUrlStrategy());
  } catch (e) {
    // Silenciar errores de URL strategy para evitar conflictos con hosting
  }

  // Inicializar Firebase solo si está disponible
  bool firebaseInitialized = false;
  try {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyCy1ebHorTaRBgIm4GzicdtDsIbsnKuTYE",
        authDomain: "puntorojo-9a6ce.firebaseapp.com",
        projectId: "puntorojo-9a6ce",
        messagingSenderId: "826307552004",
        appId: "1:826307552004:web:075cf163a2436cfaa82651",
      ),
    );
    firebaseInitialized = true;
    print('Firebase initialized successfully');
  } catch (e) {
    // Firebase no disponible, la app funciona sin autenticación
    firebaseInitialized = false;
  }

  runApp(MyApp(
    initialScreen: const HomeScreen(),
    firebaseEnabled: firebaseInitialized,
  ));
}

class MyApp extends StatelessWidget {
  final Widget initialScreen;
  final bool firebaseEnabled;
  
  const MyApp({
    super.key, 
    required this.initialScreen,
    this.firebaseEnabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Punto Rojo / Coop Inga',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0A0A0A),
        primaryColor: const Color(0xFFD32F2F),
        colorScheme: ColorScheme.dark(
          primary: const Color(0xFFD32F2F),
          secondary: const Color(0xFFFFB000),
          surface: const Color(0xFF1C1C1C),
          background: const Color(0xFF0A0A0A),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: const Color(0xFF1C1C1C),
          foregroundColor: Colors.white,
          elevation: 3,
          shadowColor: const Color(0xFFD32F2F).withOpacity(0.3),
          toolbarHeight: 65,
          titleTextStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            letterSpacing: 0.5,
          ),
        ),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.bold,
            height: 1.2,
          ),
          headlineMedium: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.w600,
            height: 1.3,
          ),
          titleLarge: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w600,
            height: 1.2,
          ),
          titleMedium: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
          bodyLarge: TextStyle(
            color: Colors.white,
            fontSize: 16,
            height: 1.5,
          ),
          bodyMedium: TextStyle(
            color: Color(0xFFCCCCCC),
            fontSize: 14,
            height: 1.4,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: const Color(0xFFD32F2F),
            elevation: 4,
            shadowColor: const Color(0xFFD32F2F).withOpacity(0.4),
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 28),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            textStyle: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3,
            ),
          ),
        ),
        cardTheme: CardThemeData(
          color: const Color(0xFF1C1C1C),
          elevation: 6,
          shadowColor: const Color(0xFFD32F2F).withOpacity(0.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
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
    if (!mounted) return;
    
    Widget? screen;

    if (title == 'Admin') {
      // Solo intentar acceder a Firebase si está habilitado
      final app = context.findAncestorWidgetOfExactType<MyApp>();
      if (app?.firebaseEnabled == true) {
        try {
          final user = FirebaseAuth.instance.currentUser;
          if (user == null) {
            if (mounted) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
              );
            }
            return;
          }
          screen = const AdminDashboard();
        } catch (e) {
          // Error de autenticación silenciado
          _showErrorSnackBar(context, 'Servicio de autenticación no disponible');
          return;
        }
      } else {
        _showErrorSnackBar(context, 'Función de administración no disponible');
        return;
      }
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
          screen = const Audiovisuales();
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
          // Ruta por defecto
          screen = const videos_page.Videos();
      }

      if (mounted && screen != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => screen!),
        );
      }
    }
  }

  Widget animatedButton(String label, VoidCallback onTap, {IconData? icon}) {
    return _AnimatedElevatedButton(label: label, onTap: onTap, icon: icon);
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFFD32F2F),
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Widget buildContent({
    required String title,
    required String imagePath,
    required List<Map<String, String>> buttons,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: double.infinity,
          height: 220,
          margin: const EdgeInsets.only(bottom: 24),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF2A2A2A),
                const Color(0xFF1C1C1C),
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFFFFB000).withOpacity(0.6),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFD32F2F).withOpacity(0.2),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                blurRadius: 25,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Image.asset(
            imagePath,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color(0xFFD32F2F),
                      const Color(0xFFB71C1C),
                    ],
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.business,
                    color: Colors.white,
                    size: 64,
                  ),
                ),
              );
            },
          ),
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 28,
            letterSpacing: 0.8,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Container(
          width: 80,
          height: 4,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [const Color(0xFFFFB000), const Color(0xFFD32F2F)],
            ),
            borderRadius: BorderRadius.circular(2),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFFFB000).withOpacity(0.4),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
        ),
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
          Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [const Color(0xFFD32F2F), const Color(0xFFFFB000)],
              ),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFD32F2F).withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: IconButton(
              icon: const Icon(Icons.admin_panel_settings),
              tooltip: 'Acceso Admin',
              onPressed: () => _navigateTo(context, 'Admin'),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topCenter,
            radius: 1.5,
            colors: [
              const Color(0xFF1C1C1C).withOpacity(0.3),
              const Color(0xFF0A0A0A),
              const Color(0xFF000000),
            ],
          ),
        ),
        child: LayoutBuilder(
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
                            width: double.infinity,
                            constraints: const BoxConstraints(
                              maxWidth: 450,
                              minHeight: 600,
                            ),
                            padding: const EdgeInsets.all(32),
                            margin: const EdgeInsets.only(bottom: 24),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  const Color(0xFF2A2A2A),
                                  const Color(0xFF1C1C1C),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: const Color(0xFFD32F2F).withOpacity(0.4),
                                width: 1.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFFD32F2F).withOpacity(0.2),
                                  blurRadius: 15,
                                  offset: const Offset(0, 8),
                                ),
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 20,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: buildContent(
                              title: 'PUNTO ROJO',
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
                      SlideTransition(
                        position: _rightOffsetAnimation,
                        child: FadeTransition(
                          opacity: _rightController,
                          child: Container(
                            width: double.infinity,
                            constraints: const BoxConstraints(
                              maxWidth: 450,
                              minHeight: 600,
                            ),
                            padding: const EdgeInsets.all(32),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  const Color(0xFF2A2A2A),
                                  const Color(0xFF1C1C1C),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: const Color(0xFFFFB000).withOpacity(0.5),
                                width: 1.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFFFFB000).withOpacity(0.15),
                                  blurRadius: 15,
                                  offset: const Offset(0, 8),
                                ),
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 20,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: buildContent(
                              title: 'COOPERATIVA INGA',
                              imagePath: 'assets/images/INGAALOGOOOOO.webp',
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
                                  padding: const EdgeInsets.all(36),
                                  margin: const EdgeInsets.only(right: 12),
                                  constraints: const BoxConstraints(
                                    minHeight: 650,
                                  ),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        const Color(0xFF2A2A2A),
                                        const Color(0xFF1C1C1C),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: const Color(0xFFD32F2F).withOpacity(0.4),
                                      width: 1.5,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFFD32F2F).withOpacity(0.2),
                                        blurRadius: 15,
                                        offset: const Offset(0, 8),
                                      ),
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.3),
                                        blurRadius: 20,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: buildContent(
                                    title: 'PUNTO ROJO',
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
                                child: Container(
                                  padding: const EdgeInsets.all(36),
                                  margin: const EdgeInsets.only(left: 12),
                                  constraints: const BoxConstraints(
                                    minHeight: 650,
                                  ),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        const Color(0xFF2A2A2A),
                                        const Color(0xFF1C1C1C),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: const Color(0xFFFFB000).withOpacity(0.5),
                                      width: 1.5,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFFFFB000).withOpacity(0.15),
                                        blurRadius: 15,
                                        offset: const Offset(0, 8),
                                      ),
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.3),
                                        blurRadius: 20,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: buildContent(
                                    title: 'COOPERATIVA INGA',
                                    imagePath: 'assets/images/INGAALOGOOOOO.webp',
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
                          ),
                        ],
                      ),
                    ],
                    const SizedBox(height: 30),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [const Color(0xFFD32F2F), const Color(0xFFFFB000)],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFD32F2F).withOpacity(0.3),
                            blurRadius: 15,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        icon: const Icon(Icons.video_library, size: 24, color: Colors.white),
                        label: const Text(
                          'VIDEOS',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 1.0,
                          ),
                        ),
                        onPressed: () => _navigateTo(context, 'videos'),
                      ),
                    ),

                    const SizedBox(height: 50),
                    Center(
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [const Color(0xFFD32F2F), const Color(0xFFFFB000)],
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.business,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
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
            foregroundColor: Colors.white,
            backgroundColor: _pressed 
              ? const Color(0xFFB71C1C)
              : const Color(0xFFD32F2F),
            elevation: _pressed ? 2 : 4,
            shadowColor: const Color(0xFFD32F2F).withOpacity(0.4),
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 28),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            textStyle: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
          icon: widget.icon != null 
            ? Icon(widget.icon, size: 20) 
            : const SizedBox.shrink(),
          label: Text(
            widget.label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
              fontSize: 17,
            ),
          ),
          onPressed: widget.onTap,
        ),
      ),
    );
  }
}