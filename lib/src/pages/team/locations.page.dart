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
  Map<String, dynamic>? selectedLocation;

  @override
  void initState() {
    super.initState();
    _loadLocations();
  }

  Future<void> _loadLocations() async {
    final String response =
        await rootBundle.loadString('assets/data/locations.json');
    final data = await json.decode(response);
    setState(() {
      locations = List<Map<String, dynamic>>.from(data['ubicaciones']);
    });
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Autocomplete<Map<String, dynamic>>(
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    if (textEditingValue.text.isEmpty) {
                      return const Iterable<Map<String, dynamic>>.empty();
                    }
                    return locations.where((Map<String, dynamic> location) {
                      return location['ubicacion']
                          .toLowerCase()
                          .contains(textEditingValue.text.toLowerCase());
                    });
                  },
                  displayStringForOption: (Map<String, dynamic> option) =>
                      option['ubicacion'],
                  onSelected: (Map<String, dynamic> selection) {
                    setState(() {
                      selectedLocation = selection;
                    });
                  },
                  fieldViewBuilder: (context, textEditingController, focusNode,
                      onFieldSubmitted) {
                    return TextField(
                      controller: textEditingController,
                      focusNode: focusNode,
                      decoration: const InputDecoration(
                        hintText: 'Buscar ubicación...',
                        prefixIcon: Icon(Icons.search),
                        border: InputBorder.none,
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView(
                children: <Widget>[
                  _buildCard(context, 'Ubicación Técnica', Icons.place),
                  _buildCard(context, 'Máscara Codificación', Icons.code),
                  _buildCard(context, 'Niveles Jerárquicos', Icons.layers),
                  _buildCard(context, 'Indicador Estructura', Icons.info),
                  _buildCard(context, 'Descripción', Icons.description),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, String title, IconData icon) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.orange),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward),
        onTap: () {
          if (selectedLocation != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LocationDetailPage(
                  title: title,
                  locationData: selectedLocation!,
                ),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Por favor, selecciona una ubicación.'),
              ),
            );
          }
        },
      ),
    );
  }
}

class LocationDetailPage extends StatelessWidget {
  final String title;
  final Map<String, dynamic> locationData;

  const LocationDetailPage(
      {super.key, required this.title, required this.locationData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Detalles de $title',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
            const SizedBox(height: 16),
            if (title == 'Ubicación Técnica') ...[
              _buildDetailTile('Ubicación Técnica', locationData['ubicacion']),
            ],
            if (title == 'Máscara Codificación') ...[
              _buildDetailTile(
                  'Máscara Codificación', locationData['mascCodif']),
            ],
            if (title == 'Niveles Jerárquicos') ...[
              _buildDetailTile(
                  'Niv. Jerárquicos', locationData['nivJerarquicos']),
            ],
            if (title == 'Indicador Estructura') ...[
              _buildDetailTile(
                  'Ind. Estructura', locationData['indEstructura']),
            ],
            if (title == 'Descripción') ...[
              _buildDetailTile('Descripción', locationData['descripcion']),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDetailTile(String title, String? content) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(content ?? 'N/A'),
      ),
    );
  }
}
