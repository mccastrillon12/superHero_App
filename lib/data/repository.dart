import 'package:dio/dio.dart';
import 'package:superhero_app/core/api_constants.dart';
import 'package:superhero_app/data/model/superhero_response.dart';

/// Clase encargada de manejar la comunicación con la API de Superhéroes.
///
/// Implementa el patrón Repositorio para separar la lógica de datos de la UI.
class Repository {
  // Cliente Dio configurado con un timeout de 10 segundos
  final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  /// Obtiene la información de los superhéroes que coinciden con el [name].
  ///
  /// Lanza una excepción si la petición falla o si hay un error de red.
  Future<SuperheroResponse> fetchSuperheroInfo(String name) async {
    try {
      final response = await _dio.get(ApiConstants.searchEndpoint(name));

      if (response.statusCode == 200) {
        // Dio decodifica automáticamente el JSON si el Content-Type es correcto
        return SuperheroResponse.fromJson(response.data);
      } else {
        throw Exception('Error del servidor: ${response.statusCode}');
      }
    } on DioException catch (e) {
      // Manejo específico de errores de Dio (red, timeout, etc)
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('Tiempo de conexión agotado. Revisa tu internet.');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception('El servidor está tardando demasiado en responder.');
      } else {
        throw Exception('Error de red: ${e.message}');
      }
    } catch (e) {
      // Otros errores inesperados
      throw Exception('Error inesperado: $e');
    }
  }
}
