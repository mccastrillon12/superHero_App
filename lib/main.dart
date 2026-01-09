import 'package:flutter/material.dart';
import 'package:superhero_app/screens/superhero_search_screen.dart';

/// Punto de entrada de la aplicación de Superhéroes.
void main() {
  runApp(const MyApp());
}

/// Clase raíz de la aplicación.
///
/// Define la configuración global como el tema y la pantalla inicial.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Superhero App',
      debugShowCheckedModeBanner: false,
      // Configuración de un tema oscuro moderno y elegante
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
      ),
      home: const SuperheroSearchScreen(),
    );
  }
}
