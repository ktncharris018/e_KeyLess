import 'package:e_notepad/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordPage extends StatelessWidget {
  final emailCtrl = TextEditingController();
  final authCtrl = Get.find<AuthController>();
  final _formKey = GlobalKey<FormState>();

  ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recuperar Contraseña')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 40),
              Text(
                '¿Olvidaste tu contraseña?',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: emailCtrl,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Correo electrónico',
                  prefixIcon: Icon(Icons.email_outlined),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingresa tu correo';
                  }
                  if (!GetUtils.isEmail(value)) {
                    return 'Correo no válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              Obx(
                () => ElevatedButton(
                  onPressed:
                      authCtrl.isLoading.value
                          ? null
                          : () {
                            if (_formKey.currentState!.validate()) {
                              authCtrl.recoverPassword(emailCtrl.text.trim());
                            }
                          },
                  child:
                      authCtrl.isLoading.value
                          ? const CircularProgressIndicator()
                          : const Text('Enviar enlace de recuperación'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
