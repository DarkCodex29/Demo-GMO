import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class LocationsPage extends StatefulWidget {
  const LocationsPage({super.key});

  @override
  _LocationsPageState createState() => _LocationsPageState();
}

class _LocationsPageState extends State<LocationsPage> {
  List<Map<String, dynamic>> locations = [];
  List<Map<String, dynamic>> filteredLocations = [];

  @override
  void initState() {
    super.initState();
    _loadLocations();
  }

  // Método para cargar los datos desde el archivo JSON
  Future<void> _loadLocations() async {
    final String response =
        await rootBundle.loadString('assets/data/locations.json');
    final data = await json.decode(response);
    setState(() {
      locations = List<Map<String, dynamic>>.from(data['ubicaciones']);
      filteredLocations = []; // Inicialmente no se muestra nada
    });
  }

  // Método para filtrar las ubicaciones técnicas
  void _filterLocations(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredLocations = [];
      });
    } else {
      setState(() {
        filteredLocations = locations
            .where((location) =>
                location['ubicacion']
                    .toString()
                    .toLowerCase()
                    .contains(query.toLowerCase()) ||
                location['descripcion']
                    .toString()
                    .toLowerCase()
                    .contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ubicaciones Técnicas'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Card con TextField para la búsqueda
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: _filterLocations,
                  decoration: const InputDecoration(
                    hintText: 'Buscar ubicación...',
                    prefixIcon: Icon(Icons.search),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            // Mostrar la lista filtrada
            Expanded(
              child: filteredLocations.isEmpty
                  ? const Center(child: Text('No hay resultados.'))
                  : ListView.builder(
                      itemCount: filteredLocations.length,
                      itemBuilder: (context, index) {
                        final location = filteredLocations[index];
                        return Card(
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ListTile(
                            title: Text('Ubicación: ${location['ubicacion']}'),
                            subtitle: Text(location['descripcion']),
                            trailing: const Icon(Icons.arrow_forward),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      LocationDetailPage(location: location),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class LocationDetailPage extends StatelessWidget {
  final Map<String, dynamic> location;

  const LocationDetailPage({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles de ${location['ubicacion']}'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailTile('Ubicación Técnica', location['ubicacion']),
            _buildDetailTile('Máscara Codificación', location['mascCodif']),
            _buildDetailTile('Niv. Jerárquicos', location['nivJerarquicos']),
            _buildDetailTile('Ind. Estructura', location['indEstructura']),
            _buildDetailTile('Descripción', location['descripcion']),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailTile(String title, String value) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(value),
      ),
    );
  }
}
