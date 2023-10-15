import 'package:franquicia/common.dart';
import 'package:franquicia/modelos/agencia.dart';
import 'package:franquicia/modelos/agencialista.dart';

class AgenciaHelper {
  static Future<Agencia> getAgencias(String codagencia) async {
    final response = await cliente
        .from('agencias')
        .select(
            'codigofranquicia,codigoagencia,nombreagencia,direccion,correo,banco,telefono,cedulaadmin,cupo,comision,nroticket,serial')
        .eq('codigoagencia', codagencia);
    Agencia agencia = Agencia.fromMap(response[0]);
    return agencia;
  }

  static getAgencias01() async {
    try {
      final response = await cliente.from('agencias').select(
          'codigofranquicia,codigoagencia,nombreagencia,direccion,correo,banco,telefono,cedulaadmin,cupo,comision,nroticket,serial');
      int count = response.length;
      List<Agencia> agencia = [];
      for (int i = 0; i < count; i++) {
        agencia.add(Agencia.fromMap(response[i]));
      }
      AgenciaActual.agenciaActual = agencia;
    } catch (e) {
      //}
    }
  }

  static Future<void> createAgencia(Agencia agencia) async {
    await cliente.from('agencias').insert([
      {
        'codigofranquicia': agencia.codigofranquicia,
        'codigoagencia': agencia.codigoagencia,
        'nombreagencia': agencia.nombreagencia,
        'direccion': agencia.direccion,
        'correo': agencia.correo,
        'banco': agencia.banco,
        'telefono': agencia.telefono,
        'cedulaadmin': agencia.cedulaadmin,
        'cupo': agencia.cupo,
        'comision': agencia.comision,
        'nroticket': agencia.nroticket,
        'serial': agencia.serial,
      }
    ]);
  }

  static Future<void> deleteAgencia(String codigoagencia) async {
    // ignore: unused_local_variable
    final response = await cliente
        .from('agencias')
        .delete()
        .eq('codigoagencia', codigoagencia);
  }

  static Future<void> updateAgencia(Agencia agencia) async {
    // ignore: unused_local_variable
    final response = await cliente.from('agencias').update({
      'nombrefranquicia': agencia.codigofranquicia,
      'codigoagencia': agencia.codigoagencia,
      'nombreagencia': agencia.nombreagencia,
      'direccion': agencia.direccion,
      'correo': agencia.correo,
      'banco': agencia.banco,
      'telefono': agencia.telefono,
      'cedulaadmin': agencia.cedulaadmin,
      'cupo': agencia.cupo,
      'comision': agencia.comision,
      'nroticket': agencia.nroticket,
      'serial': agencia.serial,
    }).eq('codigoagencia', agencia.codigoagencia);
  }
}
