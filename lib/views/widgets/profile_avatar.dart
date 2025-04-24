import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final String imagenPerfil;
  final double size;

  const ProfileAvatar({
    super.key,               // usa super parameters
    required this.imagenPerfil,
    this.size = 160,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: SizedBox(
        width: size,
        height: size,
        child: _buildImage(context),
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    // Si es URL remota
    if (imagenPerfil.startsWith('http')) {
      return Image.network(
        imagenPerfil,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) {
          // si falla la red, muestro el asset
          return Image.asset(
            'assets/default_avatar.png',
            fit: BoxFit.cover,
          );
        },
      );
    }

    // Si no es URL, asumo asset local
    return Image.asset(
      imagenPerfil,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) {
        // en caso de que falte el asset, muestro un icono
        return Center(
          child: Icon(
            Icons.person,
            size: size * 0.5,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        );
      },
    );
  }
}