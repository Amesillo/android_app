// lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import '../models/android_version.dart';
import '../models/user.dart';
import '../services/android_service.dart';
import 'detail_screen.dart';
import 'create_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  final User currentUser;
  const HomeScreen({super.key, required this.currentUser});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<AndroidVersion>> _future;

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() {
    setState(() {
      _future = AndroidService.getAll();
    });
  }

  Future<void> _delete(int id) async {
    await AndroidService.delete(id);
    _load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212), // Fondo más oscuro
      appBar: AppBar(
        backgroundColor: const Color(0xFF1B1B1B),
        elevation: 0,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: const Color(0xFFE53935).withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.sports_esports,
                  color: Color(0xFFE53935), size: 22),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'T1 x YLoL',
                    style: TextStyle(
                      color: Color(0xFFE53935),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    widget.currentUser.nombre,
                    style: const TextStyle(
                      color: Color(0xFFBDBDBD),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Color(0xFFBDBDBD)),
            onPressed: _load,
          ),
          IconButton(
            icon: const Icon(Icons.settings, color: Color(0xFFE53935)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProfileScreen(user: widget.currentUser),
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFE53935),
        foregroundColor: Colors.white,
        onPressed: () async {
          final created =
              await Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const CreateScreen()));
          if (created == true) _load();
        },
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<List<AndroidVersion>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFFE53935)),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error_outline,
                      color: Colors.redAccent, size: 48),
                  const SizedBox(height: 12),
                  Text('${snapshot.error}',
                      style: const TextStyle(color: Color(0xFFBDBDBD))),
                  const SizedBox(height: 16),
                  TextButton.icon(
                    onPressed: _load,
                    icon: const Icon(Icons.refresh,
                        color: Color(0xFFE53935)),
                    label: const Text('Reintentar',
                        style: TextStyle(color: Color(0xFFE53935))),
                  ),
                ],
              ),
            );
          }

          final versions = snapshot.data ?? [];
          if (versions.isEmpty) {
            return const Center(
              child: Text('No hay contenido aún.',
                  style: TextStyle(color: Color(0xFFBDBDBD))),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: versions.length,
            itemBuilder: (context, i) =>
                _VersionCard(version: versions[i], onDelete: _delete),
          );
        },
      ),
    );
  }
}

// ── Tarjeta individual estilo T1 ──────────────────────────────────
class _VersionCard extends StatelessWidget {
  final AndroidVersion version;
  final Future<void> Function(int) onDelete;

  const _VersionCard({required this.version, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => DetailScreen(version: version)),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        decoration: BoxDecoration(
          color: const Color(0xFF1B1B1B),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF333333)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
              child: version.urlPhoto.isNotEmpty
                  ? Image.network(
                      version.urlPhoto,
                      height: 140,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _placeholder(),
                    )
                  : _placeholder(),
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          version.nombre,
                          style: const TextStyle(
                            color: Color(0xFFE53935),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE53935).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: const Color(0xFFE53935).withOpacity(0.25)),
                        ),
                        child: Text('ID ${version.id}',
                            style: const TextStyle(color: Color(0xFFE53935), fontSize: 11)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(version.fecha, style: const TextStyle(color: Color(0xFFBDBDBD), fontSize: 12)),
                  const SizedBox(height: 8),
                  Text(version.descripcion,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Color(0xFFEEEEEE), fontSize: 13, height: 1.5)),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: version.caracteristicasList.take(3).map((c) => Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                              color: const Color(0xFF333333),
                              borderRadius: BorderRadius.circular(20)),
                          child: Text(c, style: const TextStyle(color: Colors.white, fontSize: 11)),
                        )).toList(),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: const Icon(Icons.delete_outline, color: Color(0xFFBDBDBD), size: 20),
                      onPressed: () async {
                         // Lógica de eliminación...
                         await onDelete(version.id!);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _placeholder() {
    return Container(
      height: 140,
      width: double.infinity,
      color: const Color(0xFF1B1B1B),
      child: const Center(
        child: Icon(Icons.sports_esports, color: Color(0xFFE53935), size: 50),
      ),
    );
  }
}