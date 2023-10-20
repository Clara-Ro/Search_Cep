import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:search_cep/pages/create_cep.dart';
import 'package:search_cep/pages/home.dart';
import 'package:search_cep/pages/list_ceps.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  final keyApplicationId = dotenv.env['APPID'];
  final keyClientKey = dotenv.env['CLIENTID'];
  final keyParseServerUrl = dotenv.env['SERVERURL'];

  await Parse().initialize(keyApplicationId!, keyParseServerUrl!,
      clientKey: keyClientKey, autoSendSessionId: true);

  runApp(const SearchCEP());
}

class SearchCEP extends StatelessWidget {
  const SearchCEP({super.key});

// Paletta de cores: #FFDDE1,
// #FFB8DE,
// #FF74D4

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xffFFB8DE),
        useMaterial3: true,
      ),
      home: const SearchCepPage(title: 'Busca de CEP'),
    );
  }
}

class SearchCepPage extends StatefulWidget {
  const SearchCepPage({super.key, required this.title});

  final String title;

  @override
  State<SearchCepPage> createState() => _SearchCepPageState();
}

class _SearchCepPageState extends State<SearchCepPage> {

  int selectedPage = 0;
  String? cep;

  goTo(int index) {
    cep = null;
    setState(() {
      selectedPage = index;
    });
  }

  createNewCep (String cep){
    goTo(1);
    this.cep = cep;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: const Color(0xffFFB8DE),),
      body: <Widget>[
        Home(createNewCep: createNewCep,),
        CreateCep(defaultCep: cep,),
        const ListCeps(),
      ][selectedPage],
      bottomNavigationBar: NavigationBar(
        backgroundColor: const Color(0xffFF74D4),
        indicatorColor: const Color(0xffFFB8DE),
        selectedIndex: selectedPage,
        onDestinationSelected: goTo,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home, color: Color(0xffFFB8DE)),
            selectedIcon: Icon(Icons.home, color: Color(0xffFF74D4)),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.edit, color: Color(0xffFFB8DE)),
            selectedIcon: Icon(Icons.edit, color: Color(0xffFF74D4)),
            label: 'Cadastrar CEP'
          ),
          NavigationDestination(
            icon: Icon(Icons.list, color: Color(0xffFFB8DE)),
            selectedIcon: Icon(Icons.list, color: Color(0xffFF74D4)),
            label: "Todos os CEP's"
          ),
        ],
      )
    );
  }
}