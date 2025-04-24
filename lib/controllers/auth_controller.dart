import 'package:e_notepad/models/user_model.dart';
import 'package:e_notepad/routes/app_routes.dart';
import 'package:e_notepad/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController {
  final FirebaseService _firebaseService = FirebaseService();
  final GetStorage _storage = GetStorage();

  // Estados reactivos
  final isLoading = false.obs;
  final isPasswordVisible = false.obs;
  final isFormValid = false.obs;
  final userModel = Rxn<UserModel>();

  @override
  void onInit() {
    super.onInit();
    // Intentar auto-login con credenciales guardadas
    _autoLogin();
    // Vincular el stream de Firestore para actualizaciones en tiempo real
    userModel.bindStream(_firebaseService.userStream());
  }

  // Alterna la visibilidad de la contraseña
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  // Valida el formulario de registro
  void validateRegisterForm({
    required String name,
    required String email,
    required String pass,
    required String confirm,
  }) {
    isFormValid.value =
        name.isNotEmpty &&
        GetUtils.isEmail(email) &&
        pass.length >= 6 &&
        pass == confirm;
  }

  /// ------------------------------
  /// Registro
  /// ------------------------------
  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      isLoading.value = true;
      final newUser = await _firebaseService.registerWithEmail(
        name: name,
        email: email,
        password: password,
      );
      if (newUser != null) {
        _onSuccessfulAuth(newUser);
      }
    } on FirebaseServiceException catch (e) {
      Get.snackbar(
        'Registro Fallido',
        e.message,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// ------------------------------
  /// Login
  /// ------------------------------
  Future<void> login({required String email, required String password}) async {
    try {
      isLoading.value = true;
      final loggedInUser = await _firebaseService.loginWithEmail(
        email: email,
        password: password,
      );
      if (loggedInUser != null) {
        _onSuccessfulAuth(loggedInUser, password: password);
      }
    } on FirebaseServiceException catch (e) {
      Get.snackbar(
        'Login Fallido',
        e.message,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// ------------------------------
  /// Logout
  /// ------------------------------
  Future<void> signOut() async {
    await _firebaseService.signOut();
    await _clearCredentials();
    userModel.value = null;
    Get.offAllNamed(AppRoutes.login);
    Get.snackbar(
      'Sesión cerrada',
      'Hasta pronto',
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  /// ------------------------------
  /// Recuperar contraseña
  /// ------------------------------
  Future<void> recoverPassword(String email) async {
    try {
      isLoading.value = true;
      await _firebaseService.sendPasswordResetEmail(email);
      // Vuelve al login y muestra el snackbar
      Get.offAllNamed(AppRoutes.login);
      Get.snackbar(
        'Correo enviado',
        'Revisa tu bandeja para recuperar la contraseña',
        snackPosition: SnackPosition.TOP,
      );
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// ------------------------------
  /// Helpers
  /// ------------------------------

  void _onSuccessfulAuth(UserModel u, {String? password}) {
    userModel.value = u;
    _saveCredentials(u.email, password); // guarda email; password opcional
    Get.offAllNamed(AppRoutes.inicio);
    Get.snackbar(
      'Bienvenido',
      'Hola ${u.name}',
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  Future<void> _saveCredentials(String email, String? password) async {
    _storage.write('email', email);
    if (password != null) _storage.write('password', password);
  }

  Future<void> _clearCredentials() async {
    _storage.remove('email');
    _storage.remove('password');
  }

  Future<void> _autoLogin() async {
    final String? email = _storage.read('email');
    final String? password = _storage.read('password');
    if (email != null && password != null) {
      await login(email: email, password: password);
    }
  }

  /// ------------------------------
  /// Google Sign-In
  /// ------------------------------
  Future<void> loginWithGoogle() async {
    try {
      isLoading.value = true;
      final user = await _firebaseService.signInWithGoogle();
      _onSuccessfulAuth(user);
    } on FirebaseServiceException catch (e) {
      Get.snackbar(
        'Google Sign-In Fallido',
        e.message,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
