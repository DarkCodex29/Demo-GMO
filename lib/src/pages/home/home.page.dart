import 'package:demo/src/pages/maintenance/order.page.dart';
import 'package:demo/src/pages/maintenance/warning.page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Equipo/U.T'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            ExpansionTile(
              leading: const Icon(Icons.engineering),
              title: const Text('Datos Maestros para Equipo'),
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.list),
                  title: const Text('Clases'),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.assignment),
                  title: const Text('Características'),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.location_on),
                  title: const Text('Ubicaciones Técnicas'),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.work),
                  title: const Text('Puesto de trabajo'),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.build),
                  title: const Text('Equipos'),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.list_alt),
                  title: const Text('Lista de Materiales'),
                  onTap: () {},
                ),
              ],
            ),
            ExpansionTile(
              leading: const Icon(Icons.timeline),
              title: const Text('Datos Maestros para Planificación'),
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.stacked_line_chart),
                  title: const Text('Estrategias'),
                  onTap: () {},
                ),
                ExpansionTile(
                  leading: const Icon(Icons.map),
                  title: const Text('Hoja de Ruta'),
                  children: <Widget>[
                    ListTile(
                      leading: const Icon(Icons.devices),
                      title: const Text('Equipo'),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const Icon(Icons.location_city),
                      title: const Text('UBT'),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const Icon(Icons.description),
                      title: const Text('Instrucción'),
                      onTap: () {},
                    ),
                  ],
                ),
                ExpansionTile(
                  leading: const Icon(Icons.calendar_today),
                  title: const Text('Plan de Mantenimiento'),
                  children: <Widget>[
                    ListTile(
                      leading: const Icon(Icons.repeat),
                      title: const Text('Ciclo Individual'),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const Icon(Icons.bar_chart),
                      title: const Text('Estrategia'),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const Icon(Icons.view_list),
                      title: const Text('Múltiple'),
                      onTap: () {},
                    ),
                  ],
                ),
              ],
            ),
            ExpansionTile(
              leading: const Icon(Icons.warning),
              title: const Text('Mantenimiento Correctivo'),
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.notification_important),
                  title: const Text('Aviso'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AvisoPage(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.build_circle),
                  title: const Text('Orden'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OrdenPage(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.done),
                  title: const Text('Ejecución'),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.notifications),
                  title: const Text('Notificación'),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.error),
                  title: const Text('Registro de falla'),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.close),
                  title: const Text('Cierre'),
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
