import 'package:flutter/material.dart';
import 'models/item.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //Retira o nome Debug da tela padrão fo Flutter
      title: 'Todo App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

//No Stateful o estado da aplicação muda constantemente
//Classe pai:
class HomePage extends StatefulWidget {
//Os métodos criados abaixo só serão chamados uma vez

//Instanciando o método item -> É um Tipo Lista Item
  var items = new List<Item>();

//Construtor
  HomePage() {
//inicializando a lista de items
    items = [];
//Adicionando items
    items.add(Item(title: "Item 1", done: false));
    items.add(Item(title: "Item 2", done: true));
    items.add(Item(title: "Item 3", done: false));
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var novaTarefaController = TextEditingController();
  @override
//Classe filho:
  Widget build(BuildContext context) {
//Os métodos criados abaixo do build serão recriados a cada execução fzd a lista ser recriada a cada compilação
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          controller: novaTarefaController,
          keyboardType: TextInputType.text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
          decoration: InputDecoration(
            labelText: "Digite aqui uma nova tarefa",
            labelStyle: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
//ListView.builder renderiza a lista sob demanda itens em tela
      body: ListView.builder(
//acessar a variável items criado na classe pai
        itemCount: widget.items.length,
//Função para desenhar os itens em tela
        itemBuilder: (BuildContext context, int index) {
          final item = widget.items[index];
          return CheckboxListTile(
            title: Text(item.title),
            key: Key(item.title),
            value: item.done,
            onChanged: (value) {
              setState(() {
                item.done = value;
              });
            },
          );
        },
      ),
    );
  }
}
