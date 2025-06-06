import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class YoutubeVideoPlayerExample extends StatefulWidget {
  final String videoId;
  final double height;

  const YoutubeVideoPlayerExample({
    required this.videoId,
    this.height = 180,
    super.key,
  });

  @override
  State<YoutubeVideoPlayerExample> createState() =>
      _YoutubeVideoPlayerExampleState();
}

class _YoutubeVideoPlayerExampleState extends State<YoutubeVideoPlayerExample> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      params: const YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,

      ),
    );
    _controller.loadVideoById(videoId: widget.videoId);
  }

  @override
  void didUpdateWidget(covariant YoutubeVideoPlayerExample oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.videoId != widget.videoId) {
      _controller.loadVideoById(videoId: widget.videoId);
    }
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: YoutubePlayer(
        controller: _controller,
        aspectRatio: 16 / 9,
      ),
    );
  }
}

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _textController = TextEditingController();
  final _urlController = TextEditingController();

  String message = '';
  String? errorText;
  String? _videoId;

  bool _isValidYoutubeUrl(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null) return false;
    final isYoutube =
        uri.host.contains('youtube.com') && uri.queryParameters.containsKey('v');
    final isShort = uri.host.contains('youtu.be') && uri.pathSegments.isNotEmpty;
    return isYoutube || isShort;
  }

  String? _extractYoutubeId(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null) return null;
    if (uri.host.contains('youtube.com')) {
      return uri.queryParameters['v'];
    } else if (uri.host.contains('youtu.be') && uri.pathSegments.isNotEmpty) {
      return uri.pathSegments.first;
    }
    return null;
  }

  void _updateVideoPreview() {
    final url = _urlController.text.trim();
    if (_isValidYoutubeUrl(url)) {
      final id = _extractYoutubeId(url);
      if (id != null) {
        setState(() {
          _videoId = id;
          errorText = null;
        });
        return;
      }
    }
    setState(() {
      _videoId = null;
      errorText = '⚠️ URL de YouTube no válida';
    });
  }

  Future<void> _submit() async {
    final url = _urlController.text.trim();
    if (!_isValidYoutubeUrl(url)) {
      setState(() {
        errorText = '⚠️ URL de YouTube no válida';
        message = '';
      });
      return;
    }

    final videoData = {
      'titulo': _titleController.text.trim(),
      'descripcion': _descriptionController.text.trim(),
      'texto': _textController.text.trim(),
      'url': url,
      'timestamp': Timestamp.now(),
    };

    await FirebaseFirestore.instance.collection('videos').add(videoData);

    setState(() {
      message = '✅ Video subido con éxito';
      errorText = null;
      _videoId = null;
    });

    _titleController.clear();
    _descriptionController.clear();
    _textController.clear();
    _urlController.clear();
  }

  Future<void> _cerrarSesion() async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('¿Cerrar sesión?'),
        content: const Text('¿Estás seguro de que quieres salir y cerrar la sesión?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Cerrar sesión'),
          ),
        ],
      ),
    );

    if (confirmar == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('👋 Has cerrado sesión'),
          duration: Duration(seconds: 2),
        ),
      );

      await Future.delayed(const Duration(seconds: 2));

      await FirebaseAuth.instance.signOut();

      if (!mounted) return;

      Navigator.of(context).pushNamedAndRemoveUntil('home', (route) => false);
    }
  }

  void _eliminarPublicacion(String docId) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Confirmar eliminación'),
        content: const Text(
            '¿Seguro quieres eliminar esta publicación? Esta acción no se puede deshacer.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancelar')),
          ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Eliminar')),
        ],
      ),
    );

    if (confirm == true) {
      await FirebaseFirestore.instance.collection('videos').doc(docId).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✅ Publicación eliminada')),
      );
    }
  }

  void _editarPublicacion(String docId, Map<String, dynamic> data) {
    _titleController.text = data['titulo'] ?? '';
    _descriptionController.text = data['descripcion'] ?? '';
    _textController.text = data['texto'] ?? '';
    _urlController.text = data['url'] ?? '';
    _updateVideoPreview();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Editar Video'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: 'Título')),
              TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: 'Descripción')),
              TextField(
                  controller: _textController,
                  decoration: const InputDecoration(labelText: 'Texto adicional')),
              TextField(
                  controller: _urlController,
                  decoration: const InputDecoration(labelText: 'URL de YouTube')),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () async {
              final updatedData = {
                'titulo': _titleController.text.trim(),
                'descripcion': _descriptionController.text.trim(),
                'texto': _textController.text.trim(),
                'url': _urlController.text.trim(),
                'timestamp': Timestamp.now(),
              };

              await FirebaseFirestore.instance
                  .collection('videos')
                  .doc(docId)
                  .update(updatedData);
              Navigator.pop(context);

              setState(() {
                message = '✅ Video actualizado con éxito';
                errorText = null;
                _videoId = null;
              });

              _titleController.clear();
              _descriptionController.clear();
              _textController.clear();
              _urlController.clear();
            },
            child: const Text('Guardar cambios'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _textController.dispose();
    _urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Cerrar sesión',
            onPressed: _cerrarSesion,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Scrollbar(
          child: ListView(
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Título'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Descripción'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _textController,
                decoration: const InputDecoration(labelText: 'Texto adicional'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _urlController,
                decoration: InputDecoration(
                  labelText: 'URL de YouTube',
                  errorText: errorText,
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.refresh),
                    onPressed: _updateVideoPreview,
                    tooltip: 'Actualizar vista previa',
                  ),
                ),
              ),
              const SizedBox(height: 20),
              if (_videoId != null)
                YoutubeVideoPlayerExample(
                  videoId: _videoId!,
                  height: 180,
                ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                child: const Text('Subir video'),
              ),
              const SizedBox(height: 30),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('videos')
                    .orderBy('timestamp', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Error al cargar videos');
                  }
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final docs = snapshot.data!.docs;
                  if (docs.isEmpty) {
                    return const Text('No hay videos publicados');
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      final doc = docs[index];
                      final data = doc.data() as Map<String, dynamic>;
                      final videoUrl = data['url'] as String? ?? '';
                      final videoId = _extractYoutubeId(videoUrl);

                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(8),
                          title: Text(data['titulo'] ?? ''),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(data['descripcion'] ?? ''),
                              if (videoId != null)
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: YoutubeVideoPlayerExample(
                                    videoId: videoId,
                                    height: 160,
                                  ),
                                ),
                            ],
                          ),
                          trailing: Wrap(
                            spacing: 8,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit, color: Colors.blue),
                                onPressed: () => _editarPublicacion(doc.id, data),
                                tooltip: 'Editar',
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _eliminarPublicacion(doc.id),
                                tooltip: 'Eliminar',
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 20),
              if (message.isNotEmpty)
                Center(
                  child: Text(
                    message,
                    style: const TextStyle(
                        color: Colors.green, fontWeight: FontWeight.bold),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
