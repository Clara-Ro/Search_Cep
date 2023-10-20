
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:search_cep/model/cep.dart';

class CepRepository {
  final cepObjectName = 'SearchCep';

  Future<bool> createCep(CEP cep ) async {
    var cepObject = ParseObject(cepObjectName);

    cepObject.set('Cep', cep.cep);
    cepObject.set('bairro', cep.bairro);
    cepObject.set('cidade', cep.cidade);
    cepObject.set('logradouro', cep.logradouro);
    cepObject.set('estado', cep.estado);

    ParseResponse res = await cepObject.save();
    return res.success;
  }

  Future<List<CEP>> listCeps () async{
    QueryBuilder<ParseObject> queryListCeps = QueryBuilder<ParseObject>(ParseObject(cepObjectName));
    final ParseResponse response = await queryListCeps.query();

    if(response.success && response.results != null){
      return (response.results as List<ParseObject>).map(
        (e) => CEP.fromParseObject(e)
      ).toList();
    }
    return[];
  }

  Future<CEP?> searchCep (String cep) async {
    QueryBuilder<ParseObject> queryCep = 
      QueryBuilder<ParseObject>(ParseObject(cepObjectName));

    queryCep.whereContains('Cep', cep);

    final ParseResponse response = await queryCep.query();

    if(response.success && response.results != null){
      return CEP.fromParseObject(response.results![0] as ParseObject);
    }
    return null; 
  }

  Future<void> deleteCep (String id) async{
    var cepObject = ParseObject(cepObjectName)..objectId = id;
    await cepObject.delete();
  }

}