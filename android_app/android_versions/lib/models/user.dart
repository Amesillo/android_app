class User {
  final String nombre;
  final String correo;
  final String contrasena;

  const User({
    required this.nombre,
    required this.correo,
    required this.contrasena,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      nombre: json['nombre'] ?? '',
      correo: json['correo'] ?? '',
      contrasena: json['contrasena'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'correo': correo,
      'contrasena': contrasena,
    };
  }
}
