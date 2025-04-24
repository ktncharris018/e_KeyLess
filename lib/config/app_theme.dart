import 'package:e_notepad/utils/color_utils.dart';
import 'package:flutter/material.dart';

class AppTheme {
  // Colores principales utilizados en toda la aplicación
  static const Color primaryColor = Colors.blue;
  static const Color secondaryColor = Colors.blueAccent;

  /// Define el tema claro de la aplicación
  static ThemeData get lightTheme {
    return ThemeData(
      // Habilita Material Design 3
      useMaterial3: true,

      // Define el esquema de colores para el tema claro
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor, // Color semilla para generar la paleta
        brightness: Brightness.light,
        primary: primaryColor, // Color principal para elementos destacados
        secondary: secondaryColor, // Color secundario para acciones o detalles
        surface: Colors.white, // Color de fondo para tarjetas y superficies
        onPrimary: Colors.white, // Color de texto sobre el color primario
        onSurface: Colors.black87, // Color de texto sobre superficies
      ),

      // Color de fondo para la pantalla principal
      scaffoldBackgroundColor: Colors.grey[50],

      // Estilo de la barra de aplicación (AppBar)
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent, // Barra transparente
        foregroundColor: Colors.black87, // Color del texto e iconos
        elevation: 0, // Sin sombra
        centerTitle: true, // Título centrado
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: secondaryColor, // Color de título destacado
        ),
      ),

      // Estilo para botones elevados (principal CTA)
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor, // Fondo del botón
          foregroundColor: Colors.white, // Color del texto
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15), // Bordes redondeados
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 14,
          ), // Espaciado interno
          elevation: 2, // Sombra ligera
          minimumSize: const Size(
            double.infinity,
            55,
          ), // Tamaño mínimo para buena área de toque
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5, // Ligero espaciado entre letras
          ),
        ),
      ),

      // Estilo para botones de texto (acciones secundarias)
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryColor, // Color del texto
          textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
      ),

      // Estilo para campos de texto y formularios
      inputDecorationTheme: InputDecorationTheme(
        filled: true, // Fondo relleno
        fillColor: Colors.white, // Color de fondo
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16, // Buen espaciado para facilitar la interacción
        ),
        // Borde normal
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        // Borde cuando el campo está habilitado pero no enfocado
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: ColorUtils.applyOpacity(primaryColor, 0.3), // Borde sutil
          ),
        ),
        // Borde cuando el campo está enfocado
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: primaryColor,
            width: 2,
          ), // Borde destacado
        ),
        // Borde cuando hay un error
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.red[400]!, width: 1.5),
        ),
        // Borde cuando hay un error y está enfocado
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.red[700]!, width: 2),
        ),
        // Estilos para etiquetas, sugerencias e iconos
        labelStyle: TextStyle(color: Colors.grey[700]),
        hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
        prefixIconColor: primaryColor,
        suffixIconColor: primaryColor,
        errorStyle: TextStyle(color: Colors.red[700], fontSize: 12),
      ),

      // Estilos de texto para toda la aplicación
      textTheme: const TextTheme(
        // Títulos principales y pantallas de introducción
        displayLarge: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
        // Títulos de sección
        displayMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
        // Subtítulos importantes
        headlineMedium: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
        // Texto principal de la aplicación
        bodyLarge: TextStyle(fontSize: 16, color: Colors.black87),
        // Texto secundario y descripciones
        bodyMedium: TextStyle(fontSize: 14, color: Colors.black87),
        // Texto para botones y elementos interactivos
        labelLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),

      // Estilo para indicadores de progreso
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: primaryColor, // Color de carga
      ),

      // Estilo para tarjetas
      cardTheme: CardTheme(
        elevation: 2, // Sombra sutil
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ), // Bordes redondeados
        color: Colors.white, // Fondo blanco
      ),

      // Estilo para botón flotante
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 4, // Sombra más pronunciada para destacar
      ),

      // Estilo para notificaciones SnackBar
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating, // Mostrar flotando
        backgroundColor: Colors.grey[800],
        contentTextStyle: const TextStyle(color: Colors.white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),

      // Estilo para diálogos
      dialogTheme: DialogTheme(
        backgroundColor: Colors.white,
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        titleTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),

      // Estilo para chips (etiquetas)
      chipTheme: ChipThemeData(
        backgroundColor: Colors.grey[100],
        selectedColor: ColorUtils.applyOpacity(primaryColor, 0.2),
        labelStyle: const TextStyle(fontSize: 14),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),

      // Estilo para selectores (dropdowns)
      dropdownMenuTheme: DropdownMenuThemeData(
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
        ),
      ),

      // Estilo para divisores
      dividerTheme: DividerThemeData(
        color: Colors.grey[300],
        thickness: 1,
        space: 20,
      ),

      // Estilo para interruptores (switches)
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return primaryColor;
          }
          return Colors.grey[400];
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return ColorUtils.applyOpacity(primaryColor, 0.4);
          }
          return Colors.grey[300];
        }),
      ),

      // Estilo para sliders
      sliderTheme: SliderThemeData(
        activeTrackColor: primaryColor,
        inactiveTrackColor: Colors.grey[300],
        thumbColor: primaryColor,
        overlayColor: ColorUtils.applyOpacity(primaryColor, 0.2),
      ),

      // Estilo para BottomSheet
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
      ),
    );
  }

  /// Define el tema oscuro de la aplicación
  static ThemeData get darkTheme {
    return ThemeData(
      // Habilita Material Design 3
      useMaterial3: true,

      // Define el esquema de colores para el tema oscuro
      // CORREGIDO: Se eliminó 'background' y 'onBackground' (depreciados)
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: Brightness.dark,
        primary: primaryColor,
        secondary: secondaryColor,
        surface: const Color(0xFF1E1E1E), // Superficie oscura
        // Ya no se usa background (depreciado)
        onPrimary: Colors.white,
        onSurface: ColorUtils.applyOpacity(Colors.white, 0.87),
        // Ya no se usa onBackground (depreciado)
      ),

      // Color de fondo para la pantalla principal
      scaffoldBackgroundColor: const Color(0xFF121212),

      // Estilo de la barra de aplicación (AppBar)
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: ColorUtils.applyOpacity(Colors.white, 0.87),
        elevation: 0,
        centerTitle: true,
        titleTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: secondaryColor,
        ),
      ),

      // Estilo para botones elevados (principal CTA)
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          elevation: 4, // Mayor elevación para destacar en fondo oscuro
          minimumSize: const Size(double.infinity, 55),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ),

      // Estilo para botones de texto (acciones secundarias)
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: ColorUtils.applyOpacity(
            primaryColor,
            0.9,
          ), // Ligeramente más brillante
          textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
      ),

      // Estilo para campos de texto y formularios
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(
          0xFF2A2A2A,
        ), // Fondo más claro que el fondo principal
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.grey[700]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: ColorUtils.applyOpacity(primaryColor, 0.5),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.red[400]!, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.red[400]!, width: 2),
        ),
        labelStyle: TextStyle(color: Colors.grey[400]),
        hintStyle: TextStyle(color: Colors.grey[600], fontSize: 14),
        prefixIconColor: ColorUtils.applyOpacity(primaryColor, 0.9),
        suffixIconColor: ColorUtils.applyOpacity(primaryColor, 0.9),
        errorStyle: TextStyle(color: Colors.red[400], fontSize: 12),
      ),

      // Estilos de texto para toda la aplicación
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: ColorUtils.applyOpacity(Colors.white, 0.9),
        ),
        displayMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: ColorUtils.applyOpacity(Colors.white, 0.9),
        ),
        headlineMedium: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: ColorUtils.applyOpacity(Colors.white, 0.9),
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          color: ColorUtils.applyOpacity(Colors.white, 0.87),
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: ColorUtils.applyOpacity(Colors.white, 0.87),
        ),
        labelLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: ColorUtils.applyOpacity(Colors.white, 0.9),
        ),
      ),

      // Estilo para indicadores de progreso
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: primaryColor,
      ),

      // Estilo para tarjetas
      cardTheme: CardTheme(
        elevation: 4, // Mayor elevación para destacar en fondo oscuro
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: const Color(0xFF2A2A2A), // Superficie más clara que el fondo
      ),

      // Estilo para botón flotante
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 6, // Mayor elevación para destacar en fondo oscuro
      ),

      // Estilo para notificaciones SnackBar
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xFF333333),
        contentTextStyle: TextStyle(
          color: ColorUtils.applyOpacity(Colors.white, 0.9),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),

      // Estilo para diálogos
      dialogTheme: DialogTheme(
        backgroundColor: const Color(0xFF2A2A2A),
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: ColorUtils.applyOpacity(Colors.white, 0.9),
        ),
      ),

      // Estilo para chips (etiquetas)
      chipTheme: ChipThemeData(
        backgroundColor: const Color(0xFF333333),
        selectedColor: ColorUtils.applyOpacity(primaryColor, 0.3),
        labelStyle: TextStyle(
          fontSize: 14,
          color: ColorUtils.applyOpacity(Colors.white, 0.9),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),

      // Estilo para selectores (dropdowns)
      dropdownMenuTheme: DropdownMenuThemeData(
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF2A2A2A),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.grey[700]!),
          ),
        ),
      ),

      // Estilo para divisores
      dividerTheme: DividerThemeData(
        color: Colors.grey[700],
        thickness: 1,
        space: 20,
      ),

      // Estilo para interruptores (switches)
      // CORREGIDO: Reemplazado MaterialStateProperty por WidgetStateProperty
      // CORREGIDO: Reemplazado MaterialState por WidgetState
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return primaryColor;
          }
          return Colors.grey[400];
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            // CORREGIDO: Reemplazado withOpacity por ColorUtils.applyOpacity
            return ColorUtils.applyOpacity(primaryColor, 0.4);
          }
          return Colors.grey[700];
        }),
      ),

      // Estilo para sliders
      sliderTheme: SliderThemeData(
        activeTrackColor: primaryColor,
        inactiveTrackColor: Colors.grey[700],
        thumbColor: primaryColor,
        overlayColor: ColorUtils.applyOpacity(primaryColor, 0.2),
      ),

      // Estilo para BottomSheet
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
      ),
    );
  }
}
