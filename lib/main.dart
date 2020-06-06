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

//Stateful pos o estado da aplicação muda constantemente
class HomePage extends StatefulWidget {
  //Classe pai -> Os métodos criados abaixo só serão chamados uma vez

  //Instanciando o método item -> É Tipo Lista Item
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
  @override
  Widget build(BuildContext context) {
//Classe filho -> métodos criados abaixo do build serão recriados a cada execução fzd o a lista ser recriada
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo List"),
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
//setState só existe dentro de um Statefull widget
//Ele é o responsável em "falar" pro flutter que determinado item mudou e precisa ser alterado
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
