import 'package:flutter/material.dart';
import 'package:franquicia/common.dart';
import 'package:franquicia/helper/agencia_helper.dart';
import 'package:franquicia/main.dart';
import 'package:franquicia/modelos/agencia.dart';
import 'package:franquicia/modelos/agencialista.dart';
import 'package:franquicia/modelos/apuesta_agencia.dart';

class DashboardApp extends StatelessWidget {
  const DashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Escritorio',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  String selectedOption = 'Agregar Agencia'; // Opción seleccionada por defecto
  TextEditingController codigoFranquicia = TextEditingController();
  TextEditingController codigoAgencia = TextEditingController();
  TextEditingController nombreAgencia = TextEditingController();
  TextEditingController direccion = TextEditingController();
  TextEditingController correo = TextEditingController();
  TextEditingController banco = TextEditingController();
  TextEditingController telefono = TextEditingController();
  TextEditingController cedulaadmin = TextEditingController();
  TextEditingController cupo = TextEditingController();
  TextEditingController comision = TextEditingController();
  TextEditingController nroticket = TextEditingController();
  Agencia? selectedAgencia;
  List<Agencia> listaAgencias = [];
  void selectOption(String option) {
    setState(() {
      selectedOption = option;
    });
  }

  @override
  void initState() {
    iniciarAgencia();

    super.initState();
    leeragencias().then((value) {
      setState(() {
        listaAgencias = AgenciaActual.agenciaActual;
        selectedAgencia = listaAgencias.isNotEmpty ? listaAgencias[0] : null;
      });
    });
  }

  void iniciarAgencia() {
    codigoFranquicia.text = "";
    codigoAgencia.text = "";
    nombreAgencia.text = "";
    direccion.text = "";
    correo.text = "";
    banco.text = "";
    telefono.text = "";
    cedulaadmin.text = "";
    cupo.text = "";
    comision.text = "";
  }

  @override
  void didUpdateWidget(covariant DashboardScreen oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (selectedOption == 'Actualizar Agencia') {
      if (listaAgencias.isEmpty) {
        leeragencias().then((value) {
          setState(() {
            listaAgencias = AgenciaActual.agenciaActual;
            selectedAgencia =
                listaAgencias.isNotEmpty ? listaAgencias[0] : null;
          });
        });
      }
    } else if (selectedOption == 'Eliminar Agencia') {
      if (listaAgencias.isEmpty) {
        leeragencias().then((value) {
          setState(() {
            listaAgencias = AgenciaActual.agenciaActual;
            selectedAgencia =
                listaAgencias.isNotEmpty ? listaAgencias[0] : null;
          });
        });
      }
    }
  }

