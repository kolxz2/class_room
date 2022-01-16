import 'dart:ui';

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
                      title: Stack(
                        children: <Widget>[
                          Align(
                            alignment: const Alignment(0.8, 0.5),
                            child:
                              IconButton(
                              icon: const Icon(
                                Icons.info,
                                color: Colors.pink,
                              ),
                              onPressed: (){
                                setState(() {
                                todoList.removeAt(index);
                                });
                              }
                              ),
                          ),

                          Align(
                            alignment: const Alignment(0.9, 0.5),
                            child:
                            IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.red,
                                ),
                                onPressed: (){
                                  _editGrades(context);
                                }
                            ),
                          ),
                          Align(
                            alignment: const Alignment(1, 0.5),
                            child:
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

  void _editGrades(BuildContext context){
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
  }
}
