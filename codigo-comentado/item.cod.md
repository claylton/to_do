```dart
//Classe item onde temos o nome do item e se ele foi feito ou não
class Item {
//Variáveis
  String title;
  bool done;

//Construtor
  Item({this.title, this.done});

//Métodos

//Item irá receber um Map String, dynamic ou seja vai receber um Objeto(JSON) do tipo dynamic no formato de String
  Item.fromJson(Map<String, dynamic> json) {
//Aqui nós iremos percorrer o JSON e pegar a propriedades title e done e passar para suas respectivas variáveis criando um item
    title = json['title'];
    done = json['done'];
  }

//Iremos retornar as informações de um item para um Map String,dynamic(JSON)
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
//Aqui nós iremos percorrer o JSON e passar as informações contidas nas variáveis pro Map
    data['title'] = this.title;
    data['done'] = this.done;
    return data;
  }
}

//OBS:JSON =(JavaScript Object Notation)

```