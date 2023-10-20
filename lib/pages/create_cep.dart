import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:search_cep/model/cep.dart';
import 'package:search_cep/repository/cep_repository.dart';

class CreateCep extends StatefulWidget {
  final String? defaultCep;
  CreateCep({
    super.key,
    this.defaultCep
  });

  @override
  State<CreateCep> createState() => _CreateCepState();
}

class _CreateCepState extends State<CreateCep> {

  CEP cep = CEP();
  CepRepository repository = CepRepository();
  TextEditingController controller = TextEditingController();

  Future<void> createCep () async{
    repository.createCep(cep);
  }

  @override
  void initState() {
    super.initState();
    cep.setCep(widget.defaultCep);
    controller.text = widget.defaultCep ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 40, left: 8, bottom: 12),
            child: const Text(
              "Cadastro do Endereço",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white
              ),
            ),
          ),
          Padding (
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              onChanged: cep.setCep,
              controller: controller,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.white)
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.white)
                ),
                labelStyle: TextStyle(
                  color: Colors.white,
                ),
                labelText: 'CEP',
                hintText: 'Digite o CEP'
              ),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                CepInputFormatter()
              ],
            )
          ),
          Padding (
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              onChanged: cep.setEstado,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.white)
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.white)
                ),
                labelStyle: TextStyle(
                  color: Colors.white
                ),
                labelText: 'Estado',
                hintText: 'Digite o Estado'
              ),
              inputFormatters: [
                FilteringTextInputFormatter.singleLineFormatter,
              ],
            )
          ),
          Padding (
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              onChanged: cep.setCidade,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.white)
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.white)
                ),
                labelStyle: TextStyle(
                  color: Colors.white
                ),
                labelText: 'Cidade',
                hintText: 'Digite a cidade'
              ),
              inputFormatters: [
                FilteringTextInputFormatter.singleLineFormatter,
              ],
            )
          ),
          Padding (
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              onChanged: cep.setLogradouro,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.white)
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.white)
                ),
                labelStyle: TextStyle(
                  color: Colors.white
                ),
                labelText: 'Logadouro',
                hintText: 'Digite o logadouro'
              ),
              inputFormatters: [
                FilteringTextInputFormatter.singleLineFormatter,
              ],
            )
          ),
          Padding (
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              onChanged: cep.setBairro,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.white)
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.white)
                ),
                labelStyle: TextStyle(
                  color: Colors.white
                ),
                labelText: 'Bairro',
                hintText: 'Digite o bairro'
              ),
              inputFormatters: [
                FilteringTextInputFormatter.singleLineFormatter,
              ],
            )
          ),
          ElevatedButton.icon(
            onPressed: createCep, 
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                const Color(0xffFF74D4)
              )
            ),
            label: const Text(
              "Salvar",
              style: TextStyle(
                color: Colors.white
              ),
            ),
            icon: const Icon(Icons.save, color: Colors.white,),
          ),
        ],
      ),
    );
  }
}