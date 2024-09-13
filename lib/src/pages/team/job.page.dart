import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class JobPage extends StatefulWidget {
  const JobPage({super.key});

  @override
  _JobPageState createState() => _JobPageState();
}

class _JobPageState extends State<JobPage> {
  List<Map<String, dynamic>> jobs = [];
  List<Map<String, dynamic>> filteredJobs = [];
  Map<String, dynamic>? selectedJob;

  @override
  void initState() {
    super.initState();
    _loadJobs();
  }

  // Cargar los datos del JSON
  Future<void> _loadJobs() async {
    final String response = await rootBundle.loadString('assets/data/job.json');
    final data = await json.decode(response);
    setState(() {
      jobs = List<Map<String, dynamic>>.from(data['puestos_trabajo']);
      // filteredJobs se inicializa vacío y se llenará después de la búsqueda
      filteredJobs = [];
    });
  }

  // Filtrar los puestos de trabajo
  void _filterJobs(String query) {
    setState(() {
      filteredJobs = jobs
          .where((job) =>
              job['puesto']
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              job['descripcion']
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
        title: const Text('Puesto de Trabajo'),
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
                  onChanged: _filterJobs,
                  decoration: const InputDecoration(
                    hintText: 'Buscar puesto de trabajo...',
                    prefixIcon: Icon(Icons.search),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            // Mostrar resultados solo después de la búsqueda
            Expanded(
              child: filteredJobs.isEmpty
                  ? const Center(
                      child: Text('No hay resultados.'),
                    )
                  : ListView.builder(
                      itemCount: filteredJobs.length,
                      itemBuilder: (context, index) {
                        final job = filteredJobs[index];
                        return Card(
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ListTile(
                            title: Text('Puesto: ${job['puesto']}'),
                            subtitle: Text(job['descripcion']),
                            trailing: const Icon(Icons.arrow_forward),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => JobDetailPage(job: job),
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

class JobDetailPage extends StatelessWidget {
  final Map<String, dynamic> job;

  const JobDetailPage({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles de ${job['puesto']}'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildDetailTile('Puesto de Trabajo', job['puesto']),
            _buildDetailTile('Centro', job['centro']),
            _buildDetailTile('Descripción', job['descripcion']),
            const SizedBox(height: 16.0),
            const Text(
              'Datos Básicos',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            _buildDetailTile('Categoría de Trabajo',
                job['datos_basicos']['categoria_trabajo']),
            _buildDetailTile(
                'Responsable', job['datos_basicos']['responsable']),
            _buildDetailTile(
                'Emplazamiento', job['datos_basicos']['emplazamiento']),
            _buildDetailTile(
                'Utilización HRuta', job['datos_basicos']['utilizacion_hruta']),
            const SizedBox(height: 16.0),
            const Text(
              'Valores Propuestos',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            _buildDetailTile(
                'Clave de Control', job['valores_propuestos']['clave_control']),
            _buildDetailTile(
                'CC Nómina', job['valores_propuestos']['cc_nomina']),
            const SizedBox(height: 16.0),
            const Text(
              'Capacidades',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            _buildDetailTile(
                'Clase de Capacidad', job['capacidades']['clase_capacidad']),
            _buildDetailTile('Persona', job['capacidades']['persona']),
            const SizedBox(height: 16.0),
            const Text(
              'Programación',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            _buildDetailTile('Duración Preparación',
                job['programacion']['duracion_preparacion']),
            _buildDetailTile('Duración Tratamiento',
                job['programacion']['duracion_tratamiento']),
            _buildDetailTile('Tiempo Espera Normal',
                job['programacion']['tiempo_espera_normal']),
            const SizedBox(height: 16.0),
            const Text(
              'Cálculo de Coste',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            _buildDetailTile(
                'Fecha Inicio', job['calculo_coste']['fecha_inicio']),
            _buildDetailTile(
                'Fecha Final', job['calculo_coste']['fecha_final']),
            _buildDetailTile('Sociedad', job['calculo_coste']['sociedad']),
            _buildDetailTile(
                'Centro de Coste', job['calculo_coste']['centro_coste']),
            const SizedBox(height: 16.0),
            const Text(
              'Tecnología',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            _buildDetailTile(
                'Tipo de Máquina', job['tecnologia']['tipo_maquina']),
            _buildDetailTile('Concepto de Clasificación',
                job['tecnologia']['concepto_clasificacion']),
            _buildDetailTile(
                'Planificador CAP', job['tecnologia']['planificador_cap']),
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
