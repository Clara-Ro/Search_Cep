// ignore_for_file: use_build_context_synchronously

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:search_cep/model/cep.dart';
import 'package:search_cep/repository/cep_repository.dart';

class Home extends StatefulWidget {
  final void Function(String ) createNewCep;
  Home({
    super.key,
    required this.createNewCep
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String cep = '';
  CEP? result;
  CepRepository repository = CepRepository();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
        padding: const EdgeInsets.only(top: 40, left: 8, bottom: 12),
          child: const Text(
            "Digite um CEP",
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
            onChanged: (String? value) => cep = value!,
            decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: Colors.white)
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: Colors.white)
              ),
              labelStyle: TextStyle(
              color: Colors.white
            )
            ),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              CepInputFormatter()
            ],
          )
        ),
        ElevatedButton.icon(
          onPressed: () async{
            result = await repository.searchCep(cep);
            setState(() {});
            if (result == null){
              showDialog(
                context: context, 
                builder: (_){
                  return AlertDialog(
                    title: const Text('CEP não encontrado'),
                    content: const Text('Deseja cadastrar esse CEP?'),
                    actions: [
                      TextButton.icon(
                        onPressed: () => Navigator.pop(context), 
                        icon: const Icon(Icons.close), 
                        label: const Text('Não')
                      ),
                      TextButton.icon(
                        onPressed: (){
                          Navigator.pop(context);
                          widget.createNewCep(cep);
                        }, 
                        icon: const Icon(Icons.arrow_forward_ios), 
                        label: const Text('Sim')
                      )
                    ],
                  );
                }
              );
            }
          }, 
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
            const Color(0xffFF74D4)
            )
          ),
          label: const Text(
            "Buscar",
            style: TextStyle(
              color: Colors.white
            ),
          ),
          icon: const Icon(Icons.search, color: Colors.white,),
        ),
        if(result != null)...[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text('${result!.cep!}, ${result!.estado!}, ${result!.cidade!}'),
              ),
              Text('${result!.bairro!}, ${result!.logradouro!}'),
            ],
          )
        ]
      ],
    );
  }
}