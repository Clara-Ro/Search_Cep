
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class CEP {
  String? id;
  String? cep;
  String? logradouro;
  String? bairro;
  String? cidade;
  String? estado;

  void setCep (String? value) => cep = value;
  void setLogradouro (String? value) => logradouro = value;
  void setBairro (String? value) => bairro = value;
  void setCidade (String? value) => cidade = value;
  void setEstado (String? value) => estado = value;

  CEP();

  factory CEP.fromParseObject (ParseObject object){
    CEP cep = CEP();
    cep.cep = object.get('Cep');
    cep.logradouro = object.get('logradouro');
    cep.bairro = object.get('bairro');
    cep.estado = object.get('estado');
    cep.cidade = object.get('cidade');
    cep.id = object.get('objectId');

    return cep;
  }
}