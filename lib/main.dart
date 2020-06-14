import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
//Adicionando items no sistema
    // items.add(Item(title: "Item 1", done: false));
    // items.add(Item(title: "Item 2", done: true));
    // items.add(Item(title: "Item 3", done: false));
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var novaTarefaController = TextEditingController();

//Método para adicionar um item
  void add() {
//Se o texto for vazio retorna sem entrar no setState
    if (novaTarefaController.text.isEmpty) return;
    setState(() {
//adiciona um item
      widget.items.add(
        new Item(
          title: novaTarefaController.text,
          done: false,
        ),
      );
//limpa o item do controller
      novaTarefaController.clear();
//outra forma de limpar o item
      //novaTarefaController.text = "";
    });
  }

  void remove(int index) {
    widget.items.removeAt(index);
  }

//Ler informações e retornar alguma coisa
  Future loadData() async {
//Aguarde até o método SharedPreferences.getInstance() pronto
    var prefs = await SharedPreferences.getInstance();
//Pegar as informações dentro do SharedfPreferences no formato de String
    var data = prefs.getString('data');

    if (data != null) {
//transformar a String 'data' em JSON no formato Iterable(Uma coluna onde podemos percorrer ela)
      Iterable decode = jsonDecode(data);
//Pegando uma lista de itens do shared preferences:
//decode.map ((e) => = percorre todos os itens e chama uma função
//Item.fromJson(e)) = Converte o JSON para um item (title e done)
//toList() = Transforma os itens em uma lista
      List<Item> result = decode.map((e) => Item.fromJson(e)).toList();
      setState(() {
        widget.items = result;
      });
    }
  }

  _HomePageState() {
    loadData();
  }

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
          return Dismissible(
            key: Key(item.title),
            background: Container(
              color: Colors.pinkAccent,
            ),
            child: CheckboxListTile(
              title: Text(item.title),
              value: item.done,
              onChanged: (value) {
                setState(() {
                  item.done = value;
                });
              },
            ),
            onDismissed: (direction) {
              //if (direction == DismissDirection.endToStart)
              //print(direction);
              remove(index);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
//Aqui estou passando a função, não chamando ela apor isso não tem os () depoi do add
        onPressed: add,
        child: Icon(Icons.add),
        backgroundColor: Colors.pink,
      ),
    );
  }
}
