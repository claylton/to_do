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
      title: 'Todo App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  var items = new List<Item>();

  HomePage() {
    items = [];
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  _HomePageState() {
    loadData();
  }
  var novaTarefaController = TextEditingController();

  void add() {
    if (novaTarefaController.text.isEmpty) return;
    setState(() {
      widget.items.add(
        new Item(
          title: novaTarefaController.text,
          done: false,
        ),
      );
      saveData();
      novaTarefaController.clear();
    });
  }

  void remove(int index) {
    widget.items.removeAt(index);
    saveData();
  }

  Future loadData() async {
    var prefs = await SharedPreferences.getInstance();
    var data = prefs.getString('data');

    if (data != null) {
      Iterable decode = jsonDecode(data);
      List<Item> result = decode.map((e) => Item.fromJson(e)).toList();
      setState(() {
        widget.items = result;
      });
    }
  }

  saveData() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString('data', jsonEncode(widget.items));
  }

  @override
  Widget build(BuildContext context) {
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
      body: ListView.builder(
        itemCount: widget.items.length,
        itemBuilder: (BuildContext context, int index) {
          final item = widget.items[index];
          return Dismissible(
            key: Key(item.title),
            background: Container(
              color: Colors.pinkAccent,
              child: Align(
                alignment: Alignment(0.9, 0),
                child: Icon(Icons.delete),
              ),
            ),
            child: CheckboxListTile(
              title: Text(item.title),
              value: item.done,
              onChanged: (value) {
                setState(() {
                  item.done = value;
                  saveData();
                });
                if (value) {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          "Parabéns por ter concluido a tarefa: \n'${item.title}' !!"),
                    ),
                  );
                }
              },
              activeColor: Colors.pinkAccent,
            ),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              remove(index);
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text("A tarefa '${item.title}' foi removida"),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: add,
        child: Icon(Icons.add),
        backgroundColor: Colors.pink,
      ),
    );
  }
}
