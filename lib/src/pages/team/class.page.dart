import 'package:flutter/material.dart';

class ClasesPage extends StatefulWidget {
  const ClasesPage({super.key});

  @override
  _ClasesPageState createState() => _ClasesPageState();
}

class _ClasesPageState extends State<ClasesPage> {
  List<Map<String, dynamic>> clases = [
    {
      "categoriaClase": "002",
      "claseEquipo": "CENTRIFUGA",
      "validoDe": "27.08.2024",
      "caracteristicas": [
        "CAPACIDAD_L/H",
        "FASES",
        "GRADOPROTECCION_IP",
        "VOLTAJE_V"
      ],
    },
    {
      "categoriaClase": "003",
      "claseEquipo": "BOMBA_LAMELLA",
      "validoDe": "05.07.2023",
      "caracteristicas": [
        "ALTURA_M",
        "CAUDAL_M3/H",
        "DIAMETRODESCARG_IN",
        "DIAMETROSUCCION_IN",
        "RPM",
        "POTENCIA_HP"
      ],
    },
    {
      "categoriaClase": "004",
      "claseEquipo": "ENFRIADORHARINA",
      "validoDe": "28.06.2019",
      "caracteristicas": [
        "CAPACIDAD_FLUJO_TON/H",
        "CILINDRO_LARGO_M",
        "CILINDRO_DIAMETRO_M",
        "NUMERO_PALETAS",
        "POTENCIA_HP",
        "RPM"
      ],
    }
  ];

  // Lista para almacenar las clases filtradas
  List<Map<String, dynamic>> filteredClases = [];

  @override
  void initState() {
    super.initState();
    // Al inicio no mostrar nada
    filteredClases = [];
  }

  // Método para filtrar las clases basadas en la búsqueda
  void _filterClases(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredClases = [];
      });
    } else {
      setState(() {
        filteredClases = clases
            .where((clase) =>
                clase['claseEquipo']
                    .toString()
                    .toLowerCase()
                    .contains(query.toLowerCase()) ||
                clase['categoriaClase']
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
        title: const Text('Clases de Equipo'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Card con el TextField para la búsqueda
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: _filterClases,
                  decoration: const InputDecoration(
                    hintText: 'Buscar clase o categoría...',
                    prefixIcon: Icon(Icons.search),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            // Mostrar la lista filtrada
            Expanded(
              child: filteredClases.isEmpty
                  ? const Center(child: Text('No hay resultados.'))
                  : ListView.builder(
                      itemCount: filteredClases.length,
                      itemBuilder: (context, index) {
                        final clase = filteredClases[index];
                        return Card(
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ListTile(
                            title: Text('Clase: ${clase['claseEquipo']}'),
                            subtitle:
                                Text('Valido desde: ${clase['validoDe']}'),
                            trailing: const Icon(Icons.arrow_forward),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ClaseDetailPage(clase: clase),
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

class ClaseDetailPage extends StatelessWidget {
  final Map<String, dynamic> clase;

  const ClaseDetailPage({super.key, required this.clase});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles de ${clase['claseEquipo']}'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Categoría: ${clase['categoriaClase']}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text('Clase de Equipo: ${clase['claseEquipo']}'),
            Text('Válido desde: ${clase['validoDe']}'),
            const SizedBox(height: 16.0),
            const Text(
              'Características',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            ...clase['caracteristicas'].map<Widget>(
              (caracteristica) => Text('- $caracteristica'),
            ),
          ],
        ),
      ),
    );
  }
}
