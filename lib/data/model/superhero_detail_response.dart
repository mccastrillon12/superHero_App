/// Modelo que representa los detalles básicos de un superhéroe.
class SuperheroDetailResponse {
  /// Identificador único del superhéroe
  final String id;

  /// Nombre del superhéroe
  final String name;

  SuperheroDetailResponse({required this.id, required this.name});

  /// Crea una instancia a partir de un fragmento del JSON
  factory SuperheroDetailResponse.fromJson(Map<String, dynamic> json) {
    return SuperheroDetailResponse(id: json['id'], name: json['name']);
  }
}