  Widget _buildDataInput() {
    if (selectedOption == 'Agregar Agencia') {
      iniciarAgencia();
      listaAgencias = [];
      return Column(
        children: [
          TextField(
            controller: codigoAgencia,
            decoration: const InputDecoration(labelText: 'Código de Agencia'),
          ),
          TextField(
            controller: nombreAgencia,
            decoration: const InputDecoration(labelText: 'Nombre de Agencia'),
          ),
          TextField(
            controller: direccion,
            decoration: const InputDecoration(labelText: 'Dirección'),
          ),
          TextField(
            controller: correo,
            decoration: const InputDecoration(labelText: 'Dirección'),
          ),
          TextField(
            controller: banco,
            decoration: const InputDecoration(labelText: 'Banco'),
          ),
          TextField(
            controller: telefono,
            decoration: const InputDecoration(labelText: 'Teléfono'),
          ),
          TextField(
            controller: cedulaadmin,
            decoration:
                const InputDecoration(labelText: 'Cédula del Administrador'),
          ),
          TextField(
            controller: cupo,
            decoration: const InputDecoration(labelText: 'Cupo'),
          ),
          TextField(
            controller: comision,
            decoration: const InputDecoration(labelText: 'Comisión'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              child: const Text('Agregar'),
              onPressed: () {
                Agencia agencia = Agencia(
                  codigofranquicia: codigoFranquicia.text,
                  codigoagencia: codigoAgencia.text,
                  nombreagencia: nombreAgencia.text,
                  direccion: direccion.text,
                  correo: correo.text,
                  banco: banco.text,
                  telefono: telefono.text,
                  cedulaadmin: cedulaadmin.text,
                  cupo: double.parse(cupo.text),
                  comision: 0.0,
                  nroticket: 0,
                  serial: 0,
                );
                AgenciaHelper.createAgencia(agencia);
                iniciarAgencia();
                //llamar a agregar o insertar agencia
              },
            ),
          ),
        ],
      );
    } else if (selectedOption == 'Actualizar Agencia') {
      if (listaAgencias.isEmpty) {
        leeragencias();
        if (AgenciaActual.agenciaActual.isNotEmpty) {
          listaAgencias = AgenciaActual.agenciaActual;
          selectedAgencia = listaAgencias[0];
        }
      }
      return Column(
        children: [
          DropdownButton<Agencia>(
            value: selectedAgencia, // Agencia seleccionada
            hint: const Text(
              'Selecciona una agencia',
              style: TextStyle(
                color: Color.fromARGB(
                    255, 247, 11, 11), // Cambia el color del texto aquí
              ),
            ), // Texto de sugerencia
            items: listaAgencias.map((items) {
              return DropdownMenuItem<Agencia>(
                value: items,
                child: Text(items.nombreagencia),
              );
            }).toList(),
            onChanged: (items) {
              setState(() {
                iniciarAgencia();
                selectedAgencia = items; // Actualizar la agencia seleccionada
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              child: const Text('Buscar'),
              onPressed: () async {
                if (selectedAgencia != null) {
                  codigoFranquicia.text = selectedAgencia!.codigofranquicia;
                  codigoAgencia.text = selectedAgencia!.codigoagencia;
                  nombreAgencia.text = selectedAgencia!.nombreagencia;
                  direccion.text = selectedAgencia!.direccion;
                  correo.text = selectedAgencia!.correo;
                  banco.text = selectedAgencia!.banco;
                  telefono.text = selectedAgencia!.telefono;
                  cedulaadmin.text = selectedAgencia!.cedulaadmin;
                  cupo.text = selectedAgencia!.cupo.toString();
                  comision.text = selectedAgencia!.comision.toString();
                }
                // Lógica para buscar el registro a actualizar
              },
            ),
          ),
          // Mostrar los campos para actualizar los datos
          TextField(
            controller: nombreAgencia,
            decoration: const InputDecoration(labelText: 'Nombre de Agencia'),
          ),
          TextField(
            decoration: const InputDecoration(labelText: 'Dirección'),
            controller: direccion,
          ),
          TextField(
            decoration: const InputDecoration(labelText: 'Dirección'),
            controller: correo,
          ),
          TextField(
            controller: banco,
            decoration: const InputDecoration(labelText: 'Banco'),
          ),
          TextField(
            controller: telefono,
            decoration: const InputDecoration(labelText: 'Teléfono'),
          ),
          TextField(
            controller: cedulaadmin,
            decoration:
                const InputDecoration(labelText: 'Cédula del Administrador'),
          ),
          TextField(
            controller: cupo,
            decoration: const InputDecoration(labelText: 'Cupo'),
          ),
          TextField(
            controller: comision,
            decoration: const InputDecoration(labelText: 'Comisión'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              child: const Text('Actualizar'),
              onPressed: () {
                Agencia agencia = Agencia(
                  codigofranquicia: codigoFranquicia.text,
                  codigoagencia: codigoAgencia.text,
                  nombreagencia: nombreAgencia.text,
                  direccion: direccion.text,
                  correo: correo.text,
                  banco: banco.text,
                  telefono: telefono.text,
                  cedulaadmin: cedulaadmin.text,
                  cupo: double.parse(cupo.text),
                  comision: double.parse(comision.text),
                  nroticket: 0,
                  serial: 0,
                );
                AgenciaHelper.updateAgencia(agencia);
                setState(() {
                  iniciarAgencia();
                  listaAgencias = [];
                });

                // Lógica para actualizar el registro
              },
            ),
          ),
        ],
      );
    } else if (selectedOption == 'Eliminar Agencia') {
      //  agencias = AgenciaActual.agenciaActual;
      if (listaAgencias.isEmpty) {
        leeragencias();
        if (AgenciaActual.agenciaActual.isNotEmpty) {
          listaAgencias = AgenciaActual.agenciaActual;
          selectedAgencia = listaAgencias[0];
        }
      }

      return Column(
        children: [
          DropdownButton<Agencia>(
            value: selectedAgencia, // Agencia seleccionada
            hint: const Text(
              'Selecciona una agencia',
              style: TextStyle(
                color: Color.fromARGB(
                    255, 247, 11, 11), // Cambia el color del texto aquí
              ),
            ), // Texto de sugerencia
            items: listaAgencias.map((items) {
              return DropdownMenuItem<Agencia>(
                value: items,
                child: Text(items.nombreagencia),
              );
            }).toList(),
            onChanged: (items) {
              setState(() {
                iniciarAgencia();
                selectedAgencia = items; // Actualizar la agencia seleccionada
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              child: const Text('Buscar'),
              onPressed: () async {
                if (selectedAgencia != null) {
                  codigoAgencia.text = selectedAgencia!.codigoagencia;
                  nombreAgencia.text = selectedAgencia!.nombreagencia;
                  direccion.text = selectedAgencia!.direccion;
                  correo.text = selectedAgencia!.correo;
                  banco.text = selectedAgencia!.banco;
                  telefono.text = selectedAgencia!.telefono;
                  cedulaadmin.text = selectedAgencia!.cedulaadmin;
                  cupo.text = selectedAgencia!.cupo.toString();
                  comision.text = selectedAgencia!.comision.toString();
                }
                // Lógica para buscar el registro a actualizar
              },
            ),
          ),
          TextField(
            controller: nombreAgencia,
            decoration: const InputDecoration(labelText: 'Nombre de Agencia'),
          ),
          TextField(
            decoration: const InputDecoration(labelText: 'Dirección'),
            controller: direccion,
          ),
          TextField(
            decoration: const InputDecoration(labelText: 'Dirección'),
            controller: correo,
          ),
          TextField(
            controller: banco,
            decoration: const InputDecoration(labelText: 'Banco'),
          ),
          TextField(
            controller: telefono,
            decoration: const InputDecoration(labelText: 'Teléfono'),
          ),
          TextField(
            controller: cedulaadmin,
            decoration:
                const InputDecoration(labelText: 'Cédula del Administrador'),
          ),
          TextField(
            controller: cupo,
            decoration: const InputDecoration(labelText: 'Cupo'),
          ),
          TextField(
            controller: comision,
            decoration: const InputDecoration(labelText: 'Comisión'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              child: const Text('Eliminar'),
              onPressed: () {
                codigoAgencia.text = selectedAgencia!.codigoagencia;
                AgenciaHelper.deleteAgencia(codigoAgencia.text);
                setState(() {
                  listaAgencias = [];
                  AgenciaActual.agenciaActual = [];
                  iniciarAgencia();
                  leeragencias();
                  listaAgencias = AgenciaActual.agenciaActual;
                  selectedAgencia = listaAgencias[0];
                });

                // Lógica para eliminar el registro
              },
            ),
          ),
        ],
      );
    } else if (selectedOption == 'Ventas Generales') {
      List<ApuestaAgencia> tabla = [
        ApuestaAgencia(
          agencia: 'Agencia 1',
          fecha: 'Fecha 1',
          loteria: 'Loteria 1',
          sorteo: 'Sorteo 1',
          numero: 'Numero 1',
          jugada: 100.0,
          maximo: 100,
          premio: 50,
          activo: true,
        ),
        ApuestaAgencia(
          agencia: 'Agencia 1',
          fecha: 'Fecha 1',
          loteria: 'Loteria 1',
          sorteo: 'Sorteo 2',
          numero: 'Numero 1',
          jugada: 100.0,
          maximo: 100,
          premio: 50,
          activo: true,
        ),
        ApuestaAgencia(
          agencia: 'Agencia 1',
          fecha: 'Fecha 1',
          loteria: 'Loteria 1',
          sorteo: 'Sorteo 3',
          numero: 'Numero 1',
          jugada: 100.0,
          maximo: 100,
          premio: 50,
          activo: true,
        ),
        ApuestaAgencia(
          agencia: 'Agencia 1',
          fecha: 'Fecha 1',
          loteria: 'Loteria 2',
          sorteo: 'Sorteo 1',
          numero: 'Numero 1',
          jugada: 100.0,
          maximo: 100,
          premio: 50,
          activo: true,
        ),
        ApuestaAgencia(
          agencia: 'Agencia 1',
          fecha: 'Fecha 1',
          loteria: 'Loteria 3',
          sorteo: 'Sorteo 1',
          numero: 'Numero 1',
          jugada: 100.0,
          maximo: 100,
          premio: 50,
          activo: true,
        ),
        ApuestaAgencia(
          agencia: 'Agencia 2',
          fecha: 'Fecha 2',
          loteria: 'Loteria 1',
          sorteo: 'Sorteo 2',
          numero: 'Numero 2',
          jugada: 200.0,
          maximo: 200,
          premio: 100,
          activo: true,
        ),
        ApuestaAgencia(
          agencia: 'Agencia 2',
          fecha: 'Fecha 2',
          loteria: 'Loteria 2',
          sorteo: 'Sorteo 2',
          numero: 'Numero 2',
          jugada: 200.0,
          maximo: 200,
          premio: 100,
          activo: true,
        ),
        ApuestaAgencia(
          agencia: 'Agencia 2',
          fecha: 'Fecha 2',
          loteria: 'Loteria 3',
          sorteo: 'Sorteo 2',
          numero: 'Numero 2',
          jugada: 200.0,
          maximo: 200,
          premio: 100,
          activo: true,
        ),
      ];
      Map<String, List<ApuestaAgencia>> registrosPorAgencia = {};

      for (var registro in tabla) {
        if (!registrosPorAgencia.containsKey(registro.agencia)) {
          registrosPorAgencia[registro.agencia] = [];
        }
        registrosPorAgencia[registro.agencia]!.add(registro);
      }

      double totalJugada = 0;
      double totalPremio = 0;
      for (var registro in tabla) {
        totalJugada += registro.jugada;
        totalPremio += registro.premio;
      }
      return Column(
        children: [
          const TextField(
            decoration: InputDecoration(labelText: 'Fecha'),
          ),
          ElevatedButton(
            child: const Text('Generar Reporte'),
            onPressed: () {
              // Lógica para generar el reporte según la fecha ingresada
            },
          ),
          const SizedBox(height: 16),
          // Mostrar el reporte generado
          Expanded(
            child: ListView(
              children: [
                for (var agencia in registrosPorAgencia.keys)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        agencia,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const SizedBox(height: 8),
                      for (var loteria in registrosPorAgencia[agencia]!
                          .map((registro) => registro.loteria)
                          .toSet())
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              loteria,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            DataTable(
                              columns: const [
                                DataColumn(label: Text('Sorteo')),
                                DataColumn(label: Text('Jugada')),
                                DataColumn(label: Text('Premio')),
                                DataColumn(label: Text('Diferencia')),
                              ],
                              rows: registrosPorAgencia[agencia]!
                                  .where(
                                      (registro) => registro.loteria == loteria)
                                  .map<DataRow>((registro) {
                                return DataRow(
                                  cells: [
                                    DataCell(Text(registro.sorteo)),
                                    DataCell(Text(registro.jugada.toString())),
                                    DataCell(Text(registro.premio.toString())),
                                    DataCell(Text(
                                        (registro.jugada - registro.premio)
                                            .toString())),
                                  ],
                                );
                              }).toList(),
                            ),
                            const SizedBox(height: 16),
                            // Subtotal por lotería
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Subtotal $loteria:',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Jugada: ${registrosPorAgencia[agencia]!.where((registro) => registro.loteria == loteria).map((registro) => registro.jugada).reduce((a, b) => a + b)}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Premio: ${registrosPorAgencia[agencia]!.where((registro) => registro.loteria == loteria).map((registro) => registro.premio).reduce((a, b) => a + b)}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Diferencia: ${registrosPorAgencia[agencia]!.where((registro) => registro.loteria == loteria).map((registro) => registro.jugada - registro.premio).reduce((a, b) => a + b)}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      // Subtotal por agencia
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Subtotal $agencia:',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Jugada: ${registrosPorAgencia[agencia]!.map((registro) => registro.jugada).reduce((a, b) => a + b)}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Premio: ${registrosPorAgencia[agencia]!.map((registro) => registro.premio).reduce((a, b) => a + b)}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Diferencia: ${registrosPorAgencia[agencia]!.map((registro) => registro.jugada - registro.premio).reduce((a, b) => a + b)}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
              ],
            ),
          ),
          // Total general
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Total general:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Jugada: $totalJugada',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Premio: $totalPremio',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Diferencia: ${totalJugada - totalPremio}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      );
    } else if (selectedOption == 'Opción 5') {
      return const Column(
        children: [
          Text('Contenido de la Opción 5'),
        ],
      );
    } else if (selectedOption == 'Opción 6') {
      return const Column(
        children: [
          Text('Contenido de la Opción 6'),
        ],
      );
    } else if (selectedOption == 'Opción 7') {
      return const Column(
        children: [
          Text('Contenido de la Opción 7'),
        ],
      );
    } else if (selectedOption == 'Opción 8') {
      return const Column(
        children: [
          Text('Contenido de la Opción 8'),
        ],
      );
    } else {
      return Container();
    }
  }

  leeragencias() async {
    await AgenciaHelper.getAgencias01();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lotoplay                                                                                     Escritorio',
          style: TextStyle(color: Colors.amber, fontSize: 30),
        ),
      ),
      body: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 25,
              ),
              GestureDetector(
                onTap: () => selectOption('Agregar Agencia'),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 200,
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 5,
                          color: const Color.fromARGB(255, 77, 75, 74)),
                      borderRadius: const BorderRadius.all(Radius.circular(25)),
                    ),
                    child: Text(
                      'Agregar Agencia',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: selectedOption == 'Agregar Agencia'
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => selectOption('Actualizar Agencia'),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 200,
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 5,
                          color: const Color.fromARGB(255, 77, 75, 74)),
                      borderRadius: const BorderRadius.all(Radius.circular(25)),
                    ),
                    child: Text(
                      'Actualizar Agencia',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: selectedOption == 'Actualizar Agencia'
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => selectOption('Eliminar Agencia'),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 200,
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 5,
                          color: const Color.fromARGB(255, 77, 75, 74)),
                      borderRadius: const BorderRadius.all(Radius.circular(25)),
                    ),
                    child: Text(
                      'Eliminar Agencia',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: selectedOption == 'Eliminar Agencia'
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => selectOption('Ventas Generales'),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 200,
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 5,
                          color: const Color.fromARGB(255, 77, 75, 74)),
                      borderRadius: const BorderRadius.all(Radius.circular(25)),
                    ),
                    child: Text(
                      'Ventas Generales',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: selectedOption == 'Ventas Generales'
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => selectOption('Opción 5'),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 200,
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 5,
                          color: const Color.fromARGB(255, 77, 75, 74)),
                      borderRadius: const BorderRadius.all(Radius.circular(25)),
                    ),
                    child: Text(
                      'Opción 5',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: selectedOption == 'Opción 5'
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => selectOption('Opción 6'),
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 200,
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 5,
                            color: const Color.fromARGB(255, 77, 75, 74)),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25)),
                      ),
                      child: Text(
                        'Opción 6',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: selectedOption == 'Opción 6'
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    )),
              ),
              GestureDetector(
                onTap: () => selectOption('Opción 7'),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 200,
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 5,
                          color: const Color.fromARGB(255, 77, 75, 74)),
                      borderRadius: const BorderRadius.all(Radius.circular(25)),
                    ),
                    child: Text(
                      'Opción 7',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: selectedOption == 'Opción 7'
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => selectOption('Opción 8'),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 200,
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 5,
                          color: const Color.fromARGB(255, 77, 75, 74)),
                      borderRadius: const BorderRadius.all(Radius.circular(25)),
                    ),
                    child: Text(
                      'Opción 8',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: selectedOption == 'Opción 8'
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 5, color: const Color.fromARGB(255, 77, 75, 74)),
                    borderRadius: const BorderRadius.all(Radius.circular(25)),
                  ),
/*
                  width: 160,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 151, 201, 223)),*/
                  child: _buildDataInput()),
            ),
          ),
        ],
      ),
    );
  }
}

class EndSession extends StatelessWidget {
  const EndSession({super.key});

  @override
  Widget build(BuildContext context) {
    cliente.auth.signOut();
    return const MyWidget();
  }
}
