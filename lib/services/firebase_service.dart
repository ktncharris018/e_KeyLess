import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_notepad/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// Excepciones personalizadas para manejar errores de Firebase
class FirebaseServiceException implements Exception {
  final String message;
  FirebaseServiceException(this.message);

  @override
  String toString() => message;
}

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Registra un usuario con email/password y guarda sus datos en Firestore
  Future<UserModel?> registerWithEmail({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final fbUser = credential.user;
      if (fbUser == null) return null;

      final userModel = UserModel(
        uid: fbUser.uid,
        name: name,
        email: fbUser.email!,
      );

      await _firestore
          .collection('usuarios')
          .doc(userModel.uid)
          .set(userModel.toMap());

      return userModel;
    } on FirebaseAuthException catch (e) {
      // Mapear códigos de error a mensajes más claros
      String msg;
      switch (e.code) {
        case 'email-already-in-use':
          msg = 'El correo ya está en uso.';
          break;
        case 'weak-password':
          msg = 'La contraseña es muy débil.';
          break;
        default:
          msg = 'Error de registro: ${e.message}';
      }
      throw FirebaseServiceException(msg);
    } catch (e) {
      throw FirebaseServiceException('Error inesperado al registrar usuario.');
    }
  }

  /// Inicia sesión con email/password y retorna el modelo de usuario
  Future<UserModel?> loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final fbUser = credential.user;
      if (fbUser == null) return null;

      final doc = await _firestore.collection('usuarios').doc(fbUser.uid).get();
      if (!doc.exists) {
        throw FirebaseServiceException('Usuario no encontrado en Firestore.');
      }

      return UserModel.fromMap({
        'uid': fbUser.uid,
        ...doc.data()!,
        'email': fbUser.email,
      });
    } on FirebaseAuthException catch (e) {
      String msg;
      switch (e.code) {
        case 'user-not-found':
          msg = 'Usuario no encontrado.';
          break;
        case 'wrong-password':
          msg = 'Contraseña incorrecta.';
          break;
        default:
          msg = 'Error de login: ${e.message}';
      }
      throw FirebaseServiceException(msg);
    } catch (e) {
      throw FirebaseServiceException('Error inesperado al iniciar sesión.');
    }
  }

  /// Cierra sesión
  Future<void> signOut() async {
    await _auth.signOut();
  }

  /// Envía correo de recuperación de contraseña
  Future<void> sendPasswordResetEmail(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  /// Getter del usuario actual de Firebase (no modelo personalizado)
  User? get firebaseUser => _auth.currentUser;

  /// Obtiene el modelo completo del usuario actual desde Firestore
  Future<UserModel?> getCurrentUserModel() async {
    final fbUser = _auth.currentUser;
    if (fbUser == null) return null;

    final doc = await _firestore.collection('usuarios').doc(fbUser.uid).get();
    if (!doc.exists) return null;

    return UserModel.fromMap({
      'uid': fbUser.uid,
      ...doc.data()!,
      'email': fbUser.email,
    });
  }

  /// Stream para escuchar cambios en el perfil del usuario en Firestore
  Stream<UserModel?> userStream() {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return const Stream.empty();

    return _firestore.collection('usuarios').doc(uid).snapshots().map((snap) {
      if (!snap.exists || snap.data() == null) return null;
      return UserModel.fromMap({'uid': uid, ...snap.data()!});
    });
  }

  /// Actualiza campos parciales del perfil de usuario
  Future<void> updateUserProfile({String? name, String? imagenPerfil}) {
    final uid = _auth.currentUser?.uid;
    if (uid == null) {
      throw FirebaseServiceException('No hay usuario autenticado.');
    }

    final data = <String, dynamic>{};
    if (name != null) data['name'] = name;
    if (imagenPerfil != null) data['imagenPerfil'] = imagenPerfil;

    return _firestore.collection('usuarios').doc(uid).update(data);
  }

  Future<UserModel> signInWithGoogle() async {
    try {
      UserCredential userCred;
      if (kIsWeb) {
        // En web, abre el popup directamente
        final provider = GoogleAuthProvider();
        userCred = await _auth.signInWithPopup(provider);
      } else {
        // En móvil, flujo nativo
        final googleUser = await GoogleSignIn().signIn();
        if (googleUser == null) {
          throw FirebaseServiceException('Inicio con Google cancelado');
        }
        final googleAuth = await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        userCred = await _auth.signInWithCredential(credential);
      }

      final fbUser = userCred.user!;
      final userDoc = _firestore.collection('usuarios').doc(fbUser.uid);
      final snapshot = await userDoc.get();

      final userModel = UserModel(
        uid: fbUser.uid,
        name: fbUser.displayName ?? 'Sin Nombre',
        email: fbUser.email!,
        imagenPerfil: fbUser.photoURL,
      );

      if (!snapshot.exists) {
        await userDoc.set(userModel.toMap());
      }

      return userModel;
    } on FirebaseAuthException catch (e) {
      throw FirebaseServiceException('Error en Google Sign-In: ${e.message}');
    } catch (e) {
      throw FirebaseServiceException('Error inesperado en Google Sign-In.');
    }
  }
}
