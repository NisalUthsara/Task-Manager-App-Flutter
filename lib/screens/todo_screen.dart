import 'package:flutter/material.dart';
import 'package:task_manager_app_flutter/widgets/todo_card.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final textInputController = TextEditingController();
  List<String> _tasks = [];
  List<bool> _completed = [];

  void _addTask() {
    if (textInputController.text.isNotEmpty) {
      setState(() {
        _tasks.add(textInputController.text);
        _completed.add(false);
      });
      textInputController.clear();
    }
  }

  void _toggleTask(int index) {
    setState(() {
      _completed[index] = !_completed[index];
    });
  }

  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
      _completed.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Work For Your Success',
          style: TextStyle(
            fontSize: 32,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Top tasks adding container
              Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 43, 43, 43),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 3,
                      blurRadius: 16,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: textInputController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Add a task',
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                        ),
                        onSubmitted: (_) => _addTask(),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add, color: Colors.white),
                      onPressed: _addTask,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 60),
              //tasks panel goes here
              Expanded(
                child: _tasks.isEmpty
                    ? const Center(
                        child: Text(
                          'No tasks yet!\nAdd some tasks.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _tasks.length,
                        itemBuilder: (context, index) {
                          return TodoCard(
                            title: _tasks[index],
                            isMarked: _completed[index],
                            onToggle: () => _toggleTask(index),
                            onDelete: () => _deleteTask(index),
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
