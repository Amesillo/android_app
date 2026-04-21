// lib/models/android_version.dart

class AndroidVersion {
  final int? id;
  final String nombre;          // Aquí escribirás: "T1" o "YLoL"
  final String fecha;           // Aquí escribirás: "Fecha del torneo/evento"
  final String descripcion;     // Aquí escribirás: "Descripción detallada"
  final String caracteristicas; // Aquí escribirás: "Jugadores/Stats/Info extra"
  final String urlPhoto;        // Aquí la URL de la imagen

  AndroidVersion({
    this.id,
    required this.nombre,
    required this.fecha,
    required this.descripcion,
    required this.caracteristicas,
    required this.urlPhoto,
  });

  /// Convert JSON to AndroidVersion object
  factory AndroidVersion.fromJson(Map<String, dynamic> json) {
    final id = json['id'] as int?;
    return AndroidVersion(
      id:              (id == null || id <= 0) ? null : id,
      nombre:          json['nombre']          ?? '',
      fecha:           json['fecha']           ?? '',
      descripcion:     json['descripcion']     ?? '',
      caracteristicas: json['caracteristicas'] ?? '',
      urlPhoto:        json['urlPhoto']        ?? '',
    );
  }

  /// Convert AndroidVersion object to JSON
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'nombre':          nombre,
      'fecha':           fecha,
      'descripcion':     descripcion,
      'caracteristicas': caracteristicas,
      'urlPhoto':        urlPhoto,
    };
    // Solo incluir el id si no es null y es válido
    if (id != null && id! > 0) {
      data['id'] = id!;
    }
    return data;
  }

  /// Lista de características separadas por coma
  List<String> get caracteristicasList =>
      caracteristicas.split(',').map((e) => e.trim()).toList();

  @override
  String toString() =>
      'AndroidVersion(id: $id, nombre: $nombre, fecha: $fecha)';
}