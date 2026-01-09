import 'package:flutter/material.dart';
import 'package:superhero_app/data/model/superhero_response.dart';
import 'package:superhero_app/data/repository.dart';

/// Pantalla principal para buscar superhéroes por nombre.
///
/// Permite al usuario escribir en un buscador y obtener resultados en tiempo real.
class SuperheroSearchScreen extends StatefulWidget {
  const SuperheroSearchScreen({super.key});

  @override
  State<SuperheroSearchScreen> createState() => _SuperheroSearchScreenState();
}

/// Estado de la pantalla de búsqueda.
///
/// Maneja la lógica de la llamada al repositorio y el control de la visualización inicial.
class _SuperheroSearchScreenState extends State<SuperheroSearchScreen> {
  // Future que contiene la información de la API
  Future<SuperheroResponse?>? _superheroInfo;

  // Instancia del repositorio para obtener datos
  final Repository repository = Repository();

  // Flag para saber si hay una búsqueda activa (evita mostrar resultados viejos al borrar)
  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Superhero Search'), centerTitle: true),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Buscar superhéroe...',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (text) {
                setState(() {
                  if (text.trim().isEmpty) {
                    // Si el texto está vacío, resetear el estado completamente
                    _superheroInfo = null;
                    _isSearching = false;
                  } else {
                    // Solo buscar si hay texto
                    _isSearching = true;
                    _superheroInfo = repository.fetchSuperheroInfo(text);
                  }
                });
              },
            ),
          ),
          Expanded(
            child: FutureBuilder<SuperheroResponse?>(
              future: _superheroInfo,
              builder: (context, snapshot) {
                // Si no hay búsqueda activa, mostrar pantalla inicial
                if (!_isSearching) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search, size: 48, color: Colors.grey),
                        SizedBox(height: 16),
                        Text('Escribe para buscar superhéroes'),
                      ],
                    ),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          size: 48,
                          color: Colors.red,
                        ),
                        const SizedBox(height: 16),
                        Text('Error: ${snapshot.error}'),
                      ],
                    ),
                  );
                } else if (snapshot.hasData) {
                  final superheroResponse = snapshot.data!;

                  // Verificar si la API devolvió un error (no encontró resultados)
                  if (superheroResponse.response == 'error') {
                    return const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search_off, size: 48, color: Colors.grey),
                          SizedBox(height: 16),
                          Text('No se encontraron superhéroes'),
                        ],
                      ),
                    );
                  }

                  // Verificar que results no sea null
                  if (superheroResponse.results == null ||
                      superheroResponse.results!.isEmpty) {
                    return const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search_off, size: 48, color: Colors.grey),
                          SizedBox(height: 16),
                          Text('No se encontraron superhéroes'),
                        ],
                      ),
                    );
                  }

                  // Mostrar la lista de héroes
                  return ListView.builder(
                    itemCount: superheroResponse.results!.length,
                    itemBuilder: (context, index) {
                      final hero = superheroResponse.results![index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        child: ListTile(
                          leading: CircleAvatar(child: Text(hero.name[0])),
                          title: Text(
                            hero.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text('ID: ${hero.id}'),
                          trailing: const Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            // Aquí puedes navegar a una pantalla de detalles
                            print('Tapped on ${hero.name}');
                          },
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search, size: 48, color: Colors.grey),
                        SizedBox(height: 16),
                        Text('Escribe para buscar superhéroes'),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
