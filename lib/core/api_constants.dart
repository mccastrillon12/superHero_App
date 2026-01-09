/// Clase que centraliza todas las constantes relacionadas con la API de Superhéroes.
///
/// Esto permite cambiar fácilmente la URL base o el token en un solo lugar.
class ApiConstants {
  /// URL base de la SuperHero API
  static const String baseUrl = 'https://superheroapi.com/api';

  /// Token de acceso para la API (considerar mover a un archivo .env en producción)
  static const String accessToken = '478d8d67766239a25ce3d719cd28e0cc';

  /// Retorna la URL completa para el endpoint de búsqueda por nombre
  static String searchEndpoint(String name) =>
      '$baseUrl/$accessToken/search/$name';
}
