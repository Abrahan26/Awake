class ModeloUsuarios {
  String? nombre;
  String? correo;
  String? contrasena;
  String? uid;
  

  ModeloUsuarios({this.uid, this.nombre, this.correo,  this.contrasena,});

  // receiving data from server
  factory ModeloUsuarios.fromMap(map) {
    return ModeloUsuarios(
      uid: map['uid'],
      nombre: map['nombre'],
      correo: map['correo'],
      contrasena: map['contrasena'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'nombre': nombre,
      'correo': correo,
      'contrasena':contrasena,
    };
  }
}