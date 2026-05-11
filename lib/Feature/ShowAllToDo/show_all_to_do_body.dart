import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_project/Feature/Auth/Login/login_screen.dart';
import 'package:to_do_project/Feature/ShowAllToDo/show_all_to_do_model.dart';

class ShowAllToDoBody extends StatefulWidget {
  const ShowAllToDoBody({super.key});

  @override
  State<ShowAllToDoBody> createState() => _ShowAllToDoBodyState();
}

class _ShowAllToDoBodyState extends State<ShowAllToDoBody> {
  Future<void> toggleCompleted(TodoModel todo) async {
    final index = todos.indexWhere((e) => e.id == todo.id);

    setState(() {
      todos[index] = TodoModel(
        userId: todo.userId,
        id: todo.id,
        title: todo.title,
        completed: !todo.completed,
      );
    });

    try {
      await dio.put(
        '/todos/${todo.id}',
        data: {
          "userId": todo.userId,
          "id": todo.id,
          "title": todo.title,
          "completed": !todo.completed,
        },
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> addTodo() async {
    TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Todo'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: 'Enter todo title'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),

            ElevatedButton(
              onPressed: () async {
                try {
                  final response = await dio.post(
                    '/todos',
                    data: {
                      "userId": 1,
                      "title": controller.text,
                      "completed": false,
                    },
                  );

                  final newTodo = TodoModel.fromJson(response.data);

                  setState(() {
                    todos.insert(0, newTodo);
                  });

                  Navigator.pop(context);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Todo Added Successfully')),
                  );
                } catch (e) {
                  debugPrint(e.toString());
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  Future<void> deleteTodo(int id) async {
    try {
      await dio.delete('/todos/$id');

      setState(() {
        todos.removeWhere((element) => element.id == id);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Todo Deleted Successfully')),
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> updateTodo(TodoModel todo) async {
    TextEditingController controller = TextEditingController(text: todo.title);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Update Todo'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: 'Enter new title'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),

            ElevatedButton(
              onPressed: () async {
                try {
                  final response = await dio.put(
                    '/todos/${todo.id}',
                    data: {
                      "userId": todo.userId,
                      "id": todo.id,
                      "title": controller.text,
                      "completed": todo.completed,
                    },
                  );

                  final updatedTodo = TodoModel.fromJson(response.data);

                  final index = todos.indexWhere(
                    (element) => element.id == todo.id,
                  );

                  setState(() {
                    todos[index] = updatedTodo;
                  });

                  Navigator.pop(context);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Todo Updated Successfully')),
                  );
                } catch (e) {
                  debugPrint(e.toString());
                }
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }

  final Dio dio = Dio(
    BaseOptions(baseUrl: 'https://jsonplaceholder.typicode.com'),
  );

  List<TodoModel> todos = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getTodos();
  }

  Future<void> getTodos() async {
    try {
      final response = await dio.get('/todos');

      todos = (response.data as List)
          .map((e) => TodoModel.fromJson(e))
          .toList();

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  ////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 227, 218, 226),

      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();
              await prefs.remove('userId');
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
            icon: Icon(
              Icons.logout,
              color: const Color.fromARGB(255, 57, 2, 62),
            ),
          ),
        ],
        backgroundColor: const Color.fromARGB(255, 190, 130, 195),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'My Todo List',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 190, 130, 195),
        onPressed: addTodo,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    const SizedBox(height: 20),

                    /// TODOS
                    Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        itemCount: todos.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final todo = todos[index];

                          return Dismissible(
                            key: ValueKey(todo.id),

                            direction: DismissDirection.horizontal,

                            /// 🔴 Delete (يسار)
                            background: Container(
                              margin: const EdgeInsets.symmetric(vertical: 6),
                              padding: const EdgeInsets.only(left: 20),
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 28,
                              ),
                            ),

                            /// 🟢 Edit (يمين)
                            secondaryBackground: Container(
                              margin: const EdgeInsets.symmetric(vertical: 6),
                              padding: const EdgeInsets.only(right: 20),
                              alignment: Alignment.centerRight,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                                size: 28,
                              ),
                            ),

                            confirmDismiss: (direction) async {
                              if (direction == DismissDirection.endToStart) {
                                // 👉 Delete
                                return await showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text("Delete Todo?"),
                                    content: const Text(
                                      "Are you sure you want to delete this item?",
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, false),
                                        child: const Text("Cancel"),
                                      ),
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, true),
                                        child: const Text(
                                          "Delete",
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                // 👉 Edit
                                updateTodo(todo);
                                return false; // ما نحذف الكارد
                              }
                            },

                            onDismissed: (direction) {
                              if (direction == DismissDirection.endToStart) {
                                deleteTodo(todo.id);
                              }
                            },

                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 6),
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: LinearGradient(
                                  colors: todo.completed
                                      ? [
                                          const Color.fromARGB(
                                            255,
                                            92,
                                            3,
                                            70,
                                          ).withOpacity(0.08),
                                          const Color.fromARGB(
                                            255,
                                            33,
                                            1,
                                            34,
                                          ).withOpacity(0.03),
                                        ]
                                      : [
                                          const Color.fromARGB(
                                            255,
                                            174,
                                            158,
                                            172,
                                          ),
                                          const Color.fromARGB(
                                            255,
                                            206,
                                            192,
                                            203,
                                          ),
                                        ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 12,
                                    offset: const Offset(0, 6),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  /// CHECK
                                  Column(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                            255,
                                            17,
                                            1,
                                            26,
                                          ).withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        child: Text(
                                          '#${todo.id}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),

                                      const SizedBox(height: 10),

                                      GestureDetector(
                                        onTap: () => toggleCompleted(todo),
                                        child: AnimatedContainer(
                                          duration: const Duration(
                                            milliseconds: 200,
                                          ),
                                          height: 28,
                                          width: 28,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: todo.completed
                                                ? const Color.fromARGB(
                                                    255,
                                                    119,
                                                    167,
                                                    121,
                                                  )
                                                : Colors.transparent,
                                            border: Border.all(
                                              color: todo.completed
                                                  ? Colors.green
                                                  : Colors.grey.shade400,
                                              width: 2,
                                            ),
                                          ),
                                          child: todo.completed
                                              ? const Icon(
                                                  Icons.check,
                                                  size: 16,
                                                  color: Colors.white,
                                                )
                                              : null,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 14),

                                  /// TITLE
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          todo.title,
                                          style: TextStyle(
                                            decoration: todo.completed
                                                ? TextDecoration.lineThrough
                                                : null,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: todo.completed
                                                ? const Color.fromARGB(
                                                    255,
                                                    75,
                                                    1,
                                                    67,
                                                  )
                                                : Colors.black87,
                                          ),
                                        ),

                                        const SizedBox(height: 6),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
