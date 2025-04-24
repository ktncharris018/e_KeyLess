import 'package:e_notepad/controllers/auth_controller.dart';
import 'package:e_notepad/controllers/cloudinary_controller.dart';
import 'package:get/get.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // Controlador de autenticación y usuario
    Get.lazyPut<AuthController>(() => AuthController(), fenix: true);
    // Controlador de Cloudinary para subir imágenes
    Get.lazyPut<CloudinaryController>(() => CloudinaryController(), fenix: true);
  }
}