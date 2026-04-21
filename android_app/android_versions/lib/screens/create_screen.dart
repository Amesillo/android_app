import 'package:flutter/material.dart';
import '../models/android_version.dart';
import '../services/android_service.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nombreCtrl = TextEditingController();
  final _fechaCtrl = TextEditingController();
  final _descripcionCtrl = TextEditingController();
  final _caracteristicasCtrl = TextEditingController();
  final _urlPhotoCtrl = TextEditingController();
  bool _loading = false;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);

    try {
      final nueva = AndroidVersion(
        nombre: _nombreCtrl.text.trim(),
        fecha: _fechaCtrl.text.trim(),
        descripcion: _descripcionCtrl.text.trim(),
        caracteristicas: _caracteristicasCtrl.text.trim(),
        urlPhoto: _urlPhotoCtrl.text.trim(),
      );
      await AndroidService.create(nueva);
      if (mounted) Navigator.pop(context, true);
    } catch (e) {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1B1B1B),
        title: const Text('Nuevo Registro T1', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFE53935)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            _field(_nombreCtrl, 'Equipo / Evento', Icons.sports_esports),
            _field(_fechaCtrl, 'Fecha', Icons.calendar_today),
            _field(_descripcionCtrl, 'Resumen', Icons.description),
            _field(_caracteristicasCtrl, 'Jugadores clave', Icons.group),
            _field(_urlPhotoCtrl, 'URL de imagen', Icons.image),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _loading ? null : _submit,
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFE53935), minimumSize: const Size(double.infinity, 50)),
              child: const Text('Guardar Registro', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _field(TextEditingController ctrl, String label, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: ctrl,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Color(0xFFBDBDBD)),
          prefixIcon: Icon(icon, color: const Color(0xFFE53935)),
          filled: true,
          fillColor: const Color(0xFF1B1B1B),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}