class UserModel {
  final String uid;
  final String name;
  final String email;
  final String imagenPerfil;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    String? imagenPerfil,
  }) : imagenPerfil = imagenPerfil ?? 'assets/default_avatar.png';

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      imagenPerfil: map['imagenPerfil'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'imagenPerfil': imagenPerfil,
    };
  }

  UserModel copyWith({
    String? uid,
    String? name,
    String? email,
    String? imagenPerfil,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      imagenPerfil: imagenPerfil ?? this.imagenPerfil,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModel &&
          runtimeType == other.runtimeType &&
          uid == other.uid &&
          name == other.name &&
          email == other.email &&
          imagenPerfil == other.imagenPerfil;

  @override
  int get hashCode =>
      uid.hashCode ^ name.hashCode ^ email.hashCode ^ imagenPerfil.hashCode;
}
