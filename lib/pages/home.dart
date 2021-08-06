import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String _userToDo = "";
  List todoList = [];
  
  @override
  void initState() { // первоначальное состояние    
    super.initState();
    todoList.addAll(['Купить молока','Купить картошку','Пойти на работу']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('Список дел'),
        centerTitle: true,
      ),
      body: ListView.builder( // сразу список
          itemCount: todoList.length, // количество елементов
          itemBuilder: (BuildContext context, int index) { //как будет построен список
            return Dismissible( // свайпуть
                key: Key(todoList[index]), // елемент списка
                child: Card(               //дизайн - созд карточку
                  child: ListTile(title: Text(todoList[index]),   // только заголовок карточки + иконка удаления
                                  trailing: IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.deepOrange
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        todoList.removeAt(index); // удаление по иконке
                                      });
                                    },
                  )),
                ),
              onDismissed: (direction){ //обработчик события удаления
                //if(direction == DismissDirection.endToStart)
                setState(() {
                  todoList.removeAt(index); //удаление
                });
              },
            );
          }
      ),
        floatingActionButton: FloatingActionButton( // кнопка для добавления всплывающего окна чтобы добавить в список
          backgroundColor: Colors.greenAccent,
          onPressed: (){
            showDialog(context: context, builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Добавить елемент'),
                content: TextField(  // поле ввода
                  onChanged: (String value) {
                    _userToDo = value; // добавить значение
                  },
                ),
                actions: [ // список виджетов
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          todoList.add(_userToDo);
                        });
                        Navigator.of(context).pop(); // закрыть всплывающие окна
                      },
                      child: Text('Добавить'))
                ],
              );
            }); // всплывающее диалоговое окно
          },
          child: Icon(
            Icons.add_box,
          color: Colors.white
          )
        ),
    );
  }
}
