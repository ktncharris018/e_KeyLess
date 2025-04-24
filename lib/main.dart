//importaciones de tema y estilos
import 'package:e_notepad/config/app_theme.dart';
import 'package:flutter/material.dart';
//importaciones de Firebase
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'config/firebase_options.dart';
//importaciones de rutas y configuraciones
import 'package:e_notepad/bindings/initial_binding.dart';
import 'package:e_notepad/routes/app_routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await GetStorage.init(); // Inicializa almacenamiento local
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'e-NotePad',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialBinding: InitialBinding(),
      initialRoute: AppRoutes.login,
      getPages: AppRoutes.routes,
    );
  }
}
