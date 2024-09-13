import 'package:flutter/material.dart';

class MaterialsPage extends StatelessWidget {
  const MaterialsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Materiales'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildMaterialTile('Material 1', '14110006', 'Celda Carga 1000 KG'),
            _buildMaterialTile(
                'Material 2', '14110007', 'Motor Principal 500 KW'),
          ],
        ),
      ),
    );
  }

  Widget _buildMaterialTile(String name, String code, String description) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        title: Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Código: $code'),
            Text('Descripción: $description'),
          ],
        ),
      ),
    );
  }
}
