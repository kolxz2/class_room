import 'package:flutter/material.dart';
import 'package:to_do_list/children/childen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  // Фреймворк вызывает createState()когда он хочет построить виджет
  State<Home> createState() => _HomeState();
}
// StatefulWidgets для динамических значений
// класс хранит изменяемые данные которые могут
// меняться в течение жизни виджета.
class _HomeState extends State<Home> {


  late String _userTodo;
  List<Stud> todoList = [Stud("name")];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[900], // насыщенность цвета [900]
      appBar: AppBar(
        title: Text("Quantity of students: " + todoList.length.toString()),
        centerTitle: true,
      ),
      // отображение элементов в виде списка
      body: ListView.builder(
          // сколько элементов в списке
          itemCount: todoList.length,
          // как будет построен список. Перебирает всесь список и позволяет
          // раотать с каждым элементом в отдельности. Задаётся функцией
          itemBuilder: (BuildContext context, int index){
            // возвращает класс позволяющий смахивать в право или в лево удаляя
            // элемент в key принимает элемент с которым работаем в данный
            // момент, в child прописываем дизайн в котором мы прописываем
            // представление элементов
            return Dismissible(key: Key(todoList[index].getName()),
                // класс представления ввиде карточки
                child: Card(
                  // в карточку выводим только заголовок
                  child: ListTile(
                      leading: Text(
                        todoList[index].getName(),
                        style: const TextStyle(
                          fontSize: 20
                        ),
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          IconButton(
                            icon: const Icon(
                              Icons.info,
                              color: Colors.pink,
                            ),
                            onPressed: (){
                              _showInfo(context, index);
                            },
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.red,
                            ),
                            onPressed: (){
                              _editGrades(context, index);
                            },
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.deepPurpleAccent,
                            ),
                            onPressed: (){
                              setState(() {
                                todoList.removeAt(index);
                              });
                            }
                          ),
                        ]
                      )
                  ),
                ),
                onDismissed: (direction){
              // проверка что свайп был с права на лево
              // if (direction == DismissDirection.endToStart)
                  setState(() {
                    todoList.removeAt(index);
                  });
                },
            );
          }
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.greenAccent,
        onPressed: (){
          // показываеем диалоговое окно. Принимает 2 параметра.
          // 1) Контекст. Поверх чего будет отобразаться окно.
          // Context берём из входного параметра
          // Widget build(BuildContext context)
          // 2)
          showDialog(context: context, builder: (BuildContext context){
            return AlertDialog(
              title: const Text(' Add name'),
              content: TextField(
                onChanged: (String value){
                  _userTodo = value;
                },
              ),
              actions: [
                ElevatedButton(onPressed: () {
                  setState(() {
                    todoList.add(Stud(_userTodo));
                  });
                  // после нажатия скрывает диалоговЫЕ окнА
                  Navigator.of(context).pop();
                },
                  child: const Text("Add"))
              ],
            );
          });
        },
        child: const Icon(
          Icons.add_box,
          color: Colors.white,
        ),
      ),
    );
  }

  _showInfo(context, index){
    showDialog(context: context, builder: (BuildContext context) =>
        StatefulBuilder(
            builder: (context, setState) => AlertDialog(
                actions: <Widget>[
                  TextButton(
                  onPressed: () {
                    Navigator.pop(context, null);
                    },
                      child: const Text('Cansel'),
                    ),],
              title: Text("Info about ${todoList[index].getName()}"),
              content: Text(_forInfo(index) + "\n" + "Student average grade:" +
              todoList[index].getAverage().toString()),
            )
        )
    );
  }

  _forInfo(index){
    int count = 1;
    List<int> currentGrade = [];
    for(int i in todoList[index].getGrades()){
      if (i > 0){
        currentGrade.add(i);
      }
    }
    String stringGrades = "";
    for (int i in currentGrade ){
       stringGrades += "Grade № $count: ${i.toString()} \n";
       count++;
    }
    return stringGrades;
  }


  void _editGrades(BuildContext context, indexTodo){

    String selected = "-";
    List<String> _gradesView = ["-", "2", "3", "4", "5"];
    List _currentGrades = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];


    showDialog(context: context, builder: (BuildContext context) =>
        StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            title: const Text("Edit student info"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context, null);
                },
                child: const Text('Cansel'),
              ),
            ],
            content: SizedBox(
              width: double.minPositive,
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                        child: ListTile(
                            enabled: true,
                            title: Text("Grade № $index"),
                            trailing: DropdownButton<String>(
                              value:  current(indexTodo, index),
                              // _currentGrades[index].toString() == "0"
                              //     ? "-": _currentGrades[index].toString(),
                              items: _gradesView.map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(item),
                              )).toList(),
                              onChanged: (item) => setState(() {
                                selected = item!;
                                if (selected == "-"){
                                  _currentGrades[index] = int.parse("0");
                                  todoList[indexTodo].setGradeByIndex(_currentGrades[index], index);
                                  // print(todoList[indexTodo].getGrades());
                                } else {
                                  _currentGrades[index] = int.parse(selected);
                                  todoList[indexTodo].setGradeByIndex(_currentGrades[index], index);
                                  // print(todoList[indexTodo].getGrades());
                                }
                              }),
                            )
                        ));
                  }
              ),
            ),
          )
        )
    );
  }

  String current(indexTodo, index){
    String curr = todoList[indexTodo].getGrade(index).toString();
    switch (curr) {
      case "5":
        curr = "5";
        break;
      case "4":
        curr = "4";
        break;
      case "3":
        curr = "3";
        break;
      case "2":
        curr = "2";
        break;
      case "0":
        curr = "-";
        break;
    }
    return curr;
  }

  //  _templateGrade(elementCount){
  //   return Card(
  //     child: ListTile(
  //       title: Text("Grade № $elementCount"),
  //     )
  //   );
  // }
}
