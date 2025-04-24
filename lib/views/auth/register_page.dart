import 'package:e_notepad/controllers/auth_controller.dart';
import 'package:e_notepad/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPage extends StatelessWidget {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final confirmCtrl = TextEditingController();
  final nameCtrl = TextEditingController();
  final authCtrl = Get.find<AuthController>();
  final _formKey = GlobalKey<FormState>();

  RegisterPage({super.key});

  void _validate() {
    authCtrl.validateRegisterForm(
      name: nameCtrl.text,
      email: emailCtrl.text,
      pass: passCtrl.text,
      confirm: confirmCtrl.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            //height: size.height,
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new),
                      onPressed: () => Get.back(),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Hero Logo
                  Center(
                    child: Hero(
                      tag: 'logo',
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: ColorUtils.applyOpacity(
                            Theme.of(context).colorScheme.primary,
                            0.1,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Icon(
                          Icons.note_alt_outlined,
                          size: 60,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  Text(
                    'Crear cuenta',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Únete a e-KeyLess',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 40),

                  TextFormField(
                    controller: nameCtrl,
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                    decoration: const InputDecoration(
                      labelText: 'Nombre completo',
                      hintText: 'Ej: Juan Pérez',
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                    onChanged: (_) => _validate(),
                    validator:
                        (value) =>
                            value == null || value.isEmpty
                                ? 'Por favor ingresa tu nombre'
                                : null,
                  ),
                  const SizedBox(height: 20),

                  TextFormField(
                    controller: emailCtrl,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Correo electrónico',
                      hintText: 'usuario@ejemplo.com',
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                    onChanged: (_) => _validate(),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingresa tu correo';
                      }
                      if (!GetUtils.isEmail(value)) {
                        return 'Ingresa un correo válido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  Obx(
                    () => TextFormField(
                      controller: passCtrl,
                      obscureText: !authCtrl.isPasswordVisible.value,
                      onChanged: (_) => _validate(),
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
                          return 'Por favor ingresa una contraseña';
                        }
                        if (value.length < 6) {
                          return 'Debe tener al menos 6 caracteres';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),

                  Obx(
                    () => TextFormField(
                      controller: confirmCtrl,
                      obscureText: !authCtrl.isPasswordVisible.value,
                      onChanged: (_) => _validate(),
                      decoration: const InputDecoration(
                        labelText: 'Confirmar contraseña',
                        hintText: '••••••••',
                        prefixIcon: Icon(Icons.lock_outline),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Confirma tu contraseña';
                        }
                        if (value != passCtrl.text) {
                          return 'Las contraseñas no coinciden';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 40),

                  Obx(
                    () => ElevatedButton(
                      onPressed:
                          authCtrl.isFormValid.value &&
                                  !authCtrl.isLoading.value
                              ? () {
                                if (_formKey.currentState!.validate()) {
                                  authCtrl.register(
                                    name: nameCtrl.text.trim(),
                                    email: emailCtrl.text.trim(),
                                    password: passCtrl.text.trim(),
                                  );
                                }
                              } // <- Ahora con bloque de llaves
                              : null,
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
                              : const Text('Crear mi cuenta'),
                    ),
                  ),
                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '¿Ya tienes una cuenta?',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text('Iniciar sesión'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  Center(
                    child: Text(
                      'Al registrarte, aceptas nuestros términos de servicio\ny política de privacidad',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
