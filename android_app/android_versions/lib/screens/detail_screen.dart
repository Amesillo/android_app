// lib/screens/detail_screen.dart

import 'package:flutter/material.dart';
import '../models/android_version.dart';

class DetailScreen extends StatelessWidget {
  final AndroidVersion version;
  const DetailScreen({super.key, required this.version});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1A),
      body: CustomScrollView(
        slivers: [
          // ── App Bar con imagen o gradiente ──────────────────────
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            backgroundColor: const Color(0xFF1A0A2E),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF3DDC84)),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: version.urlPhoto.isNotEmpty
                  ? Image.network(
                      version.urlPhoto,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _gradientPlaceholder(),
                    )
                  : _gradientPlaceholder(),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Nombre + badge ID ──────────────────────────
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          version.nombre,
                          style: const TextStyle(
                            color: Color(0xFF3DDC84),
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF3DDC84).withOpacity(0.12),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: const Color(0xFF3DDC84).withOpacity(0.3)),
                        ),
                        child: Text(
                          'ID ${version.id}',
                          style: const TextStyle(
                              color: Color(0xFF3DDC84), fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),

                  // ── Fecha ──────────────────────────────────────
                  Row(
                    children: [
                      const Icon(Icons.calendar_today,
                          size: 14, color: Color(0xFF6272A4)),
                      const SizedBox(width: 6),
                      Text(
                        version.fecha,
                        style: const TextStyle(
                            color: Color(0xFF6272A4), fontSize: 13),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // ── Descripción ────────────────────────────────
                  _sectionTitle('Descripción'),
                  const SizedBox(height: 8),
                  Text(
                    version.descripcion,
                    style: const TextStyle(
                      color: Color(0xFFBBBBCC),
                      fontSize: 14,
                      height: 1.7,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // ── Características ────────────────────────────
                  _sectionTitle('Características'),
                  const SizedBox(height: 12),
                  ...version.caracteristicasList
                      .map((c) => _featureItem(c))
                      .toList(),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _gradientPlaceholder() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1A0A2E), Color(0xFF0E0618)],
        ),
      ),
      child: const Center(
        child: Icon(Icons.android, size: 80, color: Color(0xFF3DDC84)),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Color(0xFFF5E642),
        fontSize: 13,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _featureItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 3),
            child: Icon(Icons.arrow_right,
                color: Color(0xFF3DDC84), size: 18),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                  color: Color(0xFFCCCCDD), fontSize: 14, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}
