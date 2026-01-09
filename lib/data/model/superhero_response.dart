import 'package:superhero_app/data/model/superhero_detail_response.dart';

/// Clase que representa la respuesta principal de la API de búsqueda de superhéroes.
class SuperheroResponse {
  /// Estado de la respuesta (success o error)
  final String response;

  /// Lista de superhéroes encontrados (puede ser null si la respuesta es error)
  final List<SuperheroDetailResponse>? results;

  SuperheroResponse({required this.response, this.results});

  /// Crea una instancia de SuperheroResponse a partir de un mapa JSON.
  factory SuperheroResponse.fromJson(Map<String, dynamic> json) {
    // Verificar si results existe en la respuesta (la API devuelve error sin este campo)
    if (json['results'] != null) {
      var list = json['results'] as List;
      List<SuperheroDetailResponse> heroList = list
          .map((hero) => SuperheroDetailResponse.fromJson(hero))
          .toList();
      return SuperheroResponse(response: json['response'], results: heroList);
    } else {
      // Si no hay resultados, devolvemos success con lista nula
      return SuperheroResponse(response: json['response'], results: null);
    }
  }
}
