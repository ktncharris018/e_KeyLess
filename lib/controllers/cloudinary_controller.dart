import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:e_notepad/controllers/auth_controller.dart';
import 'package:e_notepad/services/firebase_service.dart';
import 'package:e_notepad/services/cloudinary_service.dart';

class CloudinaryController extends GetxController {
  final AuthController authCtrl = Get.find<AuthController>();
  final FirebaseService _firebaseService = FirebaseService();
  final CloudinaryService _cloudinary = CloudinaryService(
    cloudName: 'die9v4pbj',
    uploadPreset: 'enotepad',
  );
  final ImagePicker _picker = ImagePicker();
  var isUploading = false.obs;

  Future<void> pickAndUploadProfile(ImageSource source) async {
    final XFile? picked = await _picker.pickImage(source: source);
    if (picked == null) return;

    final Uint8List bytes = await picked.readAsBytes();
    isUploading.value = true;

    try {
      final String url = await _cloudinary.uploadImage(bytes, picked.name);

      // Actualizar Firestore con nueva URL
      await _firebaseService.updateUserProfile(imagenPerfil: url);

      // Refrescar modelo local
      final updated = authCtrl.userModel.value!.copyWith(imagenPerfil: url);
      authCtrl.userModel.value = updated;

      Get.snackbar('Éxito', 'Imagen de perfil actualizada');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isUploading.value = false;
    }
  }
}
