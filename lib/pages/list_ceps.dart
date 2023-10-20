import 'package:flutter/material.dart';
import 'package:search_cep/model/cep.dart';
import 'package:search_cep/repository/cep_repository.dart';

class ListCeps extends StatefulWidget {
  const ListCeps({
    super.key,
  });

  @override
  State<ListCeps> createState() => _ListCepsState();
}

class _ListCepsState extends State<ListCeps> {

  late Future<List<CEP>> future;
  CepRepository repository = CepRepository();

  late bool loading = false;

  @override
  void initState() {
    super.initState();
    future = repository.listCeps();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder( 
      future: future,
      builder: (context, snapshot) {
        if(snapshot.connectionState != ConnectionState.done || loading){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (_, index){
            CEP cep = snapshot.data![index];
            return Card(
              child: ListTile(
                tileColor: const Color(0xffFFDDE1),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                leading: const Icon(Icons.location_on),
                title: Text(cep.cep ?? '0000000'),
                subtitle: Text('${cep.logradouro}, ${cep.bairro}, ${cep.cidade}, ${cep.estado}'),
                trailing: Wrap(
                  spacing: 16,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: (){}
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () async{
                        setState(() {
                          loading = true;
                        });
                        await repository.deleteCep(cep.id ?? '');
                        future = repository.listCeps();
                        setState(() {
                          loading = false;
                        });
                      }
                    )
                  ]
                )
              )
            );
          },
        );
      }
    );
  }
}