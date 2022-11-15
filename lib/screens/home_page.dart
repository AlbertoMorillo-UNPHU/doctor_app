import 'package:doctor_app/controller/todo_controller.dart';
import 'package:doctor_app/repository/todo_repository.dart';
import 'package:flutter/material.dart';

import '../models/todo.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var todoController = TodoController(TodoRepository());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rest API'),
      ),
      body: FutureBuilder<List<Todo>>(
        future: todoController.fetchTodoList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text("Error"),
            );
          }

          return buildBodyContext(snapshot, todoController);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          Todo todo = Todo(userId: 3, title: "sample post", completed: false);
          todoController.postTodo(todo);
        }),
        child: const Icon(Icons.add),
      ),
    );
  }

  SafeArea buildBodyContext(
      AsyncSnapshot<List<Todo>> snapshot, TodoController todoController) {
    return SafeArea(
      child: ListView.separated(
        itemBuilder: (context, index) {
          var todo = snapshot.data?[index];
          print(todo);
          return Container(
            height: 100.0,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(flex: 1, child: Text("${todo?.id}")),
                Expanded(flex: 3, child: Text("${todo?.title}")),
                Expanded(
                    flex: 3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                            onTap: () {
                              todoController
                                  .updatePatchCompleted(todo!)
                                  .then((value) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        duration:
                                            const Duration(microseconds: 500),
                                        content: Text(value)));
                              });
                            },
                            child: buildCallContainer("patch", Colors.orange)),
                        InkWell(
                            onTap: () {
                              todoController.updatePutCompleted(todo!);
                            },
                            child: buildCallContainer("put", Colors.purple)),
                        InkWell(
                            onTap: () {
                              todoController.deleteTodo(todo!).then((value) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        duration:
                                            const Duration(microseconds: 500),
                                        content: Text(value)));
                              });
                            },
                            child: buildCallContainer("del", Colors.red)),
                      ],
                    ))
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider(
            thickness: 0.5,
            height: 0.5,
          );
        },
        itemCount: snapshot.data?.length ?? 0,
      ),
    );
  }

  Container buildCallContainer(String name, Color color) {
    return Container(
      width: 40.0,
      height: 40.0,
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(10.0)),
      child: Center(child: Text(name)),
    );
  }
}
