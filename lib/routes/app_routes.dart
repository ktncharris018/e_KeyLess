import 'package:e_notepad/views/auth/forgot_password.dart';
import 'package:e_notepad/views/auth/login_page.dart';
import 'package:e_notepad/views/auth/register_page.dart';
import 'package:e_notepad/views/home.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const String login = '/login';
  static const String forgotPassword = '/forgot-password';
  static const String register = '/register';
  static const String inicio = '/';

  static final routes = [
    GetPage(name: login, page: () => LoginPage()),
    GetPage(name: forgotPassword, page: () => ForgotPasswordPage()),
    GetPage(name: register, page: () => RegisterPage()),
    GetPage(name: inicio, page: () => const Home()),
  ];
}