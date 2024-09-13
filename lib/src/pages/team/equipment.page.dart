import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class EquipmentPage extends StatefulWidget {
  const EquipmentPage({super.key});

  @override
  _EquipmentPageState createState() => _EquipmentPageState();
}

class _EquipmentPageState extends State<EquipmentPage> {
  List<Map<String, dynamic>> equipments = [];
  List<Map<String, dynamic>> filteredEquipments = [];
  Map<String, dynamic>? selectedEquipment;

  @override
  void initState() {
    super.initState();
    _loadEquipments();
  }

  Future<void> _loadEquipments() async {
    final String response =
        await rootBundle.loadString('assets/data/equipament.json');
    final data = await json.decode(response);
    setState(() {
      equipments = List<Map<String, dynamic>>.from(data['equipos']);
      filteredEquipments = []; // Inicialmente vacío
    });
  }

  void _filterEquipments(String query) {
    setState(() {
      filteredEquipments = equipments
          .where((equipment) =>
              equipment['equipo']
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              equipment['descripcion']
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Equipos'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Buscador
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: _filterEquipments,
                  decoration: const InputDecoration(
                    hintText: 'Buscar equipo...',
                    prefixIcon: Icon(Icons.search),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            // Lista de resultados
            Expanded(
              child: filteredEquipments.isEmpty
                  ? const Center(child: Text('No hay resultados.'))
                  : ListView.builder(
                      itemCount: filteredEquipments.length,
                      itemBuilder: (context, index) {
                        final equipment = filteredEquipments[index];
                        return Card(
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ListTile(
                            title: Text('Equipo: ${equipment['equipo']}'),
                            subtitle: Text(equipment['descripcion']),
                            trailing: const Icon(Icons.arrow_forward),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      EquipmentDetailPage(equipment: equipment),
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

class EquipmentDetailPage extends StatelessWidget {
  final Map<String, dynamic> equipment;

  const EquipmentDetailPage({super.key, required this.equipment});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles del Equipo ${equipment['equipo']}'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildDetailTile('Equipo', equipment['equipo']),
            _buildDetailTile('Descripción', equipment['descripcion']),
            _buildDetailTile('Estado', equipment['estado']),
            const SizedBox(height: 16.0),
            const Text(
              'General',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            _buildDetailTile('Tipo', equipment['general']['tipo']),
            _buildDetailTile('Clase', equipment['general']['clase']),
            _buildDetailTile('Grupo Autorización',
                equipment['general']['grupo_autorizacion']),
            _buildDetailTile('Peso', equipment['general']['peso']),
            _buildDetailTile(
                'Nro Inventario', equipment['general']['nro_inventario']),
            const SizedBox(height: 16.0),
            const Text(
              'Emplazamiento',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            _buildDetailTile(
                'Centro Emplazamiento', equipment['emplazamiento']['centro']),
            _buildDetailTile(
                'Emplazamiento', equipment['emplazamiento']['emplazamiento']),
            const SizedBox(height: 16.0),
            const Text(
              'Organización',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            _buildDetailTile('Sociedad', equipment['organizacion']['sociedad']),
            _buildDetailTile(
                'Activo Fijo', equipment['organizacion']['activo_fijo']),
            _buildDetailTile(
                'Centro Coste', equipment['organizacion']['centro_coste']),
            const SizedBox(height: 16.0),
            const Text(
              'Estructura',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            _buildDetailTile('Ubicación Técnica',
                equipment['estructura']['ubicacion_tecnica']),
            _buildDetailTile(
                'Denominación', equipment['estructura']['denominacion']),
            const SizedBox(height: 16.0),
            const Text(
              'Garantías',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            _buildDetailTile(
                'Inicio Garantía', equipment['garantias']['inicio_garantia']),
            _buildDetailTile(
                'Fin Garantía', equipment['garantias']['fin_garantia']),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailTile(String title, String? value) {
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
        subtitle: Text(value ?? 'N/A'),
      ),
    );
  }
}
