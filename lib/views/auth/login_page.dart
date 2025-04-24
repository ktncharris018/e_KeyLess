import 'package:e_notepad/controllers/auth_controller.dart';
import 'package:e_notepad/routes/app_routes.dart';
import 'package:e_notepad/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final authCtrl = Get.find<AuthController>();
  final _formKey = GlobalKey<FormState>();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: size.height,
            width: size.width,
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),

                  // Logo de la app
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: ColorUtils.applyOpacity(
                            Theme.of(context).colorScheme.primary,
                            0.1,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      Icon(
                        Icons.note_alt_outlined,
                        size: 60,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),

                  // Título
                  Text(
                    'e-KeyLess',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Tú telefono es la unica llave que necesitas',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 50),

                  // Campo de correo
                  TextFormField(
                    controller: emailCtrl,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Correo electrónico',
                      hintText: 'usuario@ejemplo.com',
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingresa tu correo';
                      }
                      if (!GetUtils.isEmail(value)) {
                        return 'Correo inválido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Campo de contraseña con visibilidad
                  Obx(
                    () => TextFormField(
                      controller: passCtrl,
                      obscureText: !authCtrl.isPasswordVisible.value,
                      decoration: InputDecoration(
                        labelText: 'Contraseña',
                        hintText: '••••••••',
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: Icon(
                            authCtrl.isPasswordVisible.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () => authCtrl.togglePasswordVisibility(),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingresa tu contraseña';
                        }
                        return null;
                      },
                    ),
                  ),

                  // Recuperar contraseña
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => Get.toNamed(AppRoutes.forgotPassword),
                      child: const Text('¿Olvidaste tu contraseña?'),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Botón login correo
                  Obx(
                    () => ElevatedButton(
                      onPressed:
                          authCtrl.isLoading.value
                              ? null
                              : () {
                                if (_formKey.currentState!.validate()) {
                                  authCtrl.login(
                                    email: emailCtrl.text.trim(),
                                    password: passCtrl.text.trim(),
                                  );
                                }
                              },
                      child:
                          authCtrl.isLoading.value
                              ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                              : const Text('Acceder'),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Separador
                  Text(
                    'o continúa con',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 15),

                  // Botón Google Sign-In usando sign_in_button (GoogleDark)
                  Obx(
                    () => ElevatedButton.icon(
                      onPressed:
                          authCtrl.isLoading.value
                              ? null
                              : authCtrl.loginWithGoogle,
                      icon: Image.asset(
                        'assets/google_logo.png',
                        height: 24, // escala desde 100px original
                      ),
                      label: const Text('Continuar con Google'),
                    ),
                  ),

                  const Spacer(),

                  // Registro
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '¿Nuevo en e-KeyLess?',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      TextButton(
                        onPressed: () => Get.toNamed(AppRoutes.register),
                        child: const Text('Crear cuenta'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
